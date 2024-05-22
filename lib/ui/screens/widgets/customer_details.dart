// ignore_for_file: camel_case_types, recursive_getters

import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cobranzas/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class customerDetails extends StatefulWidget {
  final int cont;
  final List datos;
  final String urlFoto;
  final String codigoCliente;
  final String nombre;
  final String apellidoP;
  final String apellidoM;
  final String genero;
  final String curp;
  final String calle;
  final String colonia;
  final String municipioDelegacion;
  final String estado;
  final int codigoPostal;
  final int numeroTel;
  final String fechaNacimiento;
  const customerDetails(
      {super.key,
      required this.cont,
      required this.datos,
      required this.codigoCliente,
      required this.nombre,
      required this.apellidoP,
      required this.apellidoM,
      required this.genero,
      required this.curp,
      required this.calle,
      required this.colonia,
      required this.municipioDelegacion,
      required this.estado,
      required this.codigoPostal,
      required this.numeroTel,
      required this.fechaNacimiento,
      required this.urlFoto});

  @override
  State<customerDetails> createState() => _customerViewState();
}

class _customerViewState extends State<customerDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.blue[50],
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                width: orientation == Orientation.portrait
                    ? size.width * 0.8
                    : size.width * 0.55,
                height: orientation == Orientation.portrait
                    ? size.height * 0.5
                    : size.height * 0.65,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50)),
                    child: Hero(
                      tag: widget.urlFoto,
                      child: CachedNetworkImage(
                        imageUrl: (widget.urlFoto),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              buttonArrow(size, orientation),
              scroll(
                  orientation,
                  widget.datos,
                  size,
                  widget.cont,
                  widget.codigoCliente,
                  widget.nombre,
                  widget.apellidoP,
                  widget.apellidoM,
                  widget.genero,
                  widget.curp,
                  widget.calle,
                  widget.colonia,
                  widget.municipioDelegacion,
                  widget.estado,
                  widget.codigoPostal.toString(),
                  widget.numeroTel.toString(),
                  widget.fechaNacimiento.toString(),
                  widget.urlFoto),
            ],
          ),
        ),
      ),
    );
  }
}

Widget scroll(
    Orientation orientation,
    List<dynamic> datos,
    Size size,
    int cont,
    String codigoCliente,
    String nombre,
    String apellidoP,
    String apellidoM,
    String genero,
    String curp,
    String calle,
    String colonia,
    String municipioDelegacion,
    String estado,
    String codigoPostal,
    String numeroTel,
    String fechaNacimiento,
    String urlFoto) {
  return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 1.0,
      minChildSize: 0.5,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.7),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.black87),
                        height: 6,
                        width: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    color: Colors.transparent,
                    height: size.height * 0.05,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: textViewCustomer(
                              texto: "Datos del cliente",
                              color: Constants.orangeColor,
                              size: 30,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: textViewCustomer(
                                  texto: "ID:$codigoCliente",
                                  color: Colors.red.withOpacity(0.9),
                                  size: 20),
                            ))
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white70,
                  ),
                  margin: EdgeInsets.only(
                    left: size.width * 0.035,
                    top: 15,
                  ),
                  padding: const EdgeInsets.all(15),
                  width: size.width * 0.89,
                  child: Column(
                    children: [
                      customerdate("Nombre:", nombre),
                      const SizedBox(
                        height: 5,
                      ),
                      customerdate("Apellido Paterno:", apellidoP),
                      const SizedBox(
                        height: 5,
                      ),
                      customerdate("Apellido Materno:", apellidoM),
                      const SizedBox(
                        height: 5,
                      ),
                      customerdate("Genero:", genero),
                      const SizedBox(
                        height: 5,
                      ),
                      customerdate("Curp", curp),
                      const SizedBox(
                        height: 5,
                      ),
                      customerdate("Fecha de\nnacimiento:", fechaNacimiento),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 27, top: 10),
                  child: textViewCustomer(
                    texto: "Contacto:",
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white70,
                  ),
                  margin: const EdgeInsets.only(
                    left: 25,
                    top: 15,
                  ),
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 10,
                  ),
                  width: size.width * 0.80,
                  child: Column(
                    children: [
                      customerdate("Teléfono: ", numeroTel),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05, top: 10),
                  child: const textViewCustomer(
                    texto: "Dirección:",
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white70,
                  ),
                  margin: EdgeInsets.only(
                    left: size.width * 0.03,
                    top: 10,
                  ),
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 15,
                  ),
                  //altura y ancho del contenedor dirección

                  width: size.width * 0.89,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customerdate("Calle:", calle),
                      const SizedBox(
                        height: 10,
                      ),
                      customerdate("Colonia:", colonia),
                      const SizedBox(
                        height: 10,
                      ),
                      customerdate(
                          "Municipio\ndelegación:", municipioDelegacion),
                      const SizedBox(
                        height: 10,
                      ),
                      customerdate("Estado", estado),
                      const SizedBox(
                        height: 10,
                      ),
                      customerdate("C.P.", codigoPostal),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        );
      });
}

Row customerdate(String texto, String numeroTel) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
          flex: 1,
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: textViewCustomer(
                  texto: texto, color: Constants.blueColor, size: 17),
            ),
          )),
      Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: textViewCustomer(
                  texto: numeroTel,
                  color: Colors.black.withOpacity(0.75),
                  size: 18),
            ),
          ),
        ),
      ),
    ],
  );
}

class textViewCustomer extends StatelessWidget {
  final String texto;
  final Color color;
  final double size;
  const textViewCustomer({
    super.key,
    required this.texto,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fill,
      child: Text(texto,
          style: TextStyle(
            fontSize: size,
            color: color,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}

buttonArrow(Size size, Orientation orientation) {
  return Padding(
    padding: orientation == Orientation.portrait
        ? EdgeInsets.only(right: size.width * 0.78, top: size.height * 0.02)
        : EdgeInsets.only(right: size.width * 0.88, top: 15),
    child: InkWell(
      onTap: () {
        //BOTON Regresar
        Get.back();
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Constants.orangeColor.withOpacity(0.6),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Constants.blueColor,
              size: 25,
            ),
          ),
        ),
      ),
    ),
  );
}
