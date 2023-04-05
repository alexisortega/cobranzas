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
  ) async {
    if (!(email.isEmpty || password.isEmpty)) {
      try {
        await _auth1.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (firebaseUser1.value != null) {
          Get.offAll(() => const RootPage());
        } else {
          Get.to(() => SignUp());
        }
      } on FirebaseAuthException catch (e) {
        final ex = signUpWithEmailAndPasswordFailure.code(e.code);
        // ignore: avoid_print
        print("'''FIREBASE AUTH EXCEPTION'''-${ex.message1}");
        validaciones(ex.message1.toString());
      } catch (_) {}
    } else {
      validaciones("Los campos se encuentran vacíos");
    }
  }

  Future<void> loginWithEmailAndPassword1(
      String email, String password, BuildContext context) async {
    // AUTENTIFICACION ---

    if (!(email.isEmpty || password.isEmpty)) {
      try {
        await _auth1.signInWithEmailAndPassword(
            email: email, password: password);
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

        print("'''FIREBASE AUTH EXCEPTION 2'''-${ex.message1}");
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

  void enviarLinkResetContrasena(String email) async {
    if (email.isNotEmpty) {
      try {
        await _auth1.sendPasswordResetEmail(email: email);
      } on FirebaseAuthException catch (e) {
        final ex = signUpWithEmailAndPasswordFailure.code(e.code.toString());
        print("'''FIREBASE AUTH EXCEPTION 3'''-${ex.message1}");
        validaciones(ex.message1.toString());
      }
    } else {
      validaciones("Necesita llenar los campos de texto");
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

  signInWithGoogle(
    BuildContext context,
  ) async {
    final GoogleSignInAccount? googleUser1 =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser1!.authentication;

    final credential1 = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    return await FirebaseAuth.instance.signInWithCredential(credential1);
  }

  // ignore: body_might_complete_normally_nullable
  static Future<User?> signInWithGoogle2(
      {required BuildContext context}) async {
    // FirebaseAuth auth2 = FirebaseAuth.instance;
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
  }

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
