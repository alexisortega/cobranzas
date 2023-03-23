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
  final urlFoto;
  final codigo_cliente;
  final nombre;
  final apellido_p;
  final apellido_m;
  final genero;
  final curp;
  final calle;
  final colonia;
  final municipio_delegacion;
  final estado;
  final codigo_postal;
  final numero_tel;
  final fecha_nacimiento;
  const customerView(
      {super.key,
      required this.cont,
      required this.datos,
      required this.codigo_cliente,
      required this.nombre,
      required this.apellido_p,
      required this.apellido_m,
      required this.genero,
      required this.curp,
      required this.calle,
      required this.colonia,
      required this.municipio_delegacion,
      required this.estado,
      required this.codigo_postal,
      required this.numero_tel,
      required this.fecha_nacimiento,
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
                        imageUrl: ("${widget.urlFoto}"),
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
                  widget.codigo_cliente,
                  widget.nombre,
                  widget.apellido_p,
                  widget.apellido_m,
                  widget.genero,
                  widget.curp,
                  widget.calle,
                  widget.colonia,
                  widget.municipio_delegacion,
                  widget.estado,
                  widget.codigo_postal.toString(),
                  widget.numero_tel.toString(),
                  widget.fecha_nacimiento.toString(),
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
    String codigo_cliente,
    String nombre,
    String apellido_p,
    String apellido_m,
    String genero,
    String curp,
    String calle,
    String colonia,
    String municipio_delegacion,
    String estado,
    String codigo_postal,
    String numero_tel,
    String fecha_nacimiento,
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
                                  texto: "ID:$codigo_cliente",
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
                      Customerdate("Nombre:", nombre),
                      const SizedBox(
                        height: 5,
                      ),
                      Customerdate("Apellido Paterno:", apellido_p),
                      const SizedBox(
                        height: 5,
                      ),
                      Customerdate("Apellido Materno:", apellido_m),
                      const SizedBox(
                        height: 5,
                      ),
                      Customerdate("Genero:", genero),
                      const SizedBox(
                        height: 5,
                      ),
                      Customerdate("Curp", curp),
                      const SizedBox(
                        height: 5,
                      ),
                      Customerdate("Fecha de\nnacimiento:", fecha_nacimiento),
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
                      Customerdate("Teléfono: ", numero_tel),
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
                      Customerdate("Calle:", calle),
                      const SizedBox(
                        height: 10,
                      ),
                      Customerdate("Colonia:", colonia),
                      const SizedBox(
                        height: 10,
                      ),
                      Customerdate(
                          "Municipio\ndelegación:", municipio_delegacion),
                      const SizedBox(
                        height: 10,
                      ),
                      Customerdate("Estado", estado),
                      const SizedBox(
                        height: 10,
                      ),
                      Customerdate("C.P.", codigo_postal),
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

Row Customerdate(String texto, String numero_tel) {
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
                  texto: "${texto}", color: Constants.blueColor, size: 17),
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
                  texto: numero_tel,
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
