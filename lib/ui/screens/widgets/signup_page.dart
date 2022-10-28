import 'package:cobranzas/constants.dart';
import 'package:cobranzas/controllers/controllers.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:cobranzas/ui/screens/widgets/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';


class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  static authenticationRepository get instance => Get.find();
  static final _formKey = GlobalKey<FormState>();
  final controller1 = Get.put(SingUpController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //key: _formKey,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Registro.png',
                  height: 300,
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
                  decoration: const InputDecoration(
                      label: Text("Correo Eléctronico"),
                      prefixIcon: Icon(Icons.email)),
                ),
                TextFormField(
                  controller: controller1.fullnameRegistrar,
                  decoration: const InputDecoration(
                      label: Text("Nombre Compreto"),
                      prefixIcon: Icon(Icons.person)),
                ),
                TextFormField(
                  controller: controller1.passwordRegistrar,
                  decoration: const InputDecoration(
                      label: Text("password"), prefixIcon: Icon(Icons.lock)),
                ),
                /* TextField(
                  controller: controller1.password,
                  decoration: const InputDecoration(
                      label: Text("password"),
                      prefixIcon: Icon(Icons.password)),
                ), CustomTextfield(
                  Controller: controller1.email,
                  obscureText: false,
                  hintText: 'Correo electronico',
                  icon: Icons.alternate_email,
                ),
                CustomTextfield(
                  Controller: controller1.fullname,
                  obscureText: false,
                  hintText: 'Nombre Completo',
                  icon: Icons.person,
                ),
                CustomTextfield(
                  Controller: controller1.password,
                  obscureText: false,
                  hintText: 'contraseña',
                  icon: Icons.password,
                ),*/
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      SingUpController.instance.registerUser(
                        controller1.emailRegistrar.text.trim(),
                        controller1.passwordRegistrar.text.trim(),
                      );

                      borrar_campos();
                    }
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
                Row(
                  children: const [
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
                        'Ingresar con Google',
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
                            child: const SignIn(),
                            type: PageTransitionType.bottomToTop));
                  },
                  child: Center(
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: '¿Ya tienes una cuenta? ',
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
      ),
    );
  }

  borrar_campos() {
    controller1.emailRegistrar.clear();
    controller1.fullnameRegistrar.clear();
    controller1.passwordRegistrar.clear();
  }
}
