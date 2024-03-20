import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobranzas/repository/authentication.dart';

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
        // authenticationRepository.showMessage("Aviso", "Se guardo con éxito");
      }
    } catch (e) {
      print.printInfo(info: "Error al guardar los cambios en Firestore: $e");
      // Muestra un mensaje de error si ocurre un problema
      /* authenticationRepository.showMessage(
          "Advertencia", "No se pudo guardar los cambios $e"); */
    }
  }
}
