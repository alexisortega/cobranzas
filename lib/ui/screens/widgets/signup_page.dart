import 'package:cobranzas/constants.dart';
import 'package:cobranzas/controllers/controllers.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:cobranzas/ui/screens/widgets/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  static authenticationRepository get instance => Get.find();
  static final _formKey1 = GlobalKey<FormState>();
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final controller1 = Get.put(SingUpController());

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //key: _formKey,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: SignUp._formKey1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Registro.png',
                  height: 250,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  ' * REGISTRO * ',
                  style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
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
                  controller: controller1.fullnameRegistrar,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      label: Text("Nombre Completo"),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Constants.blueColor,
                      )),
                ),
                TextFormField(
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
                        _obscureText ? Icons.visibility : Icons.visibility_off,
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
                  onTap: () {
                    if (SignUp._formKey1.currentState!.validate()) {
                      try {
                        SingUpController.instance.registerUser(
                          controller1.emailRegistrar.text.trim(),
                          controller1.passwordRegistrar.text.trim(),
                          controller1.fullnameRegistrar.text.trim(),
                          int.parse(controller1.telRegistrar.text.trim()),
                        );

                        borrarCampos();
                      } catch (e) {}
                    } else {
                      print("error de registro");
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
                          try {
                            User? userGoogle = await authenticationRepository
                                .signInWithGoogle2(context: context);

                            print(userGoogle?.emailVerified);
                            print("HOLA SOY EL boton google");
                          } on FirebaseAuthException catch (_) {
                            authenticationRepository.validaciones(
                                "Error al iniciar intente de nuevo");
                          } catch (_) {}
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
    );
  }

  borrarCampos() {
    controller1.emailRegistrar.clear();
    controller1.fullnameRegistrar.clear();
    controller1.passwordRegistrar.clear();
    controller1.telRegistrar.clear();
  }
}
