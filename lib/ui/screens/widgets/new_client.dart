import 'package:cobranzas/controllers/clients_Controller.dart';
import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/models/custom_text_title.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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

  @override
  void initState() {
    fondoNewUser = "assets/clientes.png";
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;

    List<String> itemsGenero = [
      "Genero",
      'Hombre',
      'Mujer',
    ];
    String? selectedGenero = 'Genero';

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
              backgroundColor: Colors.red,
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
                            : isAppBarExpanded == true
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
                                            content: Text('Content for Step 2'),
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
                                            content: TextFormField(),
                                            isActive: currentStep >= 2,
                                            state: currentStep == 2
                                                ? StepState.complete
                                                : StepState.indexed,
                                          ),
                                        ],
                                        controlsBuilder: (BuildContext context,
                                            ControlsDetails details) {
                                          bool isLastStep = currentStep == 2;
                                          return Container(
                                            alignment: Alignment.bottomLeft,
                                            color: Colors.transparent,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
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
    String selectedGenero,
    List<String> itemsGenero,
    BuildContext context,
    Size size,
  ) {
    return Column(children: [
      const SizedBox(
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
          if (value.toString().isCaseInsensitiveContains("genero") ||
              value.toString().isEmpty) {
            return "Necesitás llenar el campo";
          } else {}
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
            label: const Text("Genero"),
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
        value: selectedGenero,
        items: itemsGenero
            .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item,
                    style: TextStyle(
                        fontSize: 17, color: Colors.black.withOpacity(.7)))))
            .toList(),
        onChanged: (item) => setState(() {
          selectedGenero = item!;
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
              return "CURP en mayúsculas ";
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
          )),
      const SizedBox(height: 10),
      TextFormField(
          maxLength: 35,
          validator: (value) {
            if (value!.isEmpty) {
              return "Necesitás llenar el campo";
            } else if (!RegExp(r'^[a-z A-Z 0-9 \# \.]+$').hasMatch(value)) {
              return "Ingresé únicamente letras";
            } else if (value.length < 3) {
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
          if (value.toString().isEmpty) {
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
          DateTime? pickeddate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1920),
              lastDate: DateTime(2099));

          if (pickeddate != null) {
            setState(() {
              controllerClients.fecha_nacimiento.text =
                  pickeddate.toString().substring(0, 10);
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
}

TextEditingValue upperCaseTextFormatter(
    TextEditingValue oldValue, TextEditingValue newValue) {
  return TextEditingValue(
    text: newValue.text.toUpperCase(),
    selection: newValue.selection,
  );
}
