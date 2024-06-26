import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserController extends GetxController {
  //TextField nuevos usuarios
  final passwordUser = TextEditingController();
  final emailUser = TextEditingController();
  final addressUser = TextEditingController();
  final fullName = TextEditingController();
  final telUser = TextEditingController();

  //TextField para nuevo perfil de usuario
  final newTypeUser = TextEditingController();
//buscar nuevos usuarios
  final serchShowUser = TextEditingController();
//editar usuarios
  final editFullNameUser = TextEditingController();
  final editEmailUser = TextEditingController();
  final editaddressUser = TextEditingController();
  final editTelUser = TextEditingController();

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

//todo: metodos para registrar nuevos usuarios//

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

  Future<List<String>> obtenerPrivilegiosUsuarioActivo() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      printError(info: "El UID del usuario actual es nulo.");
      return [];
    }

    final esSuper = await esSuperUsuario();
    String? idSuperUsuario;

    if (esSuper) {
      idSuperUsuario = uid;
      print("el UID superusuario activo es: $idSuperUsuario");
    } else {
      final usuarioDoc = await FirebaseFirestore.instance
          .collection('Usuarios')
          .doc(uid)
          .get();

      if (usuarioDoc.exists) {
        idSuperUsuario = usuarioDoc.data()?['id_SuperUsuario'];
        print("UID asociado al usuario normal es: $idSuperUsuario");
        print("El UID del usuario normal activo es: $uid");
      } else {
        printError(info: "No se encontró Usuario con el UID $uid.");
        return [];
      }
    }

    print("UID superUsuario antes de recolectar datos : $idSuperUsuario");

    final docRef = FirebaseFirestore.instance
        .collection('SuperUsuarios')
        .doc(idSuperUsuario.toString());

    try {
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final privilegios = docSnapshot.data()?['privilegios'];

        if (privilegios is Map<String, dynamic>) {
          // Obtener las claves del mapa de privilegios
          List<String> privilegiosLista = privilegios.keys.toList();

          printError(info: "Privilegios obtenidos: $privilegiosLista");
          return privilegiosLista;
        } else {
          printError(
              info: "El campo 'privilegios' no contiene un mapa válido.");
          return [];
        }
      } else {
        printError(
            info:
                "No se encontró el documento de SuperUsuario para el UID $idSuperUsuario.");
        return [];
      }
    } catch (e) {
      printError(info: "Error al obtener el documento de SuperUsuario: $e");
      return [];
    }
  }

  //todo: metod de ejemplo//

  Future<bool> registrarNuevoUsuario2(
    String email,
    String password,
    String nombre,
    String direccion,
    String telefono,
    String selectedPrivilege,
  ) async {
    bool isSuccefull = false;

    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final String uidSuperUsuario = auth.currentUser!.uid;
      // Verificar si el correo ya está registrado en Firestore
      final resultadoQuery = await firestore
          .collection('Usuarios')
          .where('correo', isEqualTo: email)
          .get();
      if (resultadoQuery.docs.isNotEmpty) {
        printError(info: 'El correo ya está registrado en Firestore.');
        isSuccefull = false;

        return isSuccefull;
      }

      // Registrar el usuario en FirebaseAuth
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Guardar los datos del usuario en Firestore
      await firestore.collection('Usuarios').doc(userCredential.user!.uid).set({
        'correo': email,
        'nombre': nombre,
        'direccion': direccion,
        'telefono': telefono,
        'id_SuperUsuario': uidSuperUsuario,
        'roll': selectedPrivilege,
      });
      printInfo(info: 'Usuario registrado con éxito.');
      isSuccefull = true;
      return isSuccefull;
    } on FirebaseAuthException catch (e) {
      printError(info: "Error de Firebase: ${e.message}");
      isSuccefull = false;
      return isSuccefull;
    } catch (e) {
      printError(info: 'Error al registrar el usuario: $e');
      isSuccefull = false;
      return isSuccefull;
    }
  }

  Future<bool> obtenerPrivilegioUsuario(
      String tipoUsuario, String privilegio) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      User? usuario = FirebaseAuth.instance.currentUser;
      if (usuario == null) {
        throw Exception('Usuario no autenticado.');
      }

      DocumentSnapshot<Map<String, dynamic>> usuarioSnapshot =
          await firestore.collection('Usuarios').doc(usuario.uid).get();

      if (usuarioSnapshot.exists) {
        String idSuperUsuario = usuarioSnapshot.data()!['id_SuperUsuario'];

        DocumentSnapshot<Map<String, dynamic>> superUsuarioSnapshot =
            await firestore
                .collection('SuperUsuarios')
                .doc(idSuperUsuario)
                .get();

        if (superUsuarioSnapshot.exists) {
          Map<String, dynamic> privilegios =
              superUsuarioSnapshot.data()!['privilegios'];
          bool tienePrivilegio = privilegios[tipoUsuario]?[privilegio] ?? false;
          return tienePrivilegio;
        } else {
          throw Exception('No se encontró el superusuario asociado.');
        }
      } else {
        throw Exception('No se encontró el documento de usuario.');
      }
    } catch (e) {
      print('Error al obtener privilegio: $e');
      return false;
    }
  }

  Future<dynamic> tipoUsuario(
    String tipoPrivilegio, [
    Function()? metodoSuperUsuario,
    Function()? metodoTienePermisos,
    Function()? metodoNoTienePermisos,
  ]) async {
    try {
      final esSuperUser = await esSuperUsuario();
      print("Es superusuario: $esSuperUser");

      if (esSuperUser != true) {
        User? usuario = FirebaseAuth.instance.currentUser;
        if (usuario == null) {
          throw Exception('Usuario no autenticado.');
        }

        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('Usuarios')
                .doc(usuario.uid)
                .get();

        if (snapshot.exists) {
          String? rol = snapshot.data()?['roll'];

          final verificarPrivilegio =
              await obtenerPrivilegioUsuario(rol!, tipoPrivilegio);
          if (verificarPrivilegio == true) {
            print("tiene permisos: $verificarPrivilegio");
            await metodoTienePermisos!();
          } else {
            await metodoNoTienePermisos!();
          }
        } else {
          throw Exception(
              'El usuario no tiene un documento asociado en la colección "Usuarios".');
        }
      } else {
        await metodoSuperUsuario!();
        print("Es super Usuario");
      }
    } catch (e) {
      printError(info: "$e");
    }
  }

  Future<dynamic> mensajePrivilegio(String s, BuildContext context) async {
    return await authenticationRepository.showMessage("Aviso", s, context);
  }

  Future<List<Map<String, dynamic>>> getUsersLinkedToSuperUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return [];
      }

      String uid = user.uid;
      print('UID activo: $uid');

      // Evaluamos si el usuario activo es superusuario
      final esSuperUser = await esSuperUsuario();

      // Si es superusuario, obtenemos los usuarios ligados
      if (esSuperUser) {
        // Consultamos los documentos en la colección 'Usuarios' donde el campo 'id_SuperUsuario' coincida con el UID activo
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Usuarios')
            .where('id_SuperUsuario', isEqualTo: uid)
            .get();

        List<Map<String, dynamic>> linkedUsersData = [];

        // Iteramos sobre los documentos
        for (var doc in querySnapshot.docs) {
          // Obtenemos los datos de cada usuario
          Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
          // Agregamos el ID del usuario a los datos
          userData['id'] = doc.id;
          // Agregamos los datos del usuario a la lista
          linkedUsersData.add(userData);
          print(
              'Datos del usuario ${doc.id}: $userData'); // Print para mostrar los datos del usuario
        }

        print(
            'Datos de los usuarios ligados al superusuario activo: $linkedUsersData');

        // Retornamos la lista de datos de los usuarios normales ligados al superusuario activo
        return linkedUsersData;
      } else {
        // Consultamos los documentos en la colección 'Usuarios' donde el campo 'id_SuperUsuario' coincida con el UID activo
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('Usuarios')
            .doc(uid)
            .get();
        if (!userSnapshot.exists) {
          print('El usuario activo no tiene un ID de superusuario vinculado');
          return [];
        }
        String? idSuperUsuario =
            (userSnapshot.data() as Map<String, dynamic>)['id_SuperUsuario'];

        if (idSuperUsuario == null) {
          print('El usuario activo no tiene un ID de superusuario vinculado');
          return [];
        }

        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Usuarios')
            .where('id_SuperUsuario', isEqualTo: idSuperUsuario)
            .get();

        List<Map<String, dynamic>> linkedUsersData = [];

        // Iteramos sobre los documentos
        for (var doc in querySnapshot.docs) {
          // Obtenemos los datos de cada usuario
          Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
          // Agregamos el ID del usuario a los datos
          userData['id'] = doc.id;
          // Agregamos los datos del usuario a la lista
          linkedUsersData.add(userData);
          print(
              'Datos del usuario ${doc.id}: $userData'); // Print para mostrar los datos del usuario
        }

        print(
            'Datos de los usuarios ligados al superusuario activo: $linkedUsersData');

        // Retornamos la lista de datos de los usuarios normales ligados al superusuario activo
        return linkedUsersData;
      }
    } catch (e) {
      print(
          'Error al obtener los datos de usuarios ligados al superusuario: $e');
      return [];
    }
  }

  Future<void> editUserData(
    Map<String, dynamic> userData,
    String idUser,
    String correo,
    String direccion,
    String nombre,
    String roll,
    String telefono,
  ) async {
    try {
      final esSuperUser = await esSuperUsuario();

      if (esSuperUser == true) {
        try {
          CollectionReference usersCollection =
              FirebaseFirestore.instance.collection('Usuarios');
          Map<String, dynamic> updatedData = {
            /*    'correo': correo, */
            'direccion': direccion,
            'nombre': nombre,
            'roll': roll,
            'telefono': telefono,
          };
          await usersCollection.doc(idUser).update(updatedData);

          printInfo(
              info:
                  "Datos del usuario editados correctamente desde superusuario");
        } catch (e) {
          printError(info: "$e");
        }
      } else {
        CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('Usuarios');
        Map<String, dynamic> updatedData = {
          /* 'correo': correo, */
          'direccion': direccion,
          'nombre': nombre,
          'roll': roll,
          'telefono': telefono,
        };

        await usersCollection.doc(idUser).update(updatedData);

        print("Datos del usuario editados correctamente");
      }
    } catch (error) {
      print("Error al editar los datos del usuario: $error");
    }
  }
}
