import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobranzas/constants.dart';
import 'package:cobranzas/controllers/clients_Controller.dart';
import 'package:cobranzas/controllers/clients_dias_semana.dart';
import 'package:cobranzas/controllers/creditController.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:cobranzas/ui/screens/widgets/credit_simulation.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';

class NewCredit extends StatefulWidget {
  const NewCredit({super.key});

  @override
  State<NewCredit> createState() => _NewCreditState();
}

class _NewCreditState extends State<NewCredit> {
  static var controllerClientes = Get.put(clientsController());
  String selectedCustomer = "";
  List<String> List_dias = [];
  List<String> List_dias2 = [];

  bool dias_semana_error = false;
  String selectedPlazos = 'Selecciona un plazo';
  late DocumentSnapshot snap;
  List<String> snapList = [];

  final formKey3 = GlobalKey<FormState>();
  List<String> itemsPlazos = [
    'Selecciona un plazo',
    'Diario',
    'Semanal',
    'Quincenal',
    'Catorcenal',
    'Mensual',
  ];

  @override
  Widget build(BuildContext context) {
    var ListMenuCustomers = Future(() => []);
    Size size = MediaQuery.of(context).size;
    var controllerCredit = Get.put(creditController());

    @override
    void initState() {
      super.initState();
    }

    return SafeArea(
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
                          Navigator.pop(context);
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
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'NUEVO CRÉDITO',
                                  style: GoogleFonts.aldrich(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
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
                                  "assets/credit-card-machine.png")),
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
                                      maxLength: 6,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Necesitás llenar el campo";
                                        } else {
                                          if (!RegExp(r'(^\d*?\d*)$')
                                              .hasMatch(value)) {
                                            return "únicamente números enteros";
                                          } else if (!((int.tryParse(value))! >
                                              0)) {
                                            return "número mayor a 0";
                                          }
                                        }

