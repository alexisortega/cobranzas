import 'package:cobranzas/constants.dart';
import 'package:cobranzas/controllers/controllers.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:cobranzas/ui/screens/widgets/signup_page.dart';
import 'package:cobranzas/ui/screens/widgets/forgot_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final controller2 = Get.put(SingUpController());

    borrar_campos_login() {
      controller2.emailLogin.clear();
      controller2.passwordlogin.clear();
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/LOGIN.png',
                  height: 250,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '¡ BIENVENIDO ! ',
                  style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: controller2.emailLogin,
                  decoration: const InputDecoration(
                      label: Text("Correo Eléctronico"),
                      prefixIcon: Icon(Icons.email)),
                ),
                TextFormField(
                  controller: controller2.passwordlogin,
                  decoration: const InputDecoration(
                      label: Text("contraseña"), prefixIcon: Icon(Icons.lock)),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    authenticationRepository().loginWithEmailAndPassword1(
                        controller2.emailLogin.text.trim(),
                        controller2.passwordlogin.text.trim());
                    borrar_campos_login();
                  },
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Constants.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: const Center(
                      child: Text(
                        'Ingresar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: ForgotPassword(),
                            type: PageTransitionType.bottomToTop));
                    borrar_campos_login();
                  },
                  child: Center(
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: '¿Olvidaste tú contraseña? ',
                          style: TextStyle(
                            color: Constants.blackColor,
                          ),
                        ),
                        TextSpan(
                          text: 'Recupérala aquí',
                          style: TextStyle(
                            color: Constants.primaryColor,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Por'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Constants.primaryColor),
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 30,
                        child: Image.asset('assets/images/google.png'),
                      ),
                      GestureDetector(
                        onTap: () async {
                          User? userGoogle =
                              await authenticationRepository.SignInWithGoogle2(
                                  context: context);
                          print(userGoogle?.emailVerified);
                          print("HOLA SOY EL boton google");

                          // authenticationRepository().SignInWithGoogle();
                        },
                        child: Text(
                          'Ingresa con Google',
                          style: TextStyle(
                            color: Constants.blackColor,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
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
                            child: SignUp(),
                            type: PageTransitionType.bottomToTop));
                    borrar_campos_login();
                  },
                  child: Center(
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: '¿No tienes una cuenta? ',
                          style: TextStyle(
                            color: Constants.blackColor,
                          ),
                        ),
                        TextSpan(
                          text: 'Registraté',
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
      ),
    );
  }
}
