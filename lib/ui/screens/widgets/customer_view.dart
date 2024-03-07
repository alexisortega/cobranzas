// ignore_for_file: camel_case_types, recursive_getters

import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cobranzas/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class customerView extends StatefulWidget {
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
  const customerView(
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
  State<customerView> createState() => _customerViewState();
}

class _customerViewState extends State<customerView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.blue[50],
          child: Stack(
            children: [
              SizedBox(
                width: size.width,
                height: size.height / 2,
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
              buttonArrow(),
              scroll(
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

scroll(
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
      initialChildSize: 0.6,
      maxChildSize: 1.0,
      minChildSize: 0.6,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
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
                            color: Colors.black),
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
                  margin: const EdgeInsets.only(
                    left: 25,
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
                const Padding(
                  padding: EdgeInsets.only(left: 27, top: 10),
                  child: textViewCustomer(
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
                  margin: const EdgeInsets.only(
                    left: 25,
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
          style: GoogleFonts.aleo(
            textStyle: TextStyle(
              fontSize: size,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}

buttonArrow() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
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
