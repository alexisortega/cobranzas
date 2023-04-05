// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobranzas/constants.dart';
import 'package:cobranzas/controllers/clients_Controller.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

class Newcustomers extends StatefulWidget {
  const Newcustomers({
    super.key,
  });

  @override
  State<Newcustomers> createState() => _NewcustomersState();
}

class _NewcustomersState extends State<Newcustomers> {
  final controller4 = Get.put(clientsController());
  static final formKey2 = GlobalKey<FormState>();
  int _currentStep = 0;
  String profile = "";

  @override
  void initState() {
    super.initState();

    profile = "assets/profile2.png";
  }

  String imageUrl = "";
  String imageUrl2 = "";
  bool disable = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<String> itemsGenero = [
      "Genero",
      'Hombre',
      'Mujer',
    ];
    String? selectedGenero = 'Genero';

    return SafeArea(
      child: Scaffold(
        body: Stack(
          // ignore: sort_child_properties_last

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
                      /*GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.orangeAccent.withOpacity(.5),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.save,
                              color: Constants.primaryColor,
                              size: 25,
                            ),
                          ),
                        ),
                      ),*/
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
                                  'NUEVO CLIENTE',
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
                              image: const AssetImage("assets/clientes.png")),
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(colors: [
                          Colors.blue.withOpacity(0.2),
                          Colors.transparent,
                          Colors.blue.withOpacity(0.2),
                          Colors.blue.withOpacity(0.3),
                        ])),
                    child: Form(
                      key: formKey2,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Stepper(
                              steps: [
                                Step(
                                  state: _currentStep >= 0
                                      ? StepState.complete
                                      : StepState.indexed,
                                  isActive: _currentStep >= 0,
                                  title: const Text(
                                    "Datos generales",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17),
                                  ),
                                  content: ContentStep1(
                                      controller4,
                                      selectedGenero,
                                      itemsGenero,
                                      context,
                                      size),
                                ),
                                Step(
                                    state: _currentStep >= 1
                                        ? StepState.complete
                                        : StepState.indexed,
                                    isActive: _currentStep >= 0,
                                    title: const Text(
                                      "Encuesta Socio-Económica",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17),
                                    ),
                                    content: ContentStep2()),
                                Step(
                                    state: _currentStep >= 2
                                        ? StepState.complete
                                        : StepState.indexed,
                                    isActive: _currentStep >= 0,
                                    title: const Text(
                                      "Identificación",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17),
                                    ),
                                    content: ContentStep3(size)),
                              ],
                              currentStep: _currentStep,
                              onStepCancel: () {
                                if (_currentStep != 0) {
                                  setState(() => _currentStep--);
                                }
                              },
                              onStepContinue: () {
                                if (_currentStep != 2) {
                                  setState(() => _currentStep++);
                                }
                              },
                              type: StepperType.vertical,
                              onStepTapped: (index) {
                                setState(() => _currentStep = index);
                              },
                              physics: const ScrollPhysics(),
                              elevation: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 20, bottom: 20, right: 20),
                              child: bottonRegisterCustomer(
                                  controller4, selectedGenero, size, imageUrl),
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
    );
  }

  Container ContentStep3(Size size) {
    return Container(
        //STEP NUMERO 3
        width: size.width,
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
              height: size.height * 0.3,
              width: size.width * 0.5,
              child: imageUrl == ""
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        profile,
                        fit: BoxFit.fill,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(30),
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
                TextButton.icon(
                  onPressed: () async {
                    //cargar imagen de la camara
                    if (disable == true) {
                      authenticationRepository.validaciones(
                          "YA SE CARGO LA FOTO\nNecesitas actualizar...");
                    } else {
                      await controller4.TakePhoto(imageUrl)
                          .then((value) => imageUrl = value.toString());

                      if (imageUrl.toString().isEmpty) {
                        print("NO HAY IMAGEN (NULL)");
                      } else {
                        print("Selecciono imagen");
                      }
                    }

                    setState(() {});

                    /*   ImagePicker imageCustomer =
                                              ImagePicker();
                                          XFile? file =
                                              await imageCustomer.pickImage(
                                                  source:
                                                      ImageSource.gallery);
                                          if (file == null) return;
                                          String uniqueFileName =
                                              DateTime.now()
                                                  .millisecondsSinceEpoch
                                                  .toString();
                                                                  
                                          Reference referenceRoot =
                                              FirebaseStorage.instance.ref();
                                          Reference referenceDirImage =
                                              referenceRoot.child("images");
                                                                  
                                          Reference referenceImageToUpload =
                                              referenceDirImage
                                                  .child(uniqueFileName);
                                                                  
                                          try {
                                            await referenceImageToUpload
                                                .putFile(File(file.path));
                                            imageUrl =
                                                await referenceImageToUpload
                                                    .getDownloadURL();
                                          } catch (e) {
                                            print(
                                                "$e error referenceImageToUpload ");
                                          }
                                          */
                  },
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    size: 45,
                    color: Colors.orange[600],
                  ),
                  label: const Text(
                    "Fotografía",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ));
  }

  Container ContentStep2() {
    return Container(
      child: const Text("step 2"),
    );
  }

  Column ContentStep1(
    clientsController controller4,
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
            } else {
              if (!RegExp(r'(^\d*?\d*)$').hasMatch(value)) {
                return "únicamente números enteros";
              } else if (!((int.tryParse(value))! > 0)) {
                return "número mayor a 0";
              }
            }

            return null;
          },
          controller: controller4.codigo_cliente,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            label: const Text("Código del cliente"),
            prefixIcon: Icon(
              Icons.numbers,
              color: Constants.blueColor,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                controller4.codigo_cliente.clear();
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
        controller: controller4.nombre,
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
              controller4.nombre.clear();
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
          controller: controller4.apellido_p,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            label: const Text("Apellido paterno"),
            prefixIcon: Icon(Icons.switch_account, color: Constants.blueColor),
            suffixIcon: GestureDetector(
              onTap: () {
                controller4.apellido_p.clear();
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
          controller: controller4.apellido_m,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            label: const Text("Apellido materno"),
            prefixIcon: Icon(Icons.switch_account, color: Constants.blueColor),
            suffixIcon: GestureDetector(
              onTap: () {
                controller4.apellido_m.clear();
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
          item = selectedGenero;
        }),
      ),
      const SizedBox(height: 10),
      TextFormField(
          maxLength: 18,
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
          controller: controller4.curp,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            label: const Text("Curp"),
            prefixIcon:
                Icon(Icons.text_snippet_outlined, color: Constants.blueColor),
            suffixIcon: GestureDetector(
              onTap: () {
                controller4.curp.clear();
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
          controller: controller4.calle,
          keyboardType: TextInputType.streetAddress,
          decoration: InputDecoration(
            label: const Text("Calle, #Ext"),
            prefixIcon: Icon(Icons.house, color: Constants.blueColor),
            suffixIcon: GestureDetector(
              onTap: () {
                controller4.calle.clear();
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
          controller: controller4.colonia,
          keyboardType: TextInputType.streetAddress,
          decoration: InputDecoration(
            label: const Text("Colonia"),
            prefixIcon: Icon(Icons.location_city, color: Constants.blueColor),
            suffixIcon: GestureDetector(
              onTap: () {
                controller4.colonia.clear();
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
          controller: controller4.municipio_delegacion,
          keyboardType: TextInputType.streetAddress,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 10),
            label: const Text("Municipio o Delegación"),
            prefixIcon:
                Icon(Icons.location_city_rounded, color: Constants.blueColor),
            suffixIcon: GestureDetector(
              onTap: () {
                controller4.municipio_delegacion.clear();
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
          controller: controller4.estado,
          keyboardType: TextInputType.streetAddress,
          decoration: InputDecoration(
            label: const Text("Estado"),
            prefixIcon: Icon(Icons.star_rate, color: Constants.blueColor),
            suffixIcon: GestureDetector(
              onTap: () {
                controller4.estado.clear();
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
          controller: controller4.codigo_postal,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            label: const Text("Código postal"),
            prefixIcon:
                Icon(Icons.numbers_outlined, color: Constants.blueColor),
            suffixIcon: GestureDetector(
              onTap: () {
                controller4.codigo_postal.clear();
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
        controller: controller4.fecha_nacimiento,
        keyboardType: TextInputType.none,
        decoration: InputDecoration(
          label: const Text("Fecha de nacimiento "),
          prefixIcon: Icon(Icons.cake, color: Constants.blueColor),
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
              controller4.fecha_nacimiento.text =
                  pickeddate.toString().substring(0, 10);
            });
          }
        },
      ),
      const SizedBox(height: 10),
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
          controller: controller4.numero_tel,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            label: const Text(
              "Número de Teléfono",
            ),
            prefixIcon: Icon(Icons.phone, color: Constants.blueColor),
            suffixIcon: GestureDetector(
              onTap: () {
                controller4.numero_tel.clear();
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
      /*        
    TextFormField(
          maxLength: 20,
          validator: (value) {
            if (value!.isEmpty) {
              return "Necesitás llenar el campo";
            } else {
              if (!RegExp(r'(^\d*\.?\d*)$').hasMatch(value)) {
                return "Formato [0-0.0]";
              } else if (!(double.tryParse(value)! > 100)) {
                return "Tiene que ser mayor a 100";
              }
            }

            return null;
          },
          controller: controller4.monto_inicial,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            label: const Text("Cantidad otorgada"),
            prefixIcon: Icon(Icons.monetization_on, color: Constants.blueColor),
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
            } else {
              if (!RegExp(r'(^\d*\.?\d*)$').hasMatch(value)) {
                return "Formato [0-0.0]";
              } else if (!(double.tryParse(value)! > 100)) {
                return "Tiene que ser mayor a 100";
              }
            }

            return null;
          },
          controller: controller4.monto_solicitado,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            label: const Text("Monto solicitado"),
            prefixIcon: Icon(Icons.attach_money, color: Constants.blueColor),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular((10.0)),
                borderSide:
                    BorderSide(color: Colors.orange.withOpacity(.8), width: 3)),
          )),
      const SizedBox(height: 10),
      TextFormField(
          maxLength: 4,
          validator: (value) {
            if (value!.isEmpty) {
              return "Necesitás llenar el campo";
            } else {
              if (!RegExp(r'(^\d*\.?\d*)$').hasMatch(value)) {
                return "Formato [0-0.0]";
              } else if (!(double.tryParse(value)! >= 0 &&
                  double.tryParse(value)! < 101)) {
                return "Tiene que ser un porcentaje 0-100";
              }
            }

            return null;
          },
          controller: controller4.interes_asignado,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            label: const Text("Interés asignado"),
            prefixIcon:
                Icon(Icons.percent_outlined, color: Constants.blueColor),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular((10.0)),
                borderSide:
                    BorderSide(color: Colors.orange.withOpacity(.8), width: 3)),
          )),
      const SizedBox(height: 10),
      DropdownButtonFormField<String>(
        decoration: InputDecoration(
            label: const Text("Plazos diferidos"),
            prefix: Icon(
              Icons.timer_outlined,
              color: Constants.blueColor,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(width: 3, color: Colors.orange))),
        value: selectedPlazos,
        items: itemsPlazos
            .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item,
                    style: TextStyle(
                        fontSize: 17, color: Colors.black.withOpacity(.7)))))
            .toList(),
        onChanged: (item) => setState(() {
          item = selectedPlazos;
        }),
      ),
      const SizedBox(height: 15),
      TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Necesita llenar el campo';
          }
          return null;
        },
        controller: controller4.fecha_prestamo,
        keyboardType: TextInputType.none,
        decoration: InputDecoration(
          label: const Text("Fecha del prestamo"),
          prefixIcon: Icon(Icons.edit_calendar, color: Constants.blueColor),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  BorderSide(color: Colors.orange.withOpacity(.8), width: 3)),
        ),
        onTap: () async {
          DateTime? pickeddated = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1920),
              lastDate: DateTime(2099));

          if (pickeddated != null) {
            setState(() {
              controller4.fecha_prestamo.text =
                  pickeddated.toString().substring(0, 10);
            });
          }
        },
      ),
    */
      const SizedBox(
        height: 25,
      ),
    ]);
  }

  ElevatedButton bottonRegisterCustomer(
    clientsController controller4,
    String selectedGenero,
    Size size,
    String ImagenURl,
  ) {
    return ElevatedButton(
        autofocus: true,
        clipBehavior: Clip.none,
        onPressed: () async {
          /// GUARDAR DATOS GENERALES EN FIREBASE
          ImagenURl = imageUrl;
          bool register = false;
          try {
/**Validaciones **/ if (formKey2.currentState!.validate()) {
              //MENSAJE DE IMAGEN NULA
              if (ImagenURl.isEmpty) {
                authenticationRepository
                    .validaciones("Te falta agregar una foto");
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
                    .UploadPhoto(ImagenURl)
                    .then((value) => imageUrl2 = value.toString());
              }

              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return Center(
                        child: SpinKitRing(
                      color: Colors.orange.withOpacity(0.9),
                      size: 50.0,
                      lineWidth: 4,
                      duration: const Duration(seconds: 3),
                    ));
                  });

              try {
                await clientsController()
                    .createClients(
                  nombre: controller4.nombre.text.toUpperCase().trim(),
                  apellido_p: controller4.apellido_p.text.toUpperCase().trim(),
                  apellido_m: controller4.apellido_m.text.toUpperCase().trim(),
                  genero: selectedGenero.toString().trim().toUpperCase(),
                  calle: controller4.calle.text.toUpperCase().trim(),
                  municipio_delegacion: controller4.municipio_delegacion.text
                      .toUpperCase()
                      .trim(),
                  colonia: controller4.colonia.text.toUpperCase().trim(),
                  estado: controller4.estado.text.toUpperCase().trim(),
                  curp: controller4.curp.text.toUpperCase().replaceAll(" ", ""),
                  codigo_cliente: controller4.codigo_cliente.text
                      .toUpperCase()
                      .replaceAll(" ", ""),
                  codigo_postal:
                      int.parse(controller4.codigo_postal.text.trim()),
                  fecha_nacimiento:
                      DateTime.parse(controller4.fecha_nacimiento.text),
                  numero_tel: int.parse(controller4.numero_tel.text.trim()),
                  imageUrl: imageUrl2,
                )
                    .whenComplete(() {
                  setState(() {
                    register = true;
                    print("Se subio la información...");
                  });
                });

                if (register == true) {
                  Navigator.of(context).pop();
                  Get.back();
                  authenticationRepository
                      .validaciones("Cliente registrado existosamente");
                  deletecustomerfields();
                  print("registro temminado: $register");
                } else if (register == false) {
                  authenticationRepository
                      .validaciones("Cliente no se registro, intente de nuevo");
                }
              } on FirebaseFirestore catch (_) {
                authenticationRepository.validaciones("Error Firebase ");
              } catch (_) {
                authenticationRepository
                    .validaciones("Algo salío mal verifique los datos");
              }

              //TERMINA LA CONDICIÓN DE VALIDACIÓN
            } else {
              authenticationRepository
                  .validaciones("Error de registro verifique los datos");
            }
          } catch (e) {
            print(e.hashCode.toString());
          }
        }, //TERMINACION BOTON REGISTRAR
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Colors.cyan.withOpacity(.8),
            ),
            fixedSize: MaterialStatePropertyAll(
              Size.fromWidth(size.width / 2),
              //Size.fromHeight(size.height / 2)
            )),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.save_as,
              color: Colors.black,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Registrar",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ));
  }

  void deletecustomerfields() {
    controller4.codigo_cliente.clear();
    controller4.nombre.clear();
    controller4.apellido_m.clear();
    controller4.apellido_p.clear();
    controller4.genero.clear();
    controller4.calle.clear();
    controller4.municipio_delegacion.clear();
    controller4.colonia.clear();
    controller4.estado.clear();
    controller4.curp.clear();
    controller4.codigo_postal.clear();
    controller4.fecha_nacimiento.clear();
    controller4.numero_tel.clear();
  }
}
