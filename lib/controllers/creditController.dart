// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobranzas/controllers/clients_dias_semana.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class creditController extends GetxController {
  FirebaseFirestore database = FirebaseFirestore.instance;

  final codigo_credito = TextEditingController();
  final interes_asignado = TextEditingController();
  final monto_solicitado = TextEditingController();
  final fecha_prestamo = TextEditingController();
  final filterCategory = TextEditingController();
  final numero_pagos = TextEditingController();
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
        database.collection('creditos');
    return collectionReferenceCredits
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      final List readcredits = [];
      querySnapshot.docs.forEach((QueryDocumentSnapshot document) {
        readcredits.add(document.data());
      });
      return readcredits;
    });
  }

  Future createCredits({
    required String codigo_credito,
    required String propietario_credito,
    required double monto_solicitado,
    required double interes_asignado,
    required List<String> dias_semana,
    required DateTime fecha_prestamo,
    required String? plazos,
    required int numero_pagos,
  }) async {
    try {
      //
      await database.collection('creditos').doc(codigo_credito).set({
        //

        'codigo_credito': codigo_credito,
        'propietario_credito': propietario_credito,
        'monto_solicitado': monto_solicitado,
        'interes_asignado': interes_asignado,
        'plazos': plazos,
        'dias_semana': dias_semana,
        'fecha_prestamo': fecha_prestamo,
        'numero_pagos': numero_pagos,

        //
      });
    } catch (e) {
      e.hashCode.toString();
    }
  }
}
