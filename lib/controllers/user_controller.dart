import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobranzas/models/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UserController extends GetxController {
  Future<Map<String, dynamic>> getPrivilegiosFromFirestore(
      String userId) async {
    try {
      final FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentSnapshot docSnapshot =
          await db.collection('SuperUsuarios').doc(userId).get();

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

  Future<void> guardarCambios(privilegios, context) async {
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            closeIconColor: Colors.red,
            showCloseIcon: false,
            elevation: 20.5,
            backgroundColor: Constants.blueColor.withOpacity(0.8),
            content: Row(children: [
              const Center(
                child: Text(
                  'Cambios guardados con éxito',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Icon(
                Icons.check,
                color: Colors.green[500] as Color,
              )
            ]),
          ),
        );
      }
    } catch (e) {
      print.printInfo(info: "Error al guardar los cambios en Firestore: $e");
      // Muestra un mensaje de error si ocurre un problema
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.orange,
            content: Text('Error al guardar los cambios')),
      );
    }
  }
}
