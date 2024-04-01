import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobranzas/controllers/user_controller.dart';
import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/models/custom_text_title.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class NewProfileUser extends StatefulWidget {
  const NewProfileUser({super.key});

  @override
  State<NewProfileUser> createState() => _NewProfileUserState();
}

class _NewProfileUserState extends State<NewProfileUser> {
  static var userController = Get.put(UserController());
  final formKey = GlobalKey<FormState>();

  late String fondoProfileUser = "";

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

    fondoProfileUser = "assets/fondoNewProfileUser.png";

    super.initState();
  }

  cleanFields() {
    userController.newTypeUser.clear();
  }

  @override
  Widget build(BuildContext context) {
    //todo: variables responsivas
    Size size = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;

    return SafeArea(
        top: false,
        child: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                leading: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    iconSize: 40,
                    splashColor: Colors.blue,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent),

                    autofocus: true,
                    icon: Icon(
                      Icons.arrow_back,
                      color: Constants.orangeColor,
                    ), // Cambia 'Icons.menu' por el icono que desees
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                forceMaterialTransparency: true,
                backgroundColor: Colors.red,
                expandedHeight: orientation == Orientation.portrait
                    ? size.height * 0.275
                    : size.height * 0.255,
                floating: false,
                pinned: false,
                snap: false,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  title: orientation == Orientation.portrait
                      ? Container(
                          height: size.height * 0.13,
                          width: size.width * 0.54,
                          color: Colors.transparent,
                          padding: EdgeInsets.only(
                            top: size.height * 0.11,
                            bottom: 0.0,
                          ),
                          child: const CustomTextTitle(
                            title: 'NUEVO PERFIL DE USUARIO',
                            size: 14.0,
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                            left: size.width * 0.15,
                          ),
                          child: const CustomTextTitle(
                            title: 'NUEVO PERFIL DE USUARIO',
                            size: 15.0,
                          ),
                        ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      orientation == Orientation.portrait
                          ? Positioned(
                              left: size.width * 0.19,
                              right: size.width * 0.19,
                              top: size.height * 0.00,
                              bottom: size.height * -0.02,
                              child: Image.asset(
                                fondoProfileUser, //imagen AppBar
                                fit: BoxFit
                                    .fitWidth, // Cubrir para que la imagen se expanda bien
                              ),
                            )
                          : Positioned(
                              top: size.height * 0.0,
                              bottom: size.height * -0.09,
                              right: size.width * 0.6,
                              left: size.width * 0.0,
                              child: Image.asset(
                                fondoProfileUser, //imagen AppBar
                                fit: BoxFit
                                    .fitHeight, // Cubrir para que la imagen se expanda bien
                              ),
                            ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.0, 0.5), //(X,Y)
                            end: Alignment(0.0, 0.0),
                            colors: <Color>[
                              Colors.black12,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              bottom: 10,
                              top: 0.0,
                              left:
                                  orientation == Orientation.portrait ? 0 : 35,
                              right:
                                  orientation == Orientation.portrait ? 0 : 35,
                            ),
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
                              key: formKey,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  left: 20,
                                  right: 20,
                                  bottom: 10.0,
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
                                        controller: userController.newTypeUser,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          label:
                                              const Text("Perfil de usuario"),
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: Constants.blueColor,
                                          ),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              userController.newTypeUser
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
                                    for (int i = 0;
                                        i < switchValues.length;
                                        i++)
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
                                                  if (formKey.currentState!
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
                                                                          .newTypeUser
                                                                          .text[
                                                                              0]
                                                                          .toUpperCase()
                                                                          .trim()) +
                                                                      (userController
                                                                              .newTypeUser
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
                                                      .showMessage(
                                                          "Advertencia",
                                                          "Error $e ",
                                                          context);
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
                                    const SizedBox(
                                      height: 80,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
