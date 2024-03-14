import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/controllers/auth_controllers.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:cobranzas/ui/screens/widgets/signup_page.dart';
import 'package:cobranzas/ui/screens/widgets/forgot_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey3 = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    final controller2 = Get.put(SingUpController());

    void borrarCamposlogin() {
      controller2.emailLogin.clear();
      controller2.passwordlogin.clear();
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey3,
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
                  controller: controller2.emailLogin,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: const Text("Correo Eléctronico"),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Constants.blueColor,
                    ),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa una contraseña válida';
                    }

                    if (value.length < 6) {
                      return 'La contraseña debe tener al menos 6 caracteres';
                    }
                    return null; // Return null means the input is valid
                  },
                  controller: controller2.passwordlogin,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Constants.blueColor,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    if (formKey3.currentState!.validate()) {
                      try {
                        await authenticationRepository()
                            .loginWithEmailAndPassword1(
                                controller2.emailLogin.text.trim(),
                                controller2.passwordlogin.text.trim(),
                                context);
                        borrarCamposlogin();
                      } catch (e) {
                        authenticationRepository.validaciones(
                            "No se pudo registrar intente más tarde");
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
                    borrarCamposlogin();
                  },
                  child: Center(
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: '¿Olvidaste tú contraseña? ',
                          style: TextStyle(
                            color: Constants.orangeColor,
                          ),
                        ),
                        TextSpan(
                          text: 'Recupérala aquí',
                          style: TextStyle(
                            color: Constants.blueColor,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
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
                      border: Border.all(color: Constants.blueColor),
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
                          User? userGoogle = await authenticationRepository
                              .signInWithGoogle2(context: context);

                          printInfo(
                              info:
                                  "verificación con google ['${userGoogle?.emailVerified}']");

                          // authenticationRepository().SignInWithGoogle();
                        },
                        child: Text(
                          'Ingresa con Google',
                          style: TextStyle(
                            color: Constants.orangeColor,
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
                            child: const SignUp(),
                            type: PageTransitionType.bottomToTop));
                    borrarCamposlogin();
                  },
                  child: Center(
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: '¿No tienes una cuenta? ',
                          style: TextStyle(
                            color: Constants.orangeColor,
                          ),
                        ),
                        TextSpan(
                          text: 'Registraté',
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
}
