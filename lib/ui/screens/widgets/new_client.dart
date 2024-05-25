import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobranzas/controllers/clients_Controller.dart';
import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/models/custom_text_title.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class NewClient extends StatefulWidget {
  const NewClient({super.key});

  @override
  State<NewClient> createState() => NewClientState();
}

class NewClientState extends State<NewClient> {
  static var controllerClients = Get.put(clientsController());
  final formKey = GlobalKey<FormState>();

  late String fondoNewUser = "";
  int currentStep = 0;

  final ScrollController scrollController = ScrollController();
  bool isAppBarExpanded = true;

  String profile = "";
  DateTime? pickeddate;

  @override
  void initState() {
    profile = "assets/profile2.png";
    fondoNewUser = "assets/pantallaCliente.png";
    scrollController.addListener(scrollListener);
    super.initState();
  }

  void scrollListener() {
    if (scrollController.hasClients) {
      bool isExpanded = scrollController.offset <= 0;
      if (isExpanded != isAppBarExpanded) {
        setState(() {
          isAppBarExpanded = isExpanded;
        });
      }
    }
  }

  String imageUrl = "";
  String imageUrl2 = "";
  bool disable = false;

  List<String> itemsGenero = [
    'Hombre',
    'Mujer',
  ];
  bool isTouched = false;
  String selectedGenero = "Hombre";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;

