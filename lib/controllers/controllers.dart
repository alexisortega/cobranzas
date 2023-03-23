// ignore_for_file: non_constant_identifier_names

import 'dart:core';

import 'package:cobranzas/repository/authentication.dart';
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

  void registerUser(String email, String password, [addItem]) {
    authenticationRepository.instance.createUserWithEmailAndPassword1(
      email,
      password,
    );
  }
  



}
