import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobranzas/repository/Exception/signup_email_paswword_failure.dart';
import 'package:cobranzas/ui/onboarding_screen.dart';
import 'package:cobranzas/ui/root_page.dart';
import 'package:cobranzas/ui/screens/home_page.dart';
import 'package:cobranzas/ui/screens/widgets/signin_page.dart';
import 'package:cobranzas/ui/screens/widgets/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: camel_case_types
class authenticationRepository extends GetxController {
  static authenticationRepository get instance => Get.find();

  final _auth1 = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser1;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  void onReady() {
    firebaseUser1 = Rx<User?>(_auth1.currentUser);
    firebaseUser1.bindStream(_auth1.userChanges());

    ever(firebaseUser1, _setInitialScreen);
  }

  _setInitialScreen(User? user1) {
    if (user1 != null) {
      Get.offAll(() => const RootPage());
    } else {
      Get.offAll(() => const OnboardingScreen());
    }
  }

  Future<void> createUserWithEmailAndPassword1(
      //REGISTRO DE USUARIOS/////
      String email,
      String password,
      String fullname,
      int telRegister) async {
    try {
      await _auth1
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .whenComplete(() async {
        printInfo(info: "insertando datos de registro...");
        try {
          User? currentUser = _auth1.currentUser;
          if (currentUser != null) {
            await FirebaseFirestore.instance
                .collection('SuperUsuarios')
                .doc(currentUser.uid)

                //currentUser.uid
                .set({
              'contraseña_SuperUsuario': password,
              'correo_SuperUsuario': email,
              'nombre_c_SuperUsuario': fullname,
              'telefono_SuperUsuario': telRegister,
              'privilegios': {
                'Administrador': {
                  'Actualizar': true,
                  'Editar': true,
                  'Eliminar': true,
                  'Ver': true,
                },
                'Cobratario': {
                  'Actualizar': true,
                  'Editar': true,
                  'Eliminar': true,
                  'Ver': true
                },
                'Supervisor': {
                  'Actualizar': true,
                  'Editar': true,
                  'Eliminar': true,
                  'Ver': true
                },
                'Vendedor': {
                  'Actualizar': true,
                  'Editar': true,
                  'Eliminar': true,
                  'Ver': true
                },
              },
            });

            Get.offAll(() => const RootPage());
          } else {
            Get.to(() => const SignUp());
          }
        } on FirebaseAuthException catch (e) {
          final ex = signUpWithEmailAndPasswordFailure.code(e.code);

          printError(info: "'''FIREBASE AUTH EXCEPTION'''-${ex.message1}");
          validaciones(ex.message1.toString());
        } catch (e) {
          validaciones("Error de registro");
        }
      });

      /*  if (firebaseUser1.value != null) {
        Get.offAll(() => const RootPage());
      } else {
        Get.to(() => SignUp());
      } */
    } on FirebaseAuthException catch (e) {
      final ex = signUpWithEmailAndPasswordFailure.code(e.code);
      // ignore: avoid_print
      print("'''FIREBASE AUTH EXCEPTION'''-${ex.message1}");
      validaciones(ex.message1.toString());
    } catch (e) {
      printError(info: "$e");
    }
  }

