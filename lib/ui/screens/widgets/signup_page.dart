import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/controllers/controllers.dart';
import 'package:cobranzas/repository/Exception/signup_email_paswword_failure.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:cobranzas/ui/screens/widgets/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  static authenticationRepository get instance => Get.find();

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final controller1 = Get.put(SingUpController());

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
          child: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              color: Colors.transparent,
              height: size.height,
              width: size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/Registro.png',
                      height: size.height * 0.2,
                      width: size.width * 0.5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      ' * REGISTRO * ',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    const SizedBox(
                      height: 20,
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
                      controller: controller1.emailRegistrar,
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
                          return 'Ingresa un nombre completo';
                        }

                        if (value.length < 3) {
                          return 'El nombre debe tener al menos 3 caracteres';
                        }

                        // Expresión regular para validar el nombre completo
                        RegExp regExp = RegExp(
                          r'^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ][a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]{2,}(?: [a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+){2,}$',
                        );

                        if (!regExp.hasMatch(value)) {
                          return 'Ingresa un nombre completo válido';
                        }

                        return null;
                      },
                      controller: controller1.fullnameRegistrar,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          label: const Text("Nombre Completo"),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Constants.blueColor,
                          )),
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
                      controller: controller1.passwordRegistrar,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: "Contraseña",
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Constants.blueColor,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa un número de teléfono ';
                          }
                          //validacion  de numero con caracters  formato (###) ###-####//
                          // RegExp regExp = RegExp(
                          //   r'^\(\d{3}\) \d{3}-\d{4}$',
                          // );

                          // if (!regExp.hasMatch(value)) {
                          //   return 'formato (###) ###-####';
                          // }

                          RegExp regExp = RegExp(
                            r'^\d{10}$',
                          );

                          if (!regExp.hasMatch(value)) {
                            return 'Ingresa un número de teléfono válido con 10 dígitos';
                          }

                          return null;
                        },
                        controller: controller1.telRegistrar,
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                        decoration: InputDecoration(
                          label: const Text("Teléfono"),
                          prefixIcon: Icon(
                            Icons.phone_iphone_outlined,
                            color: Constants.blueColor,
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await SingUpController.instance.registerUser(
                              controller1.emailRegistrar.text.trim(),
                              controller1.passwordRegistrar.text.trim(),
                              controller1.fullnameRegistrar.text.trim(),
                              int.parse(controller1.telRegistrar.text.trim()),
                            );

                            borrarCampos();
                          } on FirebaseAuthException catch (e) {
                            final ex =
                                signUpWithEmailAndPasswordFailure.code(e.code);

                            printError(
                                info:
                                    "'''FIREBASE AUTH EXCEPTION'''-${ex.message1}");
                            authenticationRepository
                                .validaciones(ex.message1.toString());
                          } catch (e) {
                            authenticationRepository.validaciones(
                                "Llena correctamente todos los campos");
                            printError(info: "$e");
                          }
                          // } else {
                          //   print("error de registro");
                          // }
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 1, right: 1),
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Constants.blueColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: const Center(
                          child: Text(
                            'Registrar',
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
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('OR'),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 1, right: 1),
                      width: size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Constants.blueColor),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 30,
                            child: Image.asset('assets/images/google.png'),
                          ),
                          GestureDetector(
                            onTap: () async {
                              try {
                                User? userGoogle =
                                    await authenticationRepository
                                        .signInWithGoogle2(context: context);

                                printInfo(info: "${userGoogle?.emailVerified}");
                                printInfo(info: " EL boton google");
                              } on FirebaseAuthException catch (e) {
                                final ex = signUpWithEmailAndPasswordFailure
                                    .code(e.code);

                                printError(
                                    info:
                                        "'''FIREBASE AUTH EXCEPTION'''-${ex.message1}");
                                authenticationRepository
                                    .validaciones(ex.message1.toString());
                              } catch (a) {
                                authenticationRepository
                                    .validaciones("Error de registro");
                              }
                            },
                            child: Text(
                              'Ingresar con Google',
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
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: const SignIn(),
                                type: PageTransitionType.bottomToTop));
                        borrarCampos();
                      },
                      child: Center(
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: '¿Ya tienes una cuenta? ',
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
        ),
      ),
    );
  }

  borrarCampos() {
    controller1.emailRegistrar.clear();
    controller1.fullnameRegistrar.clear();
    controller1.passwordRegistrar.clear();
    controller1.telRegistrar.clear();
  }
}
