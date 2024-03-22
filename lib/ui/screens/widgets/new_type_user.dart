import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobranzas/controllers/user_controller.dart';
import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NewTypeUser extends StatefulWidget {
  const NewTypeUser({super.key});

  @override
  State<NewTypeUser> createState() => _NewTypeUserState();
}

class _NewTypeUserState extends State<NewTypeUser> {
  static var userController = Get.put(UserController());
  final formKey3 = GlobalKey<FormState>();

  late List<bool> switchValues = [];
  late List<String> crudLabels = [];
  late bool resultSwitchAc;
  late bool resultSwitchEd;
  late bool resultSwitchEl;
  late bool resultSwitchVe;

  bool isLoading = false;

  @override
  void initState() {
    switchValues = [
      true,
      true,
      true,
      true,
    ];
    crudLabels = [
      'Actualizar',
      'Editar',
      'Eliminar',
      'Ver',
    ];

    resultSwitchAc = true;
    resultSwitchEd = true;
    resultSwitchEl = true;
    resultSwitchVe = true;
    super.initState();
  }

  cleanFields() {
    userController.nuevoTipoUsuario.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: size.height * .03,
                left: size.width * .04,
                right: size.width * .04,
                height: 45,
                child: Container(
                  // width: size.width,
                  //height: size.height,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.orangeAccent.withOpacity(.5),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Constants.blueColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Positioned(
                top: 70,
                right: size.width * 0.04,
                left: size.width * 0.04,
                height: size.height * 0.120,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  color: Colors.transparent,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: FittedBox(
                                fit: BoxFit.cover,
                                child: Text(
                                  'NUEVO PERFIL DE USUARIO',
                                  style: GoogleFonts.aldrich(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 30.0,
                                        color: Constants.blueColor),
                                  ),
                                )),
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          child: Image(
                              width: size.width / 4,
                              height: 80,
                              alignment: Alignment.topCenter,
                              image: const AssetImage(
                                  "assets/NuevoTipoUsuario.png")),
                        ),
                      ]),
                )),
            Positioned(
                top: 166,
                right: size.width * 0.04,
                left: size.width * 0.04,
                bottom: size.height * 0.02,
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: size.height * 0.75,
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(colors: [
                            Colors.blue.withOpacity(0.2),
                            Colors.transparent,
                            Colors.blue.withOpacity(0.2),
                            Colors.blue.withOpacity(0.3),
                          ])),
                      child: Form(
                        key: formKey3,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 20,
                              right: 20,
                              bottom: 20,
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                      maxLength: 20,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Ingresa un perfil de usuario';
                                        }
                                        final RegExp wordRegex = RegExp(
                                            r'^[a-zA-Z]+$'); // Expresión regular para una sola palabra
                                        if (!wordRegex.hasMatch(value)) {
                                          return 'Palabra sin espacios ni caracteres especiales';
                                        }
                                        if (value.length <= 3) {
                                          return 'Palabra mayor a 3 caracteres';
                                        }
                                        return null;
                                      },
                                      controller:
                                          userController.nuevoTipoUsuario,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        label: const Text("Perfil de usuario"),
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Constants.blueColor,
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            userController.nuevoTipoUsuario
                                                .clear();
                                          },
                                          child: Icon(
                                            Icons.cancel,
                                            color: Constants.blueColor
                                                .withOpacity(0.7),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular((10.0)),
                                            borderSide: BorderSide(
                                                color: Colors.orange
                                                    .withOpacity(.8),
                                                width: 3)),

                                        //
                                      )),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  for (int i = 0; i < switchValues.length; i++)
                                    ListTile(
                                      title: Text(
                                        "${crudLabels[i]}:",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            color: Constants.blueColor),
                                      ),
                                      trailing: Switch(
                                        activeColor: Colors.white,
                                        activeTrackColor: Colors.blue,
                                        inactiveThumbColor: Colors.blueGrey,
                                        inactiveTrackColor:
                                            Constants.orangeColor,
                                        value: switchValues[i],
                                        onChanged: (value) {
                                          setState(() {
                                            switchValues[i] = value;
                                            resultSwitchAc = switchValues[0];
                                            resultSwitchEd = switchValues[1];
                                            resultSwitchEl = switchValues[2];
                                            resultSwitchVe = switchValues[3];
                                          });
                                        },
                                      ),
                                    ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: size.height * 0.1,
                                    width: size.width * 0.6,
                                    color: Colors.transparent,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor: Colors.cyan
                                                    .withOpacity(.8)),
                                            autofocus: true,

                                            onPressed: () async {
                                              isLoading = false;
                                              try {
                                                //todo Empiza  condicion de forms//
                                                if (formKey3.currentState!
                                                    .validate()) {
                                                  setState(() {
                                                    isLoading = true;
                                                    if (isLoading == true) {
                                                      showDialog(
                                                          barrierDismissible:
                                                              false,
                                                          context: context,
                                                          builder: (context) {
                                                            return Center(
                                                                child:
                                                                    SpinKitRing(
                                                              color: Colors
                                                                  .orange
                                                                  .withOpacity(
                                                                      0.9),
                                                              size: 50.0,
                                                              lineWidth: 4,
                                                            ));
                                                          });

                                                      Future.delayed(
                                                          const Duration(
                                                              milliseconds:
                                                                  2000), () {
                                                        setState(() {
                                                          isLoading = false;
                                                          Get.back();
                                                        });
                                                      }).whenComplete(() {
                                                        userController.registerNewTypeUser(
                                                            resultSwitchAc,
                                                            resultSwitchEd,
                                                            resultSwitchEl,
                                                            resultSwitchVe,
                                                            ((userController
                                                                        .nuevoTipoUsuario
                                                                        .text[0]
                                                                        .toUpperCase()
                                                                        .trim()) +
                                                                    (userController
                                                                            .nuevoTipoUsuario
                                                                            .text
                                                                            .substring(1)
                                                                            .trim())
                                                                        .toLowerCase())
                                                                .split(" ")
                                                                .join(""));

                                                        authenticationRepository
                                                            .showMessage(
                                                                "Aviso",
                                                                "Se registro correctamente",
                                                                context);

                                                        cleanFields();
                                                      });
                                                    }
                                                  });
                                                } else {
                                                  authenticationRepository
                                                      .showMessage(
                                                          "Advertencia",
                                                          "Error de registro verifique los datos",
                                                          context);
                                                }
                                              } on FirebaseFirestore catch (_) {
                                                authenticationRepository
                                                    .showMessage(
                                                        "Advertencia",
                                                        "Error de base de datos Firebase",
                                                        context);
                                              } catch (e) {
                                                authenticationRepository
                                                    .showMessage("Advertencia",
                                                        "Error $e ", context);
                                              }

                                              //Termino condición de formularios
                                            },
                                            child: const Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.save,
                                                        color: Colors.black,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Registrar",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            //termina la función del botón
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
