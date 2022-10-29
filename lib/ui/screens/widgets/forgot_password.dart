import 'package:cobranzas/constants.dart';
import 'package:cobranzas/controllers/controllers.dart';
import 'package:cobranzas/repository/authentication.dart';

import 'package:cobranzas/ui/screens/widgets/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:page_transition/page_transition.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);
  final controller3 = Get.put(SingUpController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/RestContraseña.png',
                height: 380,
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
                controller: controller3.passwordRecuperar,
                decoration: const InputDecoration(
                    label: Text("contraseña"), prefixIcon: Icon(Icons.lock)),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  authenticationRepository().EnviarLinkResetContrasena(
                      controller3.passwordRecuperar.text.trim());

                  borrar_campos_resetcont();
                },
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                  borrar_campos_resetcont();
                },
                child: Center(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: 'Regresar? ',
                        style: TextStyle(
                          color: Constants.blackColor,
                        ),
                      ),
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          color: Constants.primaryColor,
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
    );
  }

  void borrar_campos_resetcont() {
    controller3.passwordRecuperar.clear();
  }
}
