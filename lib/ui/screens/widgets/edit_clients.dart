import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobranzas/controllers/clients_Controller.dart';
import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/models/custom_text_title.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditClients extends StatefulWidget {
  final String idClient;
  final String nombre;
  final String apellidoP;
  final String apellidoM;
  final String genero;
  final String curp;
  final String calle;
  final String colonia;
  final String municioDelegacion;
  final String estado;
  final int codigoPostal;
  final DateTime fechaNacimiento;
  final int tel;
  final String urlFoto;

  const EditClients({
    super.key,
    required this.idClient,
    required this.nombre,
    required this.apellidoP,
    required this.apellidoM,
    required this.genero,
    required this.curp,
    required this.calle,
    required this.colonia,
    required this.municioDelegacion,
    required this.estado,
    required this.codigoPostal,
    required this.fechaNacimiento,
    required this.tel,
    required this.urlFoto,
  });

  @override
  State<EditClients> createState() => EditClientsState();
}

class EditClientsState extends State<EditClients> {
  static var controllerClients = Get.put(clientsController());
  final formKey = GlobalKey<FormState>();
  late String fondoNewUser = "";

  bool isLoading = false;
  bool selectedmenu = false;

// todo : menu desplegable
  List<String> itemsGenero = [
    'Hombre',
    'Mujer',
  ];
  late String selectedGenero = "Mujer";
  bool isTouched = false;

  @override
  void initState() {
    fondoNewUser = "assets/pantallaEditarCliente.png";

    selectedGenero = firstCapitalLetter(widget.genero);
    controllerClients.EditNombre = TextEditingController(text: widget.nombre);

    controllerClients.EditApellido_p =
        TextEditingController(text: widget.apellidoP);
    controllerClients.EditApellido_m =
        TextEditingController(text: widget.apellidoM);
    controllerClients.EditGenero = TextEditingController(text: widget.genero);
    controllerClients.EditCurp = TextEditingController(text: widget.curp);
    controllerClients.EditCalle = TextEditingController(text: widget.calle);
    controllerClients.EditColonia = TextEditingController(text: widget.colonia);
    controllerClients.EditMunicipio_delegacion =
        TextEditingController(text: widget.municioDelegacion);
    controllerClients.EditEstado = TextEditingController(text: widget.estado);
    controllerClients.EditCodigo_postal =
        TextEditingController(text: widget.codigoPostal.toString());
    controllerClients.EditFecha_nacimiento = TextEditingController(
        text: DateFormat('dd-MM-yyyy').format(widget.fechaNacimiento));
    controllerClients.EditNumero_tel =
        TextEditingController(text: widget.tel.toString());

    print(widget.idClient);
    print(widget.nombre);
    print(widget.apellidoP);
    print(widget.apellidoM);
    print(widget.genero);
    print(widget.curp);
    print(widget.calle);
    print(widget.colonia);
    print(widget.municioDelegacion);
    print(widget.estado);
    print("C.P ${widget.codigoPostal}");
    print(widget.fechaNacimiento);
    print(widget.tel);
    print(widget.urlFoto);

    super.initState();
  }