                                        return null;
                                      },
                                      controller:
                                          controllerCredit.codigo_credito,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        label: const Text("Folío del crédito"),
                                        prefixIcon: Icon(
                                          Icons.numbers,
                                          color: Constants.blueColor,
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            controllerCredit.codigo_credito
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
                                    height: 2,
                                  ),
                                  Container(
                                    color: Colors.transparent,
                                    height: 100,
                                    width: size.width * .90,
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: controllerClientes.getClients(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData &&
                                              snapshot.data.toString() !=
                                                  '[]') {
                                            return const Center(
                                                child: Text("No hay datos"));
                                          } else {
                                            List<String> ItemsCreditsnames = [];
                                            for (int i = 0;
                                                i < snapshot.data!.docs.length;
                                                i++) {
                                              snap = snapshot.data!.docs[i];
                                              snapList.add(snap["nombre"]);

                                              ItemsCreditsnames.add(
                                                  snap["codigo_cliente"] +
                                                      " " +
                                                      snap["nombre"] +
                                                      " " +
                                                      snap["apellido_p"] +
                                                      " " +
                                                      snap["apellido_m"]);
                                            }
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10, top: 10, left: 0),
                                              child: Container(
                                                child: DropdownSearch(
                                                  validator: (value) {
                                                    if (value
                                                            .toString()
                                                            .isEmpty ||
                                                        value == "") {
                                                      return "Necesitas llenar el campo";
                                                    }

                                                    return null;
                                                  },
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      prefixIcon: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              color: Colors
                                                                  .transparent,
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5),
                                                              child: Icon(
                                                                Icons
                                                                    .person_pin_outlined,
                                                                color: Constants
                                                                    .blueColor,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 1,
                                                          ),
                                                          Expanded(
                                                            flex: 6,
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Container(
                                                                color: Colors
                                                                    .transparent,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 10,
                                                                        bottom:
                                                                            10),
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            5,
                                                                        top: 5,
                                                                        left: 2,
                                                                        right:
                                                                            40),
                                                                child: selectedCustomer ==
                                                                        ""
                                                                    ? const Text(
                                                                        "Propietario del crédito",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black54,
                                                                            fontSize: 15),
                                                                      )
                                                                    : Text(
                                                                        selectedCustomer,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Constants.blueColor),
                                                                      ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            width: 3,
                                                            color: Constants
                                                                .orangeColor),
                                                      ),
                                                    ),
                                                  ),
                                                  popupProps: PopupProps.menu(
                                                    showSearchBox: true,
                                                    fit: FlexFit.loose,
                                                    constraints:
                                                        const BoxConstraints
                                                            .tightFor(),
                                                    title: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(Icons.search,
                                                              color: Constants
                                                                  .blueColor),
                                                          const SizedBox(
                                                              width: 5),
                                                          Text(
                                                            "Buscar nombre",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: Constants
                                                                    .blueColor),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    menuProps: const MenuProps(
                                                        shadowColor:
                                                            Colors.blue,
                                                        elevation: 20.0,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10),
                                                        )),
                                                  ),
                                                  autoValidateMode:
                                                      AutovalidateMode.disabled,
                                                  items: ItemsCreditsnames,
                                                  onChanged: (value) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .hideCurrentSnackBar();
                                                    final snackBar = SnackBar(
                                                      duration: const Duration(
                                                          milliseconds: 1650),
                                                      backgroundColor: Constants
                                                          .blueColor
                                                          .withOpacity(0.5),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      dismissDirection:
                                                          DismissDirection
                                                              .startToEnd,
                                                      content: Text(
                                                        "CLIENTE: ${value}",
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    );
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      snackBar,
                                                    );

                                                    setState(
                                                      () {
                                                        selectedCustomer =
                                                            value;
                                                        print(selectedCustomer);
                                                      },
                                                    );
                                                  },
                                                  selectedItem:
                                                      selectedCustomer,
                                                ),
                                              ),
                                            );
                                          }
                                        }),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextFormField(
                                      maxLength: 10,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Necesitás llenar el campo";
                                        } else {
                                          if (!RegExp(r'(^\d*\.?\d*)$')
                                              .hasMatch(value)) {
                                            return "Formato [0-0.0]";
                                          } else if (!(double.tryParse(value)! >
                                              100)) {
                                            return "Tiene que ser mayor a 100";
                                          }
                                        }

                                        return null;
                                      },
                                      controller:
                                          controllerCredit.monto_solicitado,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        label: const Text("Monto"),
                                        prefixIcon: Icon(Icons.monetization_on,
                                            color: Constants.blueColor),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            controllerCredit.monto_solicitado
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
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                      maxLength: 5,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Necesitás llenar el campo";
                                        } else {
                                          if (!RegExp(r'(^\d*\.?\d*)$')
                                              .hasMatch(value)) {
                                            return "Formato [0/0.0]";
                                          } else if (!(double.tryParse(
                                                      value)! >=
                                                  0 &&
                                              double.tryParse(value)! < 1001)) {
                                            return "% 0-1000";
                                          }
                                        }

                                        return null;
                                      },
                                      controller:
                                          controllerCredit.interes_asignado,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        label: const Text(
                                            "Tasa de interesa anual"),
                                        prefixIcon: Icon(Icons.percent_outlined,
                                            color: Constants.blueColor),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            controllerCredit.interes_asignado
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
                                      )),
                                  const SizedBox(height: 10),
                                  DropdownButtonFormField<String>(
                                    validator: (value) {
                                      if (value.toString().isEmpty ||
                                          value == "Selecciona un plazo") {
                                        return "Necesitas llenar campo";
                                      }
                                      /* if ((value
                                                  .toString()
                                                  .isCaseInsensitiveContains(
                                                      "Pago único") ||
                                              value
                                                  .toString()
                                                  .isCaseInsensitiveContains(
                                                      "Pago unico")) &&
                                          (int.parse(controllerCredit
                                                  .numero_pagos.text) !=
                                              1)) {
                                        return "El número de pagos tiene que ser 1";
                                      }*/
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        label: const Text("Plazos diferidos"),
                                        prefix: Icon(
                                          Icons.timer_outlined,
                                          color: Constants.blueColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                                width: 3,
                                                color: Colors.orange))),
                                    value: selectedPlazos,
                                    items: itemsPlazos
                                        .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(item,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.black
                                                          .withOpacity(.7))),
                                            )))
                                        .toList(),
                                    onChanged: (item) => setState(() {
                                      selectedPlazos = item!;
                                    }),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                      maxLength: 4,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Necesitás llenar el campo";
                                        } else {
                                          if (!RegExp(r'(^\d*?\d*)$')
                                              .hasMatch(value)) {
                                            return "únicamente números enteros";
                                          } else if (!(int.tryParse(value)! >
                                                  0 &&
                                              int.tryParse(value)! <= 1000)) {
                                            return "[ 1-1000 ]";
                                          }
                                        }

                                        return null;
                                      },
                                      controller: controllerCredit.numero_pagos,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        label: const Text("Número de pagos"),
                                        prefixIcon: Icon(Icons.numbers_outlined,
                                            color: Constants.blueColor),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            controllerCredit.numero_pagos
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
                                      )),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  MultiSelectDialogField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        setState(() {
                                          dias_semana_error = true;
                                        });

                                        return 'Necesita llenar el campo';
                                      } else {
                                        setState(() {
                                          dias_semana_error = false;
                                        });
                                      }
                                      return null;
                                    },
                                    listType: MultiSelectListType.LIST,
                                    checkColor: Colors.white,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: dias_semana_error == false
                                          ? const BorderRadius.all(
                                              Radius.circular(10))
                                          : const BorderRadius.all(
                                              Radius.circular(0)),
                                      border: Border.all(
                                        color: dias_semana_error ==
                                                // ignore: dead_code
                                                true
                                            ? Colors.red.withOpacity(0.65)
                                            : Colors.orange,
                                        width: 3,
                                      ),
                                    ),
                                    buttonIcon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black54,
                                    ),
                                    buttonText: const Text(
                                      "Dias de cobranza",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    items: controllerCredit.listaDiasSemana
                                        .map((value) =>
                                            MultiSelectItem<DiasSeman>(
                                                value, value.nombre!))
                                        .toList(),
                                    title: Text(
                                      "Días de cobranzas",
                                      style:
                                          TextStyle(color: Constants.blueColor),
                                    ),
                                    selectedColor: Colors.blue.withOpacity(0.9),
                                    selectedItemsTextStyle:
                                        TextStyle(color: Colors.orange[800]),
                                    onConfirm: (value) {
                                      controllerCredit.selectedDias = value;
                                      controllerCredit
                                          .selectedDiasSemanaValue.value = "";
                                      for (var element
                                          in controllerCredit.selectedDias) {
                                        controllerCredit
                                                .selectedDiasSemanaValue.value =
                                            // ignore: prefer_interpolation_to_compose_strings
                                            "${controllerCredit.selectedDiasSemanaValue.value} " +
                                                element.nombre;
                                      }
                                      List_dias = controllerCredit
                                          .selectedDiasSemanaValue.value
                                          .split(" ");
                                      List_dias2 = List_dias.sublist(
                                          1, List_dias.length);

                                      print(List_dias2);
                                    },
                                    dialogHeight: size.height * 0.5,
                                    dialogWidth: size.width * 0.4,
                                    autovalidateMode: AutovalidateMode.disabled,
                                    cancelText: const Text("CANCELAR"),
                                    confirmText: const Text("ACEPTAR"),
                                    isDismissible: false,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Necesita llenar el campo';
                                      }
                                      return null;
                                    },
                                    controller: controllerCredit.fecha_prestamo,
                                    keyboardType: TextInputType.none,
                                    decoration: InputDecoration(
                                      label: const Text("Fecha del prestamo"),
                                      prefixIcon: Icon(Icons.edit_calendar,
                                          color: Constants.blueColor),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.orange.withOpacity(.8),
                                              width: 3)),
                                    ),
                                    onTap: () async {
                                      DateTime? pickeddated =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1920),
                                              lastDate: DateTime(2099));

                                      if (pickeddated != null) {
                                        setState(() {
                                          controllerCredit.fecha_prestamo.text =
                                              pickeddated
                                                  .toString()
                                                  .substring(0, 10);
                                        });
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: size.height * 0.1,
                                    width: size.width,
                                    color: Colors.transparent,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.cyan),
                                            child: TextButton(
                                              onPressed: () async {
//codicion de forms
                                                bool isloading = false;

                                                if (formKey3.currentState!
                                                    .validate()) {
//Loading...
                                                  isloading = true;
                                                  if (isloading == true) {
                                                    Get.to(
                                                      () => creditSimulation(
                                                        numero_pagos: int.parse(
                                                          controllerCredit
                                                              .numero_pagos
                                                              .text,
                                                        ),
                                                        plazos: selectedPlazos,
                                                        monto_solicitado: double
                                                            .parse(controllerCredit
                                                                .monto_solicitado
                                                                .text),
                                                        fecha_prestamo:
                                                            DateTime.parse(
                                                                controllerCredit
                                                                    .fecha_prestamo
                                                                    .text),
                                                        interes_asignado: double
                                                            .parse(controllerCredit
                                                                .interes_asignado
                                                                .text),
                                                      ),
                                                    );

                                                    showDialog(
                                                        barrierDismissible:
                                                            false,
                                                        context: context,
                                                        builder: (context) {
                                                          return Center(
                                                              child:
                                                                  SpinKitRing(
                                                            color: Colors.orange
                                                                .withOpacity(
                                                                    0.9),
                                                            size: 50.0,
                                                            lineWidth: 4,
                                                            duration:
                                                                const Duration(
                                                                    seconds: 3),
                                                          ));
                                                        });

                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 2500),
                                                        () {
                                                      setState(() {
                                                        isloading = false;
                                                        Get.back();
                                                      });
                                                    });
                                                  }
                                                }

                                                //
                                              },
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      color: Colors.transparent,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: const [
                                                          Icon(
                                                            Icons
                                                                .sentiment_neutral_rounded,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text("Simular",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              //termina la función del botón
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color:
                                                  Colors.cyan.withOpacity(0.3),
                                            ),
                                            child: TextButton(
                                              onPressed: () async {
                                                //Method register
                                                bool register = false;
                                                try {
                                                  /*Empiza  condicion de forms*/
                                                  if (formKey3.currentState!
                                                      .validate()) {
                                                    //Loading...
                                                    showDialog(
                                                        barrierDismissible:
                                                            false,
                                                        context: context,
                                                        builder: (context) {
                                                          return Center(
                                                              child:
                                                                  SpinKitRing(
                                                            color: Colors.orange
                                                                .withOpacity(
                                                                    0.9),
                                                            size: 50.0,
                                                            lineWidth: 4,
                                                            duration:
                                                                const Duration(
                                                                    seconds: 3),
                                                          ));
                                                        });

                                                    await controllerCredit
                                                        .createCredits(
                                                      codigo_credito:
                                                          controllerCredit
                                                              .codigo_credito
                                                              .text,
                                                      propietario_credito:
                                                          selectedCustomer
                                                              .toString(),
                                                      monto_solicitado:
                                                          double.parse(
                                                        controllerCredit
                                                            .monto_solicitado
                                                            .text,
                                                      ),
                                                      interes_asignado:
                                                          double.parse(
                                                        controllerCredit
                                                            .interes_asignado
                                                            .text,
                                                      ),
                                                      plazos: selectedPlazos
                                                          .toString()
                                                          .trim()
                                                          .toUpperCase(),
                                                      dias_semana: List_dias2,
                                                      fecha_prestamo:
                                                          DateTime.parse(
                                                        controllerCredit
                                                            .fecha_prestamo
                                                            .text,
                                                      ),
                                                      numero_pagos: int.parse(
                                                          controllerCredit
                                                              .numero_pagos
                                                              .text),
                                                    )
                                                        .whenComplete(() {
                                                      setState(() {
                                                        register = true;
                                                      });
                                                    });
                                                    if (register == true) {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Get.back();
                                                      authenticationRepository
                                                          .validaciones(
                                                              "Crédito se registro existosamente");
                                                      deletecustomerfields();
                                                      print(
                                                          "registro temminado: $register");
                                                    } else if (register ==
                                                        false) {
                                                      authenticationRepository
                                                          .validaciones(
                                                              "Crédito no registrado, intente de nuevo");
                                                    }
                                                  } else {
                                                    authenticationRepository
                                                        .validaciones(
                                                            "Error de registro verifique los datos");
                                                  }
                                                } on FirebaseFirestore catch (_) {
                                                  authenticationRepository
                                                      .validaciones(
                                                          "Error de firebase");
                                                } catch (e) {
                                                  authenticationRepository
                                                      .validaciones(
                                                          "Error ${e.hashCode.toString()} ");
                                                }

                                                //Termino condición de formularios
                                              },
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: const [
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
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              //termina la función del botón
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
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

  void deletecustomerfields() {
    //limpiar datos
  }
}