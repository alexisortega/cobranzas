import 'package:cobranzas/constants.dart';
import 'package:cobranzas/ui/root_page.dart';
import 'package:cobranzas/ui/screens/home_page.dart';
import 'package:cobranzas/ui/screens/widgets/custom_textfield.dart';
import 'package:cobranzas/ui/screens/widgets/signup_page.dart';
import 'package:cobranzas/ui/screens/widgets/forgot_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:page_transition/page_transition.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  final emailControler = TextEditingController();
  final contraControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    login() async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailControler.text, password: contraControler.text);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomePage()));
      } on FirebaseAuthException catch (exception) {
        String mensaje = '';
        switch (exception.code) {
          case 'invalid-email':
            mensaje = "El correo es invalido";
            break;

          case 'user-disabled':
            mensaje =
                "el usuario con el que intentó iniciar sesión está deshabilitado";
            break;
          case 'user-not-found':
            mensaje = "El usuario no esta registrado";
            break;
          case 'Wrong-password':
            mensaje = "contraseña incorrecta ";
            break;
          case 'invalid-action-code':
            mensaje = "codigo de accion no valido";
            break;
          default:
            mensaje = "El usuario o la contraseña son incorrectos";
            break;
        }

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error al iniciar sesión"),
                content: Text(mensaje),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cerrar"))
                ],
              );
            });
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
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
              /*   TextField(
                  obscureText: false,
                  controller: emailControler,
                  decoration: const InputDecoration(
                    hintText: 'ingrese correo',
                    labelText: "Correo Electronico",
                    iconColor: Colors.orange,
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.email_outlined),
                  )),
              const SizedBox(
                height: 10,
              ),
               TextField(
                obscureText: true,
                controller: contraControler,
                decoration: const InputDecoration(
                  hintText: 'ingrese contraseña',
                  //  labelText: "Contraseña",
                  iconColor: Colors.orange,
                  //border: OutlineInputBorder(),
                  icon: Icon(Icons.lock),
                ),
              ),*/
              CustomTextfield(
                controlador: emailControler,
                obscureText: false,
                hintText: 'Correo Eléctronico',
                icon: Icons.email_rounded,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextfield(
                controlador: contraControler,
                obscureText: true,
                hintText: 'Contraseña',
                icon: Icons.lock,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  login();
                  emailControler.clear();
                  contraControler.clear();
                  //  borrar();
                  /*
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: const RootPage(),
                          type: PageTransitionType.bottomToTop));*/
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
                          child: const ForgotPassword(),
                          type: PageTransitionType.bottomToTop));
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
                    Text(
                      'Ingresa con Google',
                      style: TextStyle(
                        color: Constants.blackColor,
                        fontSize: 18.0,
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
    );
  }
}
