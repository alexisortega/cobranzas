// ignore_for_file: file_names, non_constant_identifier_names, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// ignore: camel_case_types
class clientsController extends GetxController {
  static clientsController get instance => Get.put(clientsController());

  FirebaseFirestore database = FirebaseFirestore.instance;

  final codigo_cliente = TextEditingController();
  final nombre = TextEditingController();
  final apellido_m = TextEditingController();
  final apellido_p = TextEditingController();
  final genero = TextEditingController();
  final curp = TextEditingController();
  final calle = TextEditingController();
  final colonia = TextEditingController();
  final municipio_delegacion = TextEditingController();
  final estado = TextEditingController();
  final codigo_postal = TextEditingController();
  final fecha_nacimiento = TextEditingController();
  final numero_tel = TextEditingController();
  //fitrar
  final filtrar = TextEditingController();
  int indexCustomer = 0;

  Future showDeleteMessage(String mensaje, String codigo_cliente) async {
    await Get.defaultDialog(
      title: "Eliminar",
      titleStyle: const TextStyle(fontSize: 25),
      middleText: mensaje,
      middleTextStyle: const TextStyle(fontSize: 20),
      backgroundColor: Colors.blue.withOpacity(.6),
      radius: 25,
      textCancel: "Cancelar",
      cancelTextColor: Colors.white,
      textConfirm: "Aceptar",
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        deleteClient(codigo_cliente).then((_) {
          Get.back();
        });
      },

      barrierDismissible: false,
      //
    );
  }

  Future deleteClient(String codigo_cliente) async {
    final deleteClients = database.collection("clientes").doc(codigo_cliente);
    await deleteClients.delete();
  }

  Future createClients({
    required String codigo_cliente,
    required String nombre,
    required String apellido_m,
    required String apellido_p,
    required String genero,
    required String curp,
    required String calle,
    required String colonia,
    required String municipio_delegacion,
    required String estado,
    required int codigo_postal,
    required DateTime fecha_nacimiento,
    required int numero_tel,
    required String imageUrl,
    /*  required double monto_inicial,
    required double interes_asignado,
    required double monto_solicitado,
    required String plazos,
    required DateTime fecha_prestamo,
    required List<String> dias_semana,*/
  }) async {
    try {
      await database.collection('clientes').doc(codigo_cliente).set({
        'codigo_cliente': codigo_cliente,
        'nombre': nombre,
        'apellido_m': apellido_m,
        'apellido_p': apellido_p,
        'genero': genero,
        'curp': curp,
        'calle': calle,
        'colonia': colonia,
        'municipio_delegacion': municipio_delegacion,
        'estado': estado,
        'codigo_postal': codigo_postal,
        'fecha_nacimiento': fecha_nacimiento,
        'numero_tel': numero_tel,
        'foto_url': imageUrl,
        /*'interes_asignado': interes_asignado,
        'monto_solicitado': monto_solicitado,
        'monto_inicial': monto_inicial,
        'plazos': plazos,
        'fecha_prestamo': fecha_prestamo,
        'dias_semana': dias_semana,*/
      });
    } catch (e) {
      print(e.hashCode.toString());
    }

    /* Future funcion_prueba(
        {required String codigo_cliente,
        required String nombre,
        required String apellido_m,
        required String apellido_p,
        required String curp,
        required String calle,
        required String colonia,
        required String municipio_delegacion,
        required String estado,
        required int codigo_postal,
        required DateTime fecha_nacimiento,
        required double monto_inicial,
        required double interes_asignado,
        required double monto_solicitado,
        required int numero_tel,
        required String plazos,
        required DateTime fecha_prestamo}) async {
      print("codigo cliente $codigo_cliente");
      print("nombre $nombre");
      print("apellido_m $apellido_m");
      print("apellido_p $apellido_p");
      print("Curp $curp");
      print("Calle $calle");
      print("colonia $colonia");
      print("municipio $municipio_delegacion");
      print("estado $estado");
      print("codigo postal-$codigo_postal");
      print("fecha nacimiento $fecha_nacimiento");
      print("mont inicial $monto_inicial");
      print("interes $interes_asignado");
      print("monto solicitado $monto_solicitado");
      print("numero de tel $numero_tel");
      print("plazos $plazos");
      print("fecha prestamo $fecha_prestamo");
    }*/
  }

  Stream<QuerySnapshot> getClients() {
    return FirebaseFirestore.instance.collection("clientes").snapshots();
  }

  Future<List> showClientes() async {
    List readClients = [];
    CollectionReference CollectionReferenceClients =
        database.collection("clientes");
    QuerySnapshot queryClients = await CollectionReferenceClients.get();
    for (var documento in queryClients.docs) {
      readClients.add(documento.data());
    }
    return readClients;
  }

  Future<Object> TakePhoto(String imageUrl) async {
    //tomar fotografia con la camara
    try {
      ImagePicker imageCustomer = ImagePicker();

      XFile? file = await imageCustomer.pickImage(source: ImageSource.camera);

      if (file == null) {
        print("NO HAY IMAGEN");
        return "";
      }

      imageUrl = file.path;
    } catch (e) {
      e.hashCode.toString();
      ImagePicker imageCustomer = ImagePicker();

      XFile? file = await imageCustomer.pickImage(source: ImageSource.gallery);
      if (file == null) {
        print("NO HAY IMAGEN");
        return "";
      }

      imageUrl = file.path;
    }
    return imageUrl;
  }

  Future<Object> UploadPhoto(String imageUrl) async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child("images");

    Reference referenceImageToUpload = referenceDirImage.child(uniqueFileName);

    try {
      await referenceImageToUpload
          .putFile(File(imageUrl))
          .whenComplete(() => print("Se termino de subir"));
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (e) {
      print("$e error referenceImageToUpload ");
    }

    if (imageUrl != "") {
      print("SI EXISTE IMAGEN");
      print(imageUrl);
    } else {
      print("NO HAY  LA IMAGEN");
    }

    return imageUrl;
  }
}