  String firstCapitalLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
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
                          left: size.width * 0.215,
                          top: size.height * 0.11,
                          bottom: 0.0,
                        ),
                        child: const CustomTextTitle(
                          title: 'EDITAR USUARIO',
                          size: 14.0,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.28, bottom: 0.01),
                        child: const CustomTextTitle(
                          title: 'EDITAR USUARIO',
                          size: 17.0,
                        ),
                      ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    orientation == Orientation.portrait
                        ? Positioned(
                            left: size.width * 0.01,
                            top: size.height * 0.0001,
                            right: size.width * 0.4,
                            bottom: size.height * -0.08,
                            child: Image.asset(
                              fondoNewUser, //imagen AppBar
                              fit: BoxFit
                                  .fitHeight, // Cubrir para que la imagen se expanda bien
                            ),
                          )
                        : Positioned(
                            left: size.width * 0.05,
                            top: size.height * 0.0001,
                            right: size.width * 0.5,
                            bottom: size.height * -0.08,
                            child: Image.asset(
                              fondoNewUser, //imagen AppBar
                              fit: BoxFit
                                  .fill, // Cubrir para que la imagen se expanda bien
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
                                  TextFormField(
                                    controller: controllerClients.EditNombre,
                                    maxLength: 35,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Ingresa un nombre';
                                      }

                                      if (value.length < 3) {
                                        return 'El nombre debe tener al menos 3 caracteres';
                                      }

                                      // Expresión regular para validar el nombre completo
                                      RegExp regExp = RegExp(
                                        r'^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ]+(?: [a-zA-ZáéíóúÁÉÍÓÚüÜñÑ]+)*$',
                                      );

                                      if (!regExp.hasMatch(value)) {
                                        return 'Ingresa un nombre válido';
                                      }

                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      label: const Text("Nombre"),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Constants.blueColor,
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          controllerClients.EditNombre.clear();
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
                                    controller:
                                        controllerClients.EditApellido_p,
                                    maxLength: 35,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Ingresa un apellido';
                                      }

                                      if (value.length < 3) {
                                        return 'El apellido debe tener al menos 3 caracteres';
                                      }

                                      // Expresión regular para validar el nombre completo
                                      RegExp regExp = RegExp(
                                        r'^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ]+(?: [a-zA-ZáéíóúÁÉÍÓÚüÜñÑ]+)*$',
                                      );

                                      if (!regExp.hasMatch(value)) {
                                        return 'Ingresa un apellido válido';
                                      }

                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      label: const Text("Apellido Paterno"),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Constants.blueColor,
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          controllerClients.EditApellido_p
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
                                    maxLength: 20,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Necesitás llenar el campo";
                                      } else if (!RegExp(r'^[a-z A-Z]+$')
                                          .hasMatch(value)) {
                                        return "Ingresé únicamente letras";
                                      } else if (value.length < 3) {
                                        return "El apellido es muy corto";
                                      }

                                      return null;
                                    },
                                    controller:
                                        controllerClients.EditApellido_m,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      label: const Text("Apellido Materno"),
                                      prefixIcon: Icon(Icons.switch_account,
                                          color: Constants.blueColor),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          controllerClients.EditApellido_m
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
                                              color:
                                                  Colors.orange.withOpacity(.8),
                                              width: 3)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  DropdownButtonFormField<String>(
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
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                                width: 3,
                                                color: Colors.orange))),
                                    value: selectedGenero,
                                    items: itemsGenero
                                        .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black
                                                        .withOpacity(.7)))))
                                        .toList(),
                                    onChanged: (item) => setState(() {
                                      selectedGenero = item!;
                                      isTouched = true;
                                    }),
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return "Necesitás llenar el campo";
                                      }
                                      if (isTouched == false) {
                                        return 'Por favor seleccione una opción';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  TextFormField(
                                    maxLength: 18,
                                    inputFormatters: [
                                      TextInputFormatter.withFunction((oldValue,
                                              newValue) =>
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
                                    controller: controllerClients.EditCurp,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      label: const Text("Curp"),
                                      prefixIcon: Icon(
                                          Icons.text_snippet_outlined,
                                          color: Constants.blueColor),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          controllerClients.EditCurp.clear();
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
                                              width: 3)),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    maxLength: 35,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Necesitás llenar el campo";
                                      }
                                      if (!RegExp(r'^[a-z A-Z 0-9 \# \.]+$')
                                          .hasMatch(value)) {
                                        return "Ingresé únicamente letras";
                                      }
                                      if (value.length < 3) {
                                        return "El nombre es muy corto";
                                      }

                                      return null;
                                    },
                                    controller: controllerClients.EditCalle,
                                    keyboardType: TextInputType.streetAddress,
                                    decoration: InputDecoration(
                                      label: const Text("Calle, #Ext"),
                                      prefixIcon: Icon(Icons.house,
                                          color: Constants.blueColor),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          controllerClients.EditCalle.clear();
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
                                              width: 3)),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                      maxLength: 35,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Necesitás llenar el campo";
                                        } else if (!RegExp(
                                                r'^[a-z A-Z 0-9 \. \#]+$')
                                            .hasMatch(value)) {
                                          return "Ingresé únicamente letras";
                                        } else if (value.length < 3) {
                                          return "El nombre es muy corto";
                                        }

                                        return null;
                                      },
                                      controller: controllerClients.EditColonia,
                                      keyboardType: TextInputType.streetAddress,
                                      decoration: InputDecoration(
                                        label: const Text("Colonia"),
                                        prefixIcon: Icon(Icons.location_city,
                                            color: Constants.blueColor),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            controllerClients.EditColonia
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
                                  TextFormField(
                                      maxLength: 25,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Necesitás llenar el campo";
                                        } else if (!RegExp(r'^[a-z A-Z 0-9]+$')
                                            .hasMatch(value)) {
                                          return "Ingresé únicamente letras";
                                        } else if (value.length < 3) {
                                          return "El nombre es muy corto";
                                        }

                                        return null;
                                      },
                                      controller: controllerClients
                                          .EditMunicipio_delegacion,
                                      keyboardType: TextInputType.streetAddress,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.only(top: 10),
                                        label: const Text(
                                            "Municipio o Delegación"),
                                        prefixIcon: Icon(
                                            Icons.location_city_rounded,
                                            color: Constants.blueColor),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            controllerClients
                                                    .EditMunicipio_delegacion
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
                                  TextFormField(
                                      maxLength: 20,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Necesitás llenar el campo";
                                        } else if (!RegExp(r'^[a-z A-Z]+$')
                                            .hasMatch(value)) {
                                          return "Ingresé únicamente letras";
                                        } else if (value.length < 3) {
                                          return "El estado es muy corto";
                                        }

                                        return null;
                                      },
                                      controller: controllerClients.EditEstado,
                                      keyboardType: TextInputType.streetAddress,
                                      decoration: InputDecoration(
                                        label: const Text("Estado"),
                                        prefixIcon: Icon(Icons.star_rate,
                                            color: Constants.blueColor),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            controllerClients.EditEstado
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
                                  TextFormField(
                                      maxLength: 5,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Necesitás llenar el campo";
                                        }

                                        if (value.length < 5) {
                                          return "Código postal invalido";
                                        } else if (!RegExp(
                                                r'^[0-9]{5}(?:-[0-9]{4})?$')
                                            .hasMatch(value)) {
                                          return "Ingrese únicamente números,";
                                        }

                                        return null;
                                      },
                                      controller:
                                          controllerClients.EditCodigo_postal,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        label: const Text("Código postal"),
                                        prefixIcon: Icon(Icons.numbers_outlined,
                                            color: Constants.blueColor),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            controllerClients.EditCodigo_postal
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
                                  TextFormField(
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return "Necesitás llenar el campo";
                                      }
                                      return null;
                                    },
                                    controller:
                                        controllerClients.EditFecha_nacimiento,
                                    keyboardType: TextInputType.none,
                                    decoration: InputDecoration(
                                      label: const Text("Fecha de nacimiento "),
                                      prefixIcon: Icon(Icons.cake,
                                          color: Constants.blueColor),
                                      suffixIcon: Icon(Icons.touch_app,
                                          color: Constants.blueColor),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular((10.0)),
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.orange.withOpacity(.8),
                                              width: 3)),
                                    ),
                                    onTap: () async {
                                      DateTime now = DateTime.now();
                                      DateTime firstDate = DateTime(1920);
                                      DateTime lastDate = DateTime(
                                          now.year - 17, now.month, now.day);

                                      DateTime? pickeddate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: lastDate,
                                        firstDate: firstDate,
                                        lastDate: lastDate,
                                      );

                                      if (pickeddate != null) {
                                        /* String formattedDate = DateFormat('yyyy-MM-dd').format(pickeddate); */
                                        String formattedDate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(pickeddate);
                                        setState(() {
                                          controllerClients
                                                  .EditFecha_nacimiento =
                                              TextEditingController(
                                                  text: formattedDate);
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
                                          if (!RegExp(r'(^\d*?\d*)$')
                                              .hasMatch(value)) {
                                            return "Número de telefono invalido";
                                          }
                                          if (((value.length) < 10)) {
                                            return "faltan dígitos ";
                                          }
                                        }

                                        return null;
                                      },
                                      controller:
                                          controllerClients.EditNumero_tel,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        label: const Text(
                                          "Número de Teléfono",
                                        ),
                                        prefixIcon: Icon(Icons.phone,
                                            color: Constants.blueColor),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            controllerClients.EditNumero_tel
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
                                    height: 25,
                                  ),

//todo: fin del formulario //

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
                                                        "Guardar cambios",
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
    /*  userController.emailUser.clear();
    userController.passwordUser.clear();
    userController.fullName.clear();
    userController.addressUser.clear();
    userController.telUser.clear(); */
  }
  TextEditingValue upperCaseTextFormatter(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
