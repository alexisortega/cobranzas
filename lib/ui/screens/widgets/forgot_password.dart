import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/controllers/controllers.dart';
import 'package:cobranzas/repository/authentication.dart';

import 'package:cobranzas/ui/screens/widgets/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:page_transition/page_transition.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final controller3 = Get.put(SingUpController());

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/RestContraseña.png',
                  height: size.height * 0.25,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Restablecer\nContraseña',
                  style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa un correo eléctronico';
                    }
                    // Utilizar una expresión regular para validar el formato del correo electrónico
                    bool isValid = RegExp(
                      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                    ).hasMatch(value);
                    if (!isValid) {
                      return 'Ingresa un correo valido';
                    }
                    return null; // Return null means the input is valid
                  },
                  controller: controller3.passwordRecuperar,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: const Text("Correo Eléctronico"),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Constants.blueColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () async {
                    if (formKey2.currentState!.validate()) {
                      try {
                        await authenticationRepository()
                            .enviarLinkResetContrasena(
                                controller3.passwordRecuperar.text.trim());

                        borrarCamposResetCont();
                      } catch (e) {
                        printError(info: "$e");
                      }
                    }
                  },
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Constants.blueColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: const Center(
                      child: Text(
                        'Restablecer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: const SignIn(),
                            type: PageTransitionType.bottomToTop));
                    borrarCamposResetCont();
                  },
                  child: Center(
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: '¿Regresar? ',
                          style: TextStyle(
                            color: Constants.orangeColor,
                          ),
                        ),
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: Constants.blueColor,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void borrarCamposResetCont() {
    controller3.passwordRecuperar.clear();
  }
}
