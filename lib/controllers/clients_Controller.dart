// ignore_for_file: file_names, non_constant_identifier_names, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobranzas/controllers/user_controller.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// ignore: camel_case_types
class clientsController extends GetxController {
  static clientsController get instanc => Get.put(clientsController());
  UserController get userController => Get.put(UserController());
  User? user = FirebaseAuth.instance.currentUser;
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
  late TextEditingController fecha_nacimiento = TextEditingController();
  final numero_tel = TextEditingController();
  //todo: filtrar/
  final filtrar = TextEditingController();
  int indexCustomer = 0;

  //todo: clase Editar clientes/
  late TextEditingController Editcodigo_cliente = TextEditingController();
  late TextEditingController EditNombre = TextEditingController();
  late TextEditingController EditApellido_m = TextEditingController();
  late TextEditingController EditApellido_p = TextEditingController();
  late TextEditingController EditGenero = TextEditingController();
  late TextEditingController EditCurp = TextEditingController();
  late TextEditingController EditCalle = TextEditingController();
  late TextEditingController EditColonia = TextEditingController();
  late TextEditingController EditMunicipio_delegacion = TextEditingController();
  late TextEditingController EditEstado = TextEditingController();
  late TextEditingController EditCodigo_postal = TextEditingController();
  late TextEditingController EditFecha_nacimiento = TextEditingController();
  late TextEditingController EditNumero_tel = TextEditingController();

  Future showDeleteMessage(String mensaje, String codigo_Cliente) async {
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
        deleteClient(codigo_Cliente).then((_) {
          Get.back();
        });
      },

