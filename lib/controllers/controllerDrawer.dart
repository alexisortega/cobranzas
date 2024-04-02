// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Drawercontroller extends GetxController {
  FirebaseFirestore database = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> obtenerDatosUsuario(String uid) async {
    try {
      // Verificar si el usuario es superusuario
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('SuperUsuarios')
          .doc(uid)
          .get();

      if (userSnapshot.exists) {
        // Si es superusuario, obtén los datos directamente
        return {
          'nombre_SuperUsuario': userSnapshot['nombre_c_SuperUsuario'],
          'correo_SuperUsuario': userSnapshot['correo_SuperUsuario'],
          'roll_SuperUsuario': userSnapshot['roll'],
        };
      } else {
        // Si no es superusuario, obtén el ID del superusuario
        DocumentSnapshot normalUserSnapshot = await FirebaseFirestore.instance
            .collection('Usuarios')
            .doc(uid)
            .get();

        if (normalUserSnapshot.exists) {
          return {
            'nombre': normalUserSnapshot['nombre'],
            'correo': normalUserSnapshot['correo'],
            'roll': normalUserSnapshot['roll'],
          };
        }
      }

      // Si no se encontraron datos válidos, devuelve un mapa vacío
      return {};
    } catch (e) {
      // Manejar cualquier error
      printError(info: 'Error al obtener datos del usuario: $e');
      return {};
    }
  }

  Stream<Map<String, dynamic>> obtenerDatosUsuarioStream() {
    return Stream<Map<String, dynamic>>.fromFuture(
        Future<Map<String, dynamic>>(() async {
      try {
        String uid = FirebaseAuth.instance.currentUser!.uid;

        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('SuperUsuarios')
            .doc(uid)
            .get();

        if (userSnapshot.exists) {
          // Si es superusuario, obtén los datos directamente
          return {
            'nombre_SuperUsuario': userSnapshot['nombre_c_SuperUsuario'],
            'correo_SuperUsuario': userSnapshot['correo_SuperUsuario'],
            'roll_SuperUsuario': userSnapshot['roll'],
          };
        } else {
          // Si no es superusuario, obtén el ID del superusuario
          DocumentSnapshot normalUserSnapshot = await FirebaseFirestore.instance
              .collection('Usuarios')
              .doc(uid)
              .get();

          if (normalUserSnapshot.exists) {
            return {
              'nombre': normalUserSnapshot['nombre'],
              'correo': normalUserSnapshot['correo'],
              'roll': normalUserSnapshot['roll'],
            };
          }
        }

        // Si no se encontraron datos válidos, devuelve un mapa vacío
        return {};
      } catch (e) {
        // Manejar cualquier error
        printError(info: 'Error en obtenerDatosUsuarioStream: $e');
        return {}; // Devuelve un mapa vacío en caso de error
      }
    }));
  }

  Future<bool> esSuperUsuario() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userData = await FirebaseFirestore.instance
          .collection('SuperUsuarios')
          .doc(user.uid)
          .get();

      if (userData.exists) {
        final roll = userData.get('roll') as String?;
        if (roll != null && roll == 'Superusuario') {
          return true;
        }
      }
    }

    return false;
  }
}
