import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobranzas/controllers/user_controller.dart';
import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/models/custom_text_title.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class NewUser extends StatefulWidget {
  const NewUser({super.key});

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  static var userController = Get.put(UserController());
  final formKey = GlobalKey<FormState>();
  late String fondoNewUser = "";
  bool _obscureText = true;
  bool isLoading = false;
  bool isSuccefull = false;

  String _selectedPrivilege = '';
  List<String> privilegios = [];

  bool selectedmenu = false;

  @override
  void initState() {
    fondoNewUser = "assets/fondoNewUser.png";
    userController.obtenerPrivilegiosUsuarioActivo().then((listaPrivilegios) {
      setState(() {
        privilegios = listaPrivilegios;
        _selectedPrivilege = listaPrivilegios.first;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              expandedHeight: 170.0,
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
                          left: size.width * 0.175,
                          top: size.height * 0.11,
                          bottom: 0.0,
                        ),
                        child: const CustomTextTitle(
                          title: 'NUEVO USUARIO',
                          size: 14.0,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                          left: size.width * 0.2,
                        ),
                        child: const CustomTextTitle(
                          title: 'NUEVO USUARIO',
                          size: 17.0,
                        ),
                      ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    orientation == Orientation.portrait
                        ? Positioned(
                            left: size.width * 0.01,
                            top: size.height * 0.009,
                            right: size.width * 0.4,
                            bottom: size.height * -0.09,
                            child: Image.asset(
                              fondoNewUser, //imagen AppBar
                              fit: BoxFit
                                  .fitHeight, // Cubrir para que la imagen se expanda bien
                            ),
                          )
                        : Positioned(
                            left: size.width * 0.01,
                            top: size.height * 0.009,
                            right: size.width * 0.6,
                            bottom: size.height * -0.15,
                            child: Image.asset(
                              fondoNewUser, //imagen AppBar
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
                            left: orientation == Orientation.portrait ? 0 : 35,
                            right: orientation == Orientation.portrait ? 0 : 35,
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
                                  //CORREO
                                  TextFormField(
                                    maxLength: 35,
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
                                    controller: userController.emailUser,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      label: const Text("Correo Electrónico"),
                                      prefixIcon: Icon(Icons.switch_account,
                                          color: Constants.blueColor),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          userController.emailUser.clear();
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
                                            color:
                                                Colors.orange.withOpacity(.8),
                                            width: 3),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //CONTRASEÑA
                                  TextFormField(
                                    maxLength: 25,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Ingresa una contraseña válida';
                                      }

                                      if (value.length < 6) {
                                        return 'La contraseña debe tener al menos 6 caracteres';
                                      }
                                      return null; // Return null means the input is valid
                                    },
                                    controller: userController.passwordUser,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                      label: const Text("Contraseña"),
                                      prefixIcon: Icon(
                                        Icons.switch_account,
                                        color: Constants.blueColor,
                                      ),
                                      suffixIcon: Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        color: Colors.transparent,
                                        width: 70,
                                        height: 40,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onLongPressStart: (_) {
                                                // Al iniciar la presión larga, mostrar la contraseña
                                                setState(() {
                                                  _obscureText = !_obscureText;
                                                });
                                              },
                                              onLongPressEnd: (_) {
                                                // Al levantar el dedo, ocultar la contraseña
                                                setState(() {
                                                  _obscureText = !_obscureText;
                                                });
                                              },
                                              child: Icon(
                                                _obscureText
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.green
                                                    .withOpacity(0.7),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                userController.passwordUser
                                                    .clear();
                                              },
                                              child: Icon(
                                                Icons.cancel,
                                                color: Constants.blueColor
                                                    .withOpacity(0.7),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular((10.0)),
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.orange.withOpacity(.8),
                                              width: 3)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    maxLength: 35,
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
                                    controller: userController.fullName,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      label: const Text("Nombre Completo"),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Constants.blueColor,
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          userController.fullName.clear();
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
                                            color:
                                                Colors.orange.withOpacity(.8),
                                            width: 3),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    maxLength: 100,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Ingresa una dirección ';
                                      }

                                      if (value.length < 5) {
                                        return 'La dirección es muy corta debe tener al menos 5 caracteres';
                                      }

                                      return null;
                                    },
                                    controller: userController.addressUser,
                                    keyboardType: TextInputType.streetAddress,
                                    decoration: InputDecoration(
                                      label: const Text("Dirección"),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Constants.blueColor,
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          userController.addressUser.clear();
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
                                            color:
                                                Colors.orange.withOpacity(.8),
                                            width: 3),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  TextFormField(
                                    maxLength: 10,
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
                                    controller: userController.telUser,
                                    keyboardType: TextInputType.phone,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      label: const Text("Teléfono"),
                                      prefixIcon: Icon(
                                        Icons.phone_iphone_outlined,
                                        color: Constants.blueColor,
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          userController.telUser.clear();
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
                                            color:
                                                Colors.orange.withOpacity(.8),
                                            width: 3),
                                      ),
                                    ),
                                  ),
                                  //boton registrar
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  DropdownButtonFormField<String>(
                                    validator: (value) {
                                      if (value.toString().isEmpty ||
                                          value == null) {
                                        return "Necesitás llenar el campo";
                                      }
                                      if (selectedmenu == false) {
                                        return "Necesitás seleccionar una opción";
                                      }

                                      return null;
                                    },
                                    icon: const Icon(
                                      Icons.abc,
                                      color: Colors.transparent,
                                      size: null,
                                    ),
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            left: 5,
                                            right: 10,
                                            top: 20,
                                            bottom: 10),
                                        label: const Text("Tipo de usuario"),
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Constants.blueColor,
                                        ),
                                        suffixIcon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Constants.blueColor,
                                          size: 30,
                                        ),
                                        prefix: null,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                                width: 3,
                                                color: Colors.orange))),
                                    value: _selectedPrivilege,
                                    items: (privilegios
                                        .map(
                                          (item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(item,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.black
                                                          .withOpacity(.7)))),
                                        )
                                        .toList()),
                                    onChanged: (item) => setState(() {
                                      _selectedPrivilege = item!;
                                      selectedmenu = true;
                                    }),
                                  ),
                                  const SizedBox(
                                    height: 20,
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
                                                final esSuperUsuario =
                                                    await userController
                                                        .esSuperUsuario();
                                                await userController
                                                    .obtenerPrivilegiosUsuarioActivo();

                                                printInfo(
                                                    info:
                                                        " es superusuario: $esSuperUsuario");
                                                if (esSuperUsuario == true) {
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
                                                        }).whenComplete(
                                                            () async {
                                                          await userController.registrarNuevoUsuario2(
                                                              userController
                                                                  .emailUser
                                                                  .text
                                                                  .trim(),
                                                              userController
                                                                  .passwordUser
                                                                  .text
                                                                  .trim(),
                                                              userController
                                                                  .fullName.text
                                                                  .trim(),
                                                              userController
                                                                  .addressUser
                                                                  .text
                                                                  .trim(),
                                                              userController
                                                                  .telUser.text
                                                                  .trim(),
                                                              _selectedPrivilege);

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
                                                } else {
                                                  authenticationRepository
                                                      .showMessage(
                                                          "Advertencia",
                                                          "No es superusuario",
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
      ),
    );
  }

  void cleanFields() {
    userController.emailUser.clear();
    userController.passwordUser.clear();
    userController.fullName.clear();
    userController.addressUser.clear();
    userController.telUser.clear();
  }
}
