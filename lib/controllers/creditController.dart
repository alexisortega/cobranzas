// ignore_for_file: camel_case_types, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobranzas/models/clients_dias_semana.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class creditController extends GetxController {
  FirebaseFirestore database = FirebaseFirestore.instance;

  final codigoCredito = TextEditingController();
  final interesAsignado = TextEditingController();
  final montoSolicitado = TextEditingController();
  final fechaPrestamo = TextEditingController();
  final filterCategory = TextEditingController();
  final numeroPagos = TextEditingController();
  final filtrarCreditos = TextEditingController();

  String search = "";

  List<DiasSeman> listaDiasSemana = [
    DiasSeman(id: 1, nombre: "Lunes"),
    DiasSeman(id: 2, nombre: "Martes"),
    DiasSeman(id: 3, nombre: "Miercoles"),
    DiasSeman(id: 4, nombre: "Jueves"),
    DiasSeman(id: 5, nombre: "Viernes"),
    DiasSeman(id: 6, nombre: "Sabado"),
    DiasSeman(id: 7, nombre: "Domingo")
  ];

  List<dynamic> selectedDias = [];
  var selectedDiasSemanaValue = ''.obs;

  Stream<List> getCredits() {
    final CollectionReference collectionReferenceCredits =
        database.collection('Creditos');
    return collectionReferenceCredits
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      final List readcredits = [];
      for (var document in querySnapshot.docs) {
        readcredits.add(document.data());
      }
      return readcredits;
    });
  }

  Future createCredits({
    required String codigoCredito,
    required String propietarioCredito,
    required double montoSolicitado,
    required double interesAsignado,
    required List<String> diasSemana,
    required DateTime fechaPrestamo,
    required String? plazos,
    required int numeroPagos,
    required String status,
  }) async {
    try {
      //
      await database.collection('Creditos').doc(codigoCredito).set({
        //

        'codigo_credito': codigoCredito,
        'propietario_credito': propietarioCredito,
        'monto_solicitado': montoSolicitado,
        'interes_asignado': interesAsignado,
        'plazos': plazos,
        'dias_semana': diasSemana,
        'fecha_prestamo': fechaPrestamo,
        'numero_pagos': numeroPagos,
        'status': status,

        //
      });
    } catch (e) {
      e.hashCode.toString();
    }
  }
}