    return SafeArea(
      top: false,
      child: Scaffold(
        body: CustomScrollView(
          controller: scrollController,
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
              expandedHeight: orientation == Orientation.portrait
                  ? size.height * 0.185
                  : size.height * 0.2,
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
                          top: size.height * 0.10,
                          bottom: 0.0,
                        ),
                        child: const CustomTextTitle(
                          title: 'NUEVO CLIENTE',
                          size: 15.0,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                          left: size.width * 0.2,
                        ),
                        child: const CustomTextTitle(
                          title: 'NUEVO CLIENTE',
                          size: 16.0,
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
                            top: size.height * 0.0009,
                            right: size.width * 0.5,
                            bottom: size.height * -0.07,
                            child: Image.asset(
                              fondoNewUser, //imagen AppBar
                              fit: BoxFit
                                  .fitHeight, // Cubrir para que la imagen se expanda bien
                            ),
                          ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: orientation == Orientation.portrait
                              ? const Alignment(0.03, 0.30)
                              : const Alignment(0.005, 0.27), //(X,Y)
                          end: const Alignment(0.0, 0.0),
                          colors: <Color>[
                            Colors.blueGrey.withOpacity(0.23),
                            Colors.transparent
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding:
                  const EdgeInsets.only(top: 10, right: 5, left: 5, bottom: 10),
              sliver: SliverToBoxAdapter(
                child: Container(
                  color: Colors.transparent,
                  height: orientation == Orientation.portrait
                      ? size.height * 0.91
                      : size.height * 0.87,
                  margin: const EdgeInsets.all(20),
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(microseconds: 200),
                        height: orientation == Orientation.portrait
                            ? isAppBarExpanded == false
                                ? size.height * 0.95
                                : size.height * 0.7
                            : isAppBarExpanded == false
                                ? size.height * 0.85
                                : size.height * 0.62,
                        margin: EdgeInsets.only(
                          bottom: 10,
                          top: 0.0,
                          left: orientation == Orientation.portrait ? 0 : 35,
                          right: orientation == Orientation.portrait ? 0 : 35,
                        ),
                        width: orientation == Orientation.portrait
                            ? size.width
                            : size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(colors: [
                            Colors.blue.withOpacity(0.2),
                            Colors.transparent,
                            Colors.blue.withOpacity(0.2),
                            Colors.blue.withOpacity(0.3),
                          ]),
                        ),
                        child: Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 10,
                              bottom: 35.0,
                            ),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection:
                                      orientation == Orientation.portrait
                                          ? Axis.vertical
                                          : Axis.horizontal,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxHeight:
                                            orientation == Orientation.portrait
                                                ? isAppBarExpanded == false
                                                    ? size.height * 0.83
                                                    : size.height * 0.64
                                                : isAppBarExpanded == false
                                                    ? size.height * 0.75
                                                    : size.height * 0.55,
                                        maxWidth:
                                            orientation == Orientation.portrait
                                                ? size.width
                                                : size.width),
                                    // Limitar la altura máxima
                                    child: SizedBox(
                                      width: size.width * 0.85,
                                      child: Stepper(
                                        type:
                                            orientation == Orientation.portrait
                                                ? StepperType.vertical
                                                : StepperType.horizontal,
                                        connectorThickness: 0.5,
                                        elevation: 10.0,
                                        currentStep: currentStep,
                                        connectorColor:
                                            MaterialStatePropertyAll(
                                                Constants.blueColor),
                                        onStepTapped: (int step) {
                                          setState(() {
                                            currentStep = step;
                                          });
                                        },
                                        onStepContinue: () {
                                          if (currentStep < 2) {
                                            setState(() {
                                              currentStep += 1;
                                            });
                                          }
                                        },
                                        onStepCancel: () {
                                          if (currentStep > 0) {
                                            setState(() {
                                              currentStep -= 1;
                                            });
                                          }
                                        },
                                        steps: <Step>[
                                          Step(
                                            title: const Text(
                                              "Datos generales",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            content: contentStep1(
                                                controllerClients,
                                                selectedGenero,
                                                itemsGenero,
                                                context,
                                                size),
                                            isActive: currentStep >= 0,
                                            state: currentStep > 0
                                                ? StepState.complete
                                                : StepState.indexed,
                                          ),
                                          Step(
                                            title: const Text(
                                              'Fotografía',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            content:
                                                contentStep2(size, orientation),
                                            isActive: currentStep >= 1,
                                            state: currentStep > 1
                                                ? StepState.complete
                                                : StepState.indexed,
                                          ),
                                          Step(
                                            title: const Text(
                                              'Finalizar',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            content: contentStep3(
                                                size,
                                                orientation,
                                                controllerClients,
                                                selectedGenero,
                                                imageUrl),
                                            isActive: currentStep >= 2,
                                            state: currentStep == 2
                                                ? StepState.complete
                                                : StepState.indexed,
                                          ),
                                        ],
                                        controlsBuilder: (BuildContext context,
                                            ControlsDetails details) {
                                          bool isLastStep = (currentStep == 2);
                                          return Container(
                                            alignment: Alignment.bottomLeft,
                                            color: Colors.transparent,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              verticalDirection:
                                                  VerticalDirection.down,
                                              children: <Widget>[
                                                if (!isLastStep)
                                                  Flexible(
                                                    flex: 1,
                                                    child: ElevatedButton(
                                                      onPressed: details
                                                          .onStepContinue,
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Constants
                                                                .blueColor
                                                                .withOpacity(
                                                                    0.7),
                                                      ),
                                                      child: const Text(
                                                        'Continuar',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),
                                                  ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Flexible(
                                                  flex: 1,
                                                  child: TextButton(
                                                    onPressed:
                                                        details.onStepCancel,
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Constants
                                                                    .orangeColor
                                                                    .withOpacity(
                                                                        0.35)),
                                                    child: const Text(
                                                      'Regresar',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column contentStep1(
    clientsController controllerClients,
    String selectedG,
    List<String> itemsGenero,
    BuildContext context,
    Size size,
  ) {
    return Column(children: [
      /* const SizedBox(
        height: 10,
      ),
      TextFormField(
          maxLength: 6,
          validator: (value) {
            if (value!.isEmpty) {
              return "Necesitás llenar el campo";
            }
            if (!RegExp(r'(^\d*?\d*)$').hasMatch(value)) {
              return "únicamente números enteros";
            }
            if (!((int.tryParse(value))! > 0)) {
              return "número mayor a 0";
            }

            return null;
          },
          controller: controllerClients.codigo_cliente,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            label: const Text("Código del cliente"),
            prefixIcon: Icon(
              Icons.numbers,
              color: Constants.blueColor,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                controllerClients.codigo_cliente.clear();
              },
              child: Icon(
                Icons.cancel,
                color: Constants.blueColor.withOpacity(0.7),
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular((10.0)),
                borderSide:
                    BorderSide(color: Colors.orange.withOpacity(.8), width: 3)),

            //
          )), */
      const SizedBox(height: 10),
      TextFormField(
        maxLength: 20,
        validator: (value) {
          if (value!.isEmpty) {
            return "Necesitás llenar el campo";
          } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
            return "Ingresé únicamente letras";
          } else if (value.length < 3) {
            return "El nombre es muy corto";
          }

          return null;
        },
        controller: controllerClients.nombre,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          label: const Text("Nombre"),
          prefixIcon: Icon(Icons.account_box, color: Constants.blueColor),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular((10.0)),
              borderSide:
                  BorderSide(color: Colors.orange.withOpacity(.8), width: 3)),
          suffixIcon: GestureDetector(
            onTap: () {
              controllerClients.nombre.clear();
            },
            child: Icon(
              Icons.cancel,
              color: Constants.blueColor.withOpacity(0.7),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      TextFormField(
          maxLength: 20,
          validator: (value) {
            if (value!.isEmpty) {
              return "Necesitás llenar el campo";
            } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
              return "Ingresé únicamente letras";
            } else if (value.length < 3) {
              return "El apellido es muy corto";
            }

            return null;
          },
          controller: controllerClients.apellido_p,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            label: const Text("Apellido paterno"),
            prefixIcon: Icon(Icons.switch_account, color: Constants.blueColor),
            suffixIcon: GestureDetector(
              onTap: () {
                controllerClients.apellido_p.clear();
              },
              child: Icon(
                Icons.cancel,
                color: Constants.blueColor.withOpacity(0.7),
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular((10.0)),
                borderSide:
                    BorderSide(color: Colors.orange.withOpacity(.8), width: 3)),
          )),
      const SizedBox(height: 10),
      TextFormField(
          maxLength: 20,
          validator: (value) {
            if (value!.isEmpty) {
              return "Necesitás llenar el campo";
            } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
              return "Ingresé únicamente letras";
            } else if (value.length < 3) {
              return "El apellido es muy corto";
            }

            return null;
          },
          controller: controllerClients.apellido_m,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            label: const Text("Apellido materno"),
            prefixIcon: Icon(Icons.switch_account, color: Constants.blueColor),
            suffixIcon: GestureDetector(
              onTap: () {
                controllerClients.apellido_m.clear();
              },
              child: Icon(
                Icons.cancel,
                color: Constants.blueColor.withOpacity(0.7),
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular((10.0)),
                borderSide:
                    BorderSide(color: Colors.orange.withOpacity(.8), width: 3)),
          )),
      const SizedBox(height: 10),
      DropdownButtonFormField<String>(
        validator: (value) {
          if (value.toString().isEmpty) {
            return "Necesitás llenar el campo";
          }
          if (isTouched == false) {
            return 'Por favor seleccione una opción';
          }
          return null;
        },
        icon: const Icon(
          Icons.abc,
          color: Colors.transparent,
          size: null,
        ),
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(left: 5, right: 10, top: 20, bottom: 10),
            label: const Text("Género"),
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
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(width: 3, color: Colors.orange))),
        value: selectedG,
        items: itemsGenero
            .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item,
                    style: TextStyle(
                        fontSize: 17, color: Colors.black.withOpacity(.7)))))
            .toList(),
        onChanged: (item) => setState(() {
          selectedG = item!;

          selectedGenero = selectedG;
          isTouched = true;
        }),
      ),
      const SizedBox(height: 20),
      TextFormField(
        maxLength: 18,
        inputFormatters: [
          TextInputFormatter.withFunction((oldValue, newValue) =>
              upperCaseTextFormatter(oldValue,
                  newValue)), // Aquí aplicamos el formateador personalizado
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return "Necesitás llenar el campo";
          } else if (!RegExp(
                  r'^([A-Z][AEIOUX][A-Z]{2}\d{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[12]\d|3[01])[HM](?:AS|B[CS]|C[CLMSH]|D[FG]|G[TR]|HG|JC|M[CNS]|N[ETL]|OC|PL|Q[TR]|S[PLR]|T[CSL]|VZ|YN|ZS)[B-DF-HJ-NP-TV-Z]{3}[A-Z\d])(\d)$')
              .hasMatch(value)) {
            return "CURP válido ";
          } else if (value.length < 18) {
            return "El Curp es muy corto";
          }

          return null;
        },
        controller: controllerClients.curp,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          label: const Text("Curp"),
          prefixIcon:
              Icon(Icons.text_snippet_outlined, color: Constants.blueColor),
          suffixIcon: GestureDetector(
            onTap: () {
              controllerClients.curp.clear();
            },
            child: Icon(
              Icons.cancel,
              color: Constants.blueColor.withOpacity(0.7),
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular((10.0)),
              borderSide:
                  BorderSide(color: Colors.orange.withOpacity(.8), width: 3)),
        ),
      ),
      const SizedBox(height: 10),
      TextFormField(
          maxLength: 35,
          validator: (value) {
            if (value!.isEmpty) {
              return "Necesitás llenar el campo";
            }
            if (!RegExp(r'^[a-z A-Z 0-9 \# \.]+$').hasMatch(value)) {
              return "Ingresé únicamente letras";
            }
            if (value.length < 3) {
              return "El nombre es muy corto";
            }

            return null;
          },
          controller: controllerClients.calle,
          keyboardType: TextInputType.streetAddress,
          decoration: InputDecoration(
            label: const Text("Calle, #Ext"),
            prefixIcon: Icon(Icons.house, color: Constants.blueColor),
            suffixIcon: GestureDetector(
              onTap: () {
                controllerClients.calle.clear();
              },
              child: Icon(
                Icons.cancel,
                color: Constants.blueColor.withOpacity(0.7),
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular((10.0)),
                borderSide:
                    BorderSide(color: Colors.orange.withOpacity(.8), width: 3)),
          )),
      const SizedBox(height: 10),
      TextFormField(
          maxLength: 35,
          validator: (value) {
            if (value!.isEmpty) {
              return "Necesitás llenar el campo";
            } else if (!RegExp(r'^[a-z A-Z 0-9 \. \#]+$').hasMatch(value)) {
              return "Ingresé únicamente letras";
            } else if (value.length < 3) {
              return "El nombre es muy corto";
            }

            return null;
          },
          controller: controllerClients.colonia,
          keyboardType: TextInputType.streetAddress,
          decoration: InputDecoration(
            label: const Text("Colonia"),
            prefixIcon: Icon(Icons.location_city, color: Constants.blueColor),
            suffixIcon: GestureDetector(
              onTap: () {
                controllerClients.colonia.clear();
              },
              child: Icon(
                Icons.cancel,
                color: Constants.blueColor.withOpacity(0.7),
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular((10.0)),
                borderSide:
                    BorderSide(color: Colors.orange.withOpacity(.8), width: 3)),
          )),
      const SizedBox(height: 10),
      TextFormField(
          maxLength: 25,
          validator: (value) {
            if (value!.isEmpty) {
              return "Necesitás llenar el campo";
            } else if (!RegExp(r'^[a-z A-Z 0-9]+$').hasMatch(value)) {
              return "Ingresé únicamente letras";
            } else if (value.length < 3) {
              return "El nombre es muy corto";
            }

            return null;
          },
          controller: controllerClients.municipio_delegacion,
          keyboardType: TextInputType.streetAddress,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 10),
            label: const Text("Municipio o Delegación"),
            prefixIcon:
                Icon(Icons.location_city_rounded, color: Constants.blueColor),
            suffixIcon: GestureDetector(
              onTap: () {
                controllerClients.municipio_delegacion.clear();
              },
              child: Icon(
                Icons.cancel,
                color: Constants.blueColor.withOpacity(0.7),
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular((10.0)),
                borderSide:
                    BorderSide(color: Colors.orange.withOpacity(.8), width: 3)),
          )),
      const SizedBox(height: 10),
      TextFormField(
          maxLength: 20,
          validator: (value) {
            if (value!.isEmpty) {
              return "Necesitás llenar el campo";
            } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
              return "Ingresé únicamente letras";
            } else if (value.length < 3) {
              return "El estado es muy corto";
            }

            return null;
          },
          controller: controllerClients.estado,
          keyboardType: TextInputType.streetAddress,
          decoration: InputDecoration(
            label: const Text("Estado"),
            prefixIcon: Icon(Icons.star_rate, color: Constants.blueColor),
            suffixIcon: GestureDetector(
              onTap: () {
                controllerClients.estado.clear();
              },
              child: Icon(
                Icons.cancel,
                color: Constants.blueColor.withOpacity(0.7),
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular((10.0)),
                borderSide:
                    BorderSide(color: Colors.orange.withOpacity(.8), width: 3)),
          )),
      const SizedBox(height: 10),
      TextFormField(
          maxLength: 5,
          validator: (value) {
            if (value!.isEmpty) {
              return "Necesitás llenar el campo";
            }

            if (value.length < 5) {
              return "Código postal invalido";
            } else if (!RegExp(r'^[0-9]{5}(?:-[0-9]{4})?$').hasMatch(value)) {
              return "Ingrese únicamente números,";
            }

            return null;
          },
          controller: controllerClients.codigo_postal,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            label: const Text("Código postal"),
            prefixIcon:
                Icon(Icons.numbers_outlined, color: Constants.blueColor),
            suffixIcon: GestureDetector(
              onTap: () {
                controllerClients.codigo_postal.clear();
              },
              child: Icon(
                Icons.cancel,
                color: Constants.blueColor.withOpacity(0.7),
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular((10.0)),
                borderSide:
                    BorderSide(color: Colors.orange.withOpacity(.8), width: 3)),
          )),
      const SizedBox(height: 10),
      TextFormField(
        validator: (value) {
          if (value.toString().isEmpty || value == null) {
            return "Necesitás llenar el campo";
          }

          return null;
        },
        controller: controllerClients.fecha_nacimiento,
        keyboardType: TextInputType.none,
        decoration: InputDecoration(
          label: const Text("Fecha de nacimiento "),
          prefixIcon: Icon(Icons.cake, color: Constants.blueColor),
          suffixIcon: Icon(Icons.touch_app, color: Constants.blueColor),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular((10.0)),
              borderSide:
                  BorderSide(color: Colors.orange.withOpacity(.8), width: 3)),
        ),
        onTap: () async {
          DateTime now = DateTime.now();
          DateTime firstDate = DateTime(1920);
          DateTime lastDate = DateTime(now.year - 17, now.month, now.day);

          pickeddate = await showDatePicker(
            context: context,
            initialDate: lastDate,
            firstDate: firstDate,
            lastDate: lastDate,
          );

          if (pickeddate != null) {
            /* String formattedDate = DateFormat('yyyy-MM-dd').format(pickeddate); */
            String formattedDate = DateFormat('dd-MM-yyyy').format(pickeddate!);
            setState(() {
              controllerClients.fecha_nacimiento =
                  TextEditingController(text: formattedDate);
            });
          }
        },
      ),
      const SizedBox(height: 20),
      TextFormField(
          maxLength: 10,
          validator: (value) {
            if (value!.isEmpty) {
              return "Necesitás llenar el campo";
            } else {
              if (!RegExp(r'(^\d*?\d*)$').hasMatch(value)) {
                return "Número de telefono invalido";
              } else if (!((value.length) >= 10)) {
                return "faltan dígitos ";
              }
            }

            return null;
          },
          controller: controllerClients.numero_tel,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            label: const Text(
              "Número de Teléfono",
            ),
            prefixIcon: Icon(Icons.phone, color: Constants.blueColor),
            suffixIcon: GestureDetector(
              onTap: () {
                controllerClients.numero_tel.clear();
              },
              child: Icon(
                Icons.cancel,
                color: Constants.blueColor.withOpacity(0.7),
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular((10.0)),
                borderSide:
                    BorderSide(color: Colors.orange.withOpacity(.8), width: 3)),
          )),
      const SizedBox(
        height: 25,
      ),
    ]);
  }

  Widget contentStep2(Size size, Orientation orientation) {
    return Container(
        //STEP NUMERO 2

        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
              height: orientation == Orientation.portrait
                  ? size.height * 0.28
                  : size.height * 0.28,
              width: orientation == Orientation.portrait
                  ? size.width * 0.45
                  : size.width * 0.30,
              child: imageUrl == ""
                  ? ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Image.asset(
                        profile,
                        fit: BoxFit.fill,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Image.file(
                        File(imageUrl),
                        fit: BoxFit.fill,
                        height: size.height,
                      ),
                    ),
            ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.normal),
              child: Column(children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.withOpacity(0.4),
                      elevation: 28),
                  onPressed: () async {
                    //cargar imagen de la camara
                    if (disable == true) {
                      authenticationRepository.showMessage("Aviso",
                          "YA SE CARGO LA FOTO\nNecesitas actualizar...");
                    } else {
                      await controllerClients
                          .takePhoto()
                          .then((value) => imageUrl = value.toString());

                      if (imageUrl.toString().isEmpty) {
                        printError(info: "NO HAY IMAGEN (NULL)");
                      } else {
                        printError(info: "Selecciono imagen");
                      }
                    }

                    setState(() {});
                  },
                  icon: Icon(
                    Icons.camera_alt,
                    size: 32,
                    color: Colors.blueGrey[700],
                  ),
                  label: const Text(
                    "Tomar Foto",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                SizedBox(height: orientation == Orientation.portrait ? 20 : 0)
              ]),
            ),
            SizedBox(
              height: orientation == Orientation.portrait ? 20 : 5,
            )
          ],
        ));
  }

  Widget contentStep3(
    Size size,
    Orientation orientation,
    clientsController controller,
    String selectedGenero,
    String imgUrl,
  ) {
    return Container(
        //STEP NUMERO 3

        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.normal),
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.withOpacity(0.7),
                      elevation: 35),
                  onPressed: () async {
                    buttonRegister(
                      controller,
                      selectedGenero,
                      size,
                      imgUrl,
                    );
                  },
                  icon: const Icon(
                    Icons.save,
                    size: 35,
                    color: Colors.black,
                  ),
                  label: const Text(
                    "Registrar ",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ));
  }