      barrierDismissible: false,
      //
    );
  }

  Future deleteClient(String codigo_cliente) async {
    try {
      // Obtenemos una referencia a la colección "Clientes"
      CollectionReference clientesRef =
          FirebaseFirestore.instance.collection('Clientes');

      // Realizamos una consulta para obtener el documento con el campo "codigo_Cliente" igual a codigoCliente
      QuerySnapshot querySnapshot = await clientesRef
          .where('codigo_Cliente', isEqualTo: codigo_cliente)
          .get();

      // Verificamos si se encontró algún documento
      if (querySnapshot.docs.isNotEmpty) {
        // Si se encontró al menos un documento, eliminamos el primero encontrado
        DocumentSnapshot documentoAEliminar = querySnapshot.docs.first;
        await documentoAEliminar.reference.delete();

        print('Documento eliminado exitosamente');
      } else {
        print(
            'No se encontraron documentos con el código de cliente especificado');
      }
    } catch (e) {
      print('Error al eliminar el documento: $e');
    }
  }

  /*  Future<bool> isCodigoClienteUnique(String codigoCliente) async {
    final idSuperUsuario = user!.uid;

    final querySnapshot = await FirebaseFirestore.instance
        .collection('Clientes')
        .where('codigo_Cliente', isEqualTo: codigoCliente)
        .get();
    return querySnapshot.docs.isEmpty;
  } */
  Future<bool> isCodigoClienteUnique(String codigoCliente) async {
    try {
      final String idSuperUsuario =
          user!.uid; // Supongo que aquí obtienes el ID del usuario actual
      final esSuperUser = await userController.esSuperUsuario();

      if (esSuperUser) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('Clientes')
            .where('codigo_Cliente', isEqualTo: codigoCliente)
            .where('id_SuperUsuario', isEqualTo: idSuperUsuario)
            .get();
        return querySnapshot.docs.isEmpty;
      } else {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('Clientes')
            .where('codigo_Cliente', isEqualTo: codigoCliente)
            .get();
        return querySnapshot.docs.isEmpty;
      }
    } catch (e) {
      print('Error al verificar la unicidad del código de cliente: $e');
      return false; // Retorna false en caso de error
    }
  }

  Future<bool> createClient({
    /* required String codigo_cliente, */
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
    required BuildContext context,
  }) async {
    try {
      String uIdUserActivo = user!.uid;
      final esSuperUser = await userController.esSuperUsuario();
      /*  final isUnique = await isCodigoClienteUnique(codigo_cliente); */
      String id_Cliente = database.collection('Clientes').doc().id;
      /* if (!isUnique) {
        Get.back();
        authenticationRepository.showMessage(
          "Aviso",
          "necesitas ingresar otro Id del cliente",
        ); 

        return false;
      }*/

      if (esSuperUser) {
        if (user != null) {
          await database.collection('Clientes').doc(id_Cliente.toString()).set({
            'codigo_Cliente': id_Cliente.toString(),
            'nombre_Cliente': nombre,
            'apellido_p_Cliente': apellido_m,
            'apellido_m_Cliente': apellido_p,
            'genero_Cliente': genero,
            'curp_Cliente': curp,
            'calle_Cliente': calle,
            'colonia_Cliente': colonia,
            'municipio_deleg_Cliente': municipio_delegacion,
            'estado_Cliente': estado,
            'codigo_p_Cliente': codigo_postal,
            'fecha_n_Cliente': fecha_nacimiento,
            'telefono_Cliente': numero_tel,
            'url_foto_Cliente': imageUrl,
            'id_SuperUsuario': uIdUserActivo,
            'id_Usuario_Registro': uIdUserActivo
          });
          return true;
        }
        return false;
      } else {
        if (user != null) {
          CollectionReference usersCollection =
              FirebaseFirestore.instance.collection('Usuarios');
          DocumentSnapshot userSnapshot =
              await usersCollection.doc(uIdUserActivo).get();

          if (userSnapshot.exists) {
            final idSuperUsuario = userSnapshot.get('id_SuperUsuario');
            final rollSuperUsuario = userSnapshot.get('roll');

            await database
                .collection('Clientes')
                .doc(id_Cliente.toString())
                .set({
              'codigo_Cliente': id_Cliente.toString(),
              'nombre_Cliente': nombre,
              'apellido_p_Cliente': apellido_m,
              'apellido_m_Cliente': apellido_p,
              'genero_Cliente': genero,
              'curp_Cliente': curp,
              'calle_Cliente': calle,
              'colonia_Cliente': colonia,
              'municipio_deleg_Cliente': municipio_delegacion,
              'estado_Cliente': estado,
              'codigo_p_Cliente': codigo_postal,
              'fecha_n_Cliente': fecha_nacimiento,
              'telefono_Cliente': numero_tel,
              'url_foto_Cliente': imageUrl,
              'id_SuperUsuario': idSuperUsuario,
              'id_Usuario_Registro': uIdUserActivo,
            });
            return true;
          } else {
            print("no se encontraron los datos");
            return false;
          }
        }
        return false;
      }
    } catch (e) {
      printError(info: "${e.hashCode}");
      return false;
    }
  }

  Stream<QuerySnapshot> getClients() {
    return FirebaseFirestore.instance.collection("Clientes").snapshots();
  }

  Future<List<Map<String, dynamic>>> obtenerUltimosCincoRegistros() async {
    List<Map<String, dynamic>> ultimosCincoRegistros = [];
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Clientes')
        .where('id_Usuario_Registro', isEqualTo: uid)
        .orderBy(FieldPath.documentId,
            descending:
                true) // Ordenar por ID de documento, que contiene una marca de tiempo
        .limit(5) // Limitar a los últimos 5 registros
        .get();

    for (var doc in querySnapshot.docs) {
      // Convertir el objeto a un Map<String, dynamic>
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        ultimosCincoRegistros.add(data);
      }
    }

    return ultimosCincoRegistros;
  }

  Future<List> showLastFiveClients() async {
    final superUser = await userController.esSuperUsuario();
    List readClients = [];

    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;

    if (superUser == true) {
      QuerySnapshot queryClients = await database
          .collection('Clientes')
          .where('id_Usuario_Registro', isEqualTo: uid)
          .orderBy(FieldPath.documentId,
              descending:
                  true) // Ordenar por ID de documento, que contiene una marca de tiempo
          .limit(5) // Limitar a los últimos 5 registros
          .get();

      for (var documento in queryClients.docs) {
        if (documento.data() != null) {
          readClients.add(documento.data());
        } else {
          readClients = [];
        }
      }
    } else {
      QuerySnapshot queryClients = await database
          .collection('Clientes')
          .where('id_Usuario_Registro', isEqualTo: uid)
          .orderBy(FieldPath.documentId,
              descending:
                  true) // Ordenar por ID de documento, que contiene una marca de tiempo
          .limit(5) // Limitar a los últimos 5 registros
          .get();

      for (var documento in queryClients.docs) {
        if (documento.data() != null) {
          readClients.add(documento.data());
        } else {
          readClients = [];
        }
      }
    }

    return readClients;
  }

  Future<List> showClientes() async {
    try {
      bool? isSuperUser = await userController.esSuperUsuario();
      List readClients = [];
      String id_SuperUsuario;
      String usuarioRealizoRegistro;
      User? user = FirebaseAuth.instance.currentUser;
      String uid = user!.uid;

      if (isSuperUser == true) {
        printInfo(info: "Id superUsuario para clientes");
        id_SuperUsuario = uid;

        CollectionReference CollectionReferenceClients =
            database.collection("Clientes");
        QuerySnapshot queryClients = await CollectionReferenceClients.where(
                "id_SuperUsuario",
                isEqualTo: id_SuperUsuario)
            .get();

        for (var documento in queryClients.docs) {
          readClients.add(documento.data());
        }
      } else {
        printInfo(info: "Id Usuarios para clientes");

        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection("Usuarios")
            .doc(uid)
            .get();
        usuarioRealizoRegistro = uid;

        CollectionReference CollectionReferenceClients =
            database.collection("Clientes");
        QuerySnapshot queryClients = await CollectionReferenceClients.where(
                "id_Usuario_Registro",
                isEqualTo: usuarioRealizoRegistro)
            .get();

        for (var documento in queryClients.docs) {
          readClients.add(documento.data());
        }
      }

      printInfo(info: "$readClients");
      return readClients;
    } catch (e) {
      printError(info: " $e");
      return [];
    }
  }

  /* Future<Object> TakePhoto(String imageUrl) async {
    //tomar fotografia con la camara
    try {
      ImagePicker imageCustomer = ImagePicker();

      XFile? file = await imageCustomer.pickImage(source: ImageSource.camera);

      if (file == null) {
        printError(info: "NO HAY IMAGEN");
        return "";
      }

      imageUrl = file.path;
    } catch (e) {
      e.hashCode.toString();
      ImagePicker imageCustomer = ImagePicker();

      XFile? file = await imageCustomer.pickImage(source: ImageSource.gallery);
      if (file == null) {
        printError(info: "NO HAY IMAGEN");

        return "";
      }

      imageUrl = file.path;
    }
    return imageUrl;
  } */
  Future<String?> takePhoto() async {
    try {
      final ImagePicker picker = ImagePicker();
      final ImageSource? source = await Get.bottomSheet<ImageSource>(
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Cámara'),
                onTap: () => Get.back(result: ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Galería'),
                onTap: () => Get.back(result: ImageSource.gallery),
              ),
            ],
          ),
        ),
      );

      if (source == null) {
        printError(info: "No se seleccionó ninguna opción");
        return "";
      }

      final XFile? file = await picker.pickImage(source: source);

      if (file == null) {
        printError(info: "No se seleccionó ninguna imagen");
        return "";
      }

      return file.path;
    } catch (e) {
      printError(info: "Error al tomar la foto: $e");
      return "";
    }
  }

  Future<Object> uploadPhoto(String imageUrl) async {
    try {
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImage = referenceRoot.child("images");

      Reference referenceImageToUpload =
          referenceDirImage.child(uniqueFileName);

      await referenceImageToUpload
          .putFile(File(imageUrl))
          .whenComplete(() => printInfo(info: "Se termino de subir"));
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (e) {
      printError(info: "$e error referenceImageToUpload ");
    }

    if (imageUrl != "") {
      printInfo(info: "SI EXISTE IMAGEN");
      printInfo(info: imageUrl);
    } else {
      printError(info: "NO HAY  LA IMAGEN");
    }

    return imageUrl;
  }

  Future<bool> updateClient({
    required String idClient,
    required String nombre,
    required String apellidoP,
    required String apellidoM,
    required String genero,
    required String curp,
    required String calle,
    required String colonia,
    required String municipioDelg,
    required String estado,
    required int codigoPostal,
    required DateTime fechaNacimiento,
    required int tel,
  }) async {
    try {
      await database.collection('Clientes').doc(idClient).update({
        'nombre_Cliente': nombre,
        'apellido_p_Cliente': apellidoP,
        'apellido_m_Cliente': apellidoM,
        'genero_Cliente': genero,
        'curp_Cliente': curp,
        'calle_Cliente': calle,
        'colonia_Cliente': colonia,
        'municipio_deleg_Cliente': municipioDelg,
        'estado_Cliente': estado,
        'codigo_p_Cliente': codigoPostal,
        'fecha_n_Cliente': fechaNacimiento,
        'telefono_Cliente': tel,
      });

      print("Información del cliente actualizada exitosamente.");

      return true;
    } on FirebaseException catch (e) {
      print("Error de Firebase al actualizar la información del cliente: $e");
      return false;
    } catch (e) {
      print("Error al actualizar la información del cliente: $e");
      return false;
    }
  }
}
