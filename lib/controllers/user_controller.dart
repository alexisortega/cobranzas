import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final nuevoTipoUsuario = TextEditingController();

  Future<Map<String, dynamic>> getPrivilegiosFromFirestore() async {
    final auth1 = FirebaseAuth.instance;
    User? currentUser = auth1.currentUser;
    final uid = currentUser!.uid;
    try {
      final FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentSnapshot docSnapshot =
          await db.collection('SuperUsuarios').doc(uid).get();

      if (docSnapshot.exists) {
        final dynamic privilegiosData = docSnapshot.data();
        return Map<String, dynamic>.from(privilegiosData?['privilegios'] ?? {});
      } else {
        return {};
      }
    } catch (e) {
      print.printInfo(info: "Error al obtener privilegios desde Firestore: $e");
      throw Exception("Error al obtener privilegios desde Firestore");
    }
  }

  Future<void> savePrivilegeChanges(privilegios, context) async {
    try {
      //regresa el usuario que esta activo
      final auth = FirebaseAuth.instance;
      final userId = auth.currentUser?.uid;

      if (userId != null) {
        final db = FirebaseFirestore.instance;

        // Actualiza los privilegios en Firestore
        await db.collection('SuperUsuarios').doc(userId).update({
          'privilegios': privilegios,
        });

        // Muestra un mensaje de éxito
        authenticationRepository.showMessage(
            "Aviso", "! Guardado exitosamente !", context);
      }
    } catch (e) {
      print.printInfo(info: "Error al guardar los cambios en Firestore: $e");
      // Muestra un mensaje de error si ocurre un problema
      authenticationRepository.showMessage(
          "Advertencia", "No se pudo guardar los cambios", context);
    }
  }

// Método para actualizar el campo de privilegios en Firestore
  Future<void> registerNewTypeUser(bool actualizar, bool editar, bool eliminar,
      bool ver, String userType) async {
    try {
      // Acceder a la instancia de Firestore
      FirebaseFirestore db = FirebaseFirestore.instance;

      final auth1 = FirebaseAuth.instance;
      User? currentUser = auth1.currentUser;
      final uid = currentUser!.uid;

      // Obtener los datos actuales del campo "privilegios" en Firestore
      DocumentSnapshot documentSnapshot =
          await db.collection('SuperUsuarios').doc(uid).get();
      Map<String, dynamic> existingPrivileges =
          documentSnapshot.get('privilegios') ?? {};

      // Agregar el nuevo registro al mapa de privilegios
      existingPrivileges[userType] = {
        'Actualizar': actualizar,
        'Editar': editar,
        'Eliminar': eliminar,
        'Ver': ver,
      };

      // Actualizar el campo "privilegios" en Firestore con los datos actualizados
      await db.collection('SuperUsuarios').doc(uid).update({
        'privilegios': existingPrivileges,
      });
    } catch (error) {
      print.printError(info: 'Error al actualizar datos en Firestore: $error');
    }
  }

  Future<void> eliminarPerfilUsuario(String perfil) async {
    final auth1 = FirebaseAuth.instance;
    User? currentUser = auth1.currentUser;
    final uid = currentUser!.uid;
    try {
      final FirebaseFirestore db = FirebaseFirestore.instance;
      await db.collection('SuperUsuarios').doc(uid).update({
        'privilegios.$perfil': FieldValue.delete(),
      });
      print.printInfo(
          info: 'Perfil de usuario $perfil eliminado correctamente.');
    } catch (e) {
      print.printError(
          info: 'Error al eliminar el perfil de usuario $perfil: $e');
    }
  }
}