  Future<void> buttonRegister(
    clientsController controller,
    String selectedGenero,
    Size size,
    String imagUrl,
  ) async {
    imageUrl = imagUrl;
    bool register = false;
    try {
/**Validaciones **/ if (formKey.currentState!.validate()) {
        //MENSAJE DE IMAGEN NULA
        if (imagUrl.isEmpty) {
          authenticationRepository.showMessage(
              "Aviso", "Te falta agregar una foto");
          /*   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.cyan,
                    content: Text("NO hay imagen")));
                print("imageUrl {${imageUrl} ${ImagenURl}");
                */
          return;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              elevation: 20.0,
              backgroundColor: Constants.blueColor.withOpacity(0.5),
              content: const Text("Cargando..."),
              behavior: SnackBarBehavior.floating,
            ),
          );
          await Future.delayed(const Duration(seconds: 2));
          await clientsController()
              .uploadPhoto(imagUrl)
              .then((value) => imageUrl2 = value.toString());
        }

        showDialog(
          barrierDismissible: false,
          builder: (context) {
            return Center(
                child: SpinKitRing(
              color: Colors.orange.withOpacity(0.9),
              size: 50.0,
              lineWidth: 4,
              duration: const Duration(seconds: 3),
            ));
          },
          // ignore: use_build_context_synchronously
          context: context,
        );

        try {
          if (mounted) {
            await clientsController()
                .createClients(
              nombre: controller.nombre.text.toUpperCase().trim(),
              apellido_p: controller.apellido_p.text.toUpperCase().trim(),
              apellido_m: controller.apellido_m.text.toUpperCase().trim(),
              genero: selectedGenero.toString().trim().toUpperCase(),
              calle: controller.calle.text.toUpperCase().trim(),
              municipio_delegacion:
                  controller.municipio_delegacion.text.toUpperCase().trim(),
              colonia: controller.colonia.text.toUpperCase().trim(),
              estado: controller.estado.text.toUpperCase().trim(),
              curp: controller.curp.text.toUpperCase().replaceAll(" ", ""),
              /* codigo_cliente: controller.codigo_cliente.text
                  .toUpperCase()
                  .replaceAll(" ", ""), */
              codigo_postal: int.parse(controller.codigo_postal.text.trim()),
              fecha_nacimiento: DateTime.parse(
                  controller.fecha_nacimiento.text.split("-").reversed.join()),
              numero_tel: int.parse(controller.numero_tel.text.trim()),
              imageUrl: imageUrl2,
              context: context,
            )
                .then((value) {
              if (value == true) {
                setState(() {
                  register = true;
                  printInfo(info: "Se subio la información...");
                });
              }
            });
          }
          if (register == true) {
            Get.back();
            Get.back();
            authenticationRepository.showMessage(
                "Aviso", "Cliente registrado existosamente");
            deletecustomerfields(controllerClients);
            printInfo(info: "registro temminado: $register");
          } else if (register == false) {
            authenticationRepository.showMessage("Advertencia",
                "Cliente no se registro, verifique los datos e intente de nuevo");
          }
        } on FirebaseFirestore catch (_) {
          authenticationRepository.showMessage(
              "Advertencia", "Error Firebase ");
        } catch (_) {
          Get.back();
          authenticationRepository.showMessage(
              "Advertencia", "Algo salío mal verifique los datos");
        }

        //TERMINA LA CONDICIÓN DE VALIDACIÓN
      } else {
        authenticationRepository.showMessage(
            "Advertencia", "Error de registro verifique los datos");
      }
    } catch (e) {
      printError(info: "$e");
    }
  }

  TextEditingValue upperCaseTextFormatter(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }

  void deletecustomerfields(clientsController controller) {
    controller.codigo_cliente.clear();

    controller.nombre.clear();
    controller.apellido_m.clear();
    controller.apellido_p.clear();
    controller.genero.clear();
    controller.calle.clear();
    controller.municipio_delegacion.clear();
    controller.colonia.clear();
    controller.estado.clear();
    controller.curp.clear();
    controller.codigo_postal.clear();
    controller.fecha_nacimiento.clear();
    controller.numero_tel.clear();
  }
}
