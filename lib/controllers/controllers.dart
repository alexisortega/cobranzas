// ignore_for_file: non_constant_identifier_names

import 'package:cobranzas/repository/Exception/signup_email_paswword_failure.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingUpController extends GetxController {
  static SingUpController get instance => Get.find();
  // CAJAS DE TEXTO PARA AUTENTIFICACION
  final emailRegistrar = TextEditingController();
  final fullnameRegistrar = TextEditingController();
  final passwordRegistrar = TextEditingController();
  final emailLogin = TextEditingController();
  final passwordlogin = TextEditingController();
  final passwordRecuperar = TextEditingController();

  final telRegistrar = TextEditingController();

  Future registerUser(
    String email,
    String password,
    String fullname,
    int telRegister,
  ) async {
    try {
      await authenticationRepository.instance.createUserWithEmailAndPassword1(
        email,
        password,
        fullname,
        telRegister,
      );
    } on FirebaseAuthException catch (e) {
      final ex = signUpWithEmailAndPasswordFailure.code(e.code);

      printError(info: "'''FIREBASE AUTH EXCEPTION'''-${ex.message1}");
      authenticationRepository.validaciones(ex.message1.toString());
    } catch (e) {
      authenticationRepository
          .validaciones("Llena correctamente todos los campos");
      printError(info: "$e");
    }
  }
}