  Future<void> loginWithEmailAndPassword1(
      String email, String password, BuildContext context) async {
    // AUTENTIFICACION ---

    if (!(email.isEmpty || password.isEmpty)) {
      try {
        await _auth1.signInWithEmailAndPassword(
            email: email, password: password);
        // ignore: use_build_context_synchronously
        if (!context.mounted) return;
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Center(
                  child: SpinKitRing(
                color: Colors.orange.withOpacity(0.9),
                size: 50.0,
                lineWidth: 4,
                duration: const Duration(seconds: 3),
              ));
            });

        Future.delayed(const Duration(milliseconds: 4000), () {
          Get.back();
        });
      } on FirebaseAuthException catch (e) {
        final ex = signUpWithEmailAndPasswordFailure.code(e.code.toString());

        printError(info: "'''FIREBASE AUTH EXCEPTION 2'''-${ex.message1}");
        validaciones(ex.message1.toString());
        // }
      }
    } else {
      validaciones("Necesitas llenar los campos de texto ");
    }
  }

  // }

  // ignore: non_constant_identifier_names
  // Future<void> LogoOut() async => await _auth1.signOut();

  static logOut(BuildContext context) async {
    //SALIR

    try {
      FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      if (!context.mounted) return;
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Center(
                child: SpinKitRing(
              color: Colors.orange.withOpacity(0.9),
              size: 50.0,
              lineWidth: 4,
              duration: const Duration(seconds: 3),
            ));
          });
      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          Get.back();
        },
      );
    } catch (e) {
      validaciones("Error al salir");
    }
  }

  Future<void> enviarLinkResetContrasena(String email) async {
    try {
      await _auth1.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      final ex = signUpWithEmailAndPasswordFailure.code(e.code.toString());
      printError(info: "'''FIREBASE AUTH EXCEPTION 3'''-${ex.message1}");
      validaciones(ex.message1.toString());
    } catch (e) {
      validaciones("$e");
    }
  }

  // ignore: non_constant_identifier_names
  HandleAuthState() async {
    try {
      return StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const SignIn();
            }
          });
    } catch (e) {
      validaciones("ERROR  HandleAuthState");
    }
  }
  //todo: metodo de google//
  /* signInWithGoogle(
    BuildContext context,
  ) async {
    final GoogleSignInAccount? googleUser1 =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser1!.authentication;

    final credential1 = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    return await FirebaseAuth.instance.signInWithCredential(credential1);
  } */

  static Future<User?> signInWithGoogle2(
      {required BuildContext context}) async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
      if (googleAccount == null) {
        print.printError(info: "Error: Cuenta de Google nula");
        return null;
      }

      GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final usuario = userCredential.user;
      final usuarioUID = usuario?.uid;
      print.printInfo(info: "${usuario?.providerData}");

      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('SuperUsuarios')
          .doc(usuarioUID)
          .get();

      if (usuario != null && !documentSnapshot.exists) {
        await FirebaseFirestore.instance
            .collection('SuperUsuarios')
            .doc(usuario.uid)
            .set({
          'contraseña_SuperUsuario': null,
          'correo_SuperUsuario': usuario.email,
          'nombre_c_SuperUsuario': usuario.displayName,
          'telefono_SuperUsuario': usuario.phoneNumber,
          'privilegios': {
            'Administrador': {
              'Actualizar': true,
              'Editar': true,
              'Eliminar': true,
              'Ver': true,
            },
            'Cobratario': {
              'Actualizar': true,
              'Editar': true,
              'Eliminar': true,
              'Ver': true
            },
            'Supervisor': {
              'Actualizar': true,
              'Editar': true,
              'Eliminar': true,
              'Ver': true
            },
            'Vendedor': {
              'Actualizar': true,
              'Editar': true,
              'Eliminar': true,
              'Ver': true
            },
          },
        });
      }

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print.printError(info: "Error en la autenticación: ${e.code}");
      validaciones(e.code);
      return null;
    } catch (e) {
      print.printError(info: "Error general en signInWithGoogle2: $e");
      return null;
    }
  }

  // ignore: body_might_complete_normally_nullable
  /* static Future<User?> signInWithGoogle2(
      {required BuildContext context}) async {
    try {
      User? user2;
      GoogleSignIn objGoogleSign = GoogleSignIn();
      GoogleSignInAccount? objGoogleSignInAccount =
          await objGoogleSign.signIn();

      if (objGoogleSignInAccount != null) {
        GoogleSignInAuthentication objGoogleSignInAuthentication =
            await objGoogleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: objGoogleSignInAuthentication.accessToken,
            idToken: objGoogleSignInAuthentication.idToken);

        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return Center(
                    child: SpinKitRing(
                  color: Colors.orange.withOpacity(0.9),
                  size: 50.0,
                  lineWidth: 4,
                  duration: const Duration(seconds: 3),
                ));
              });
          Future.delayed(const Duration(milliseconds: 2500), () {
            Get.back();
          });

          user2 = userCredential.user;
          return user2;
        } on FirebaseAuthException catch (e) {
          print("Error en la autentificacion ${e.code.toString()}");
          validaciones(e.code.toString());
        } catch (_) {}
      } else if (objGoogleSignInAccount == null) {
        print("Error cuenta de google nula ");
        Get.back();
      }
    } catch (e) {
      print(e.hashCode.toString());
    }
  } */

/* Future<User?> signInWithGoogle2() async {
  try {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Realiza la autenticación con Firebase
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    }
  } catch (error) {
    print("Error al iniciar sesión con Google: $error");
    return null;
  }
  return null;
} */

  static validaciones(String mensaje) {
    Get.defaultDialog(
      title: "ADVERTENCIA",
      titleStyle: const TextStyle(fontSize: 25),
      middleText: mensaje,
      middleTextStyle: const TextStyle(fontSize: 20),
      backgroundColor: Colors.blue.withOpacity(.6),
      radius: 25,
      //textCancel: "Cancelar",
      cancelTextColor: Colors.white,
      //textConfirm: "Ok",
      /*onCancel: () {
        //
      },*/
      onConfirm: () {
        Get.back();
      },
      barrierDismissible: true,
      //
    );
  }

  static showcerrarSesion(String mensaje, BuildContext context) {
    Get.defaultDialog(
      title: "AVISO",
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
        logOut(context);
      },
      barrierDismissible: false,
      //
    );
  }
}
