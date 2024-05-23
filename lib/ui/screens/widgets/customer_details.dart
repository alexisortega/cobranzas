/* // ignore_for_file: camel_case_types, recursive_getters

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
 */

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cobranzas/models/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CustomerDetails extends StatefulWidget {
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

  const CustomerDetails({
    super.key,
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
    required this.urlFoto,
  });

  @override
  State<CustomerDetails> createState() => CustomerDetailsState();
}

class CustomerDetailsState extends State<CustomerDetails> {
  ScrollController scrollController = ScrollController();
  bool isAppBarExpanded = true;
  double scrollPosition = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            /*  SliverAppBar(
              floating: true,
              snap: true,
              pinned: true,
              elevation: 0.0,
              forceMaterialTransparency: false,
              forceElevated: false,
              expandedHeight:
                  orientation == Orientation.portrait ? 300.0 : 200.0,
              backgroundColor: Colors.orange,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "${widget.nombre} ${widget.apellidoP} ${widget.apellidoM}",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Times New Roman',
                  ),
                ),
                centerTitle: false,
                background: Hero(
                  tag: widget.urlFoto,
                  child: Stack(children: [
                    Positioned(
                      top: size.height * 0.045,
                      left: size.width * 0.28,
                      height: 200,
                      width: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: widget.urlFoto,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color: Constants.orangeColor,
                  size: 35,
                ),
                onPressed: () {
                  // Navegar hacia atrás al homepage
                  Get.back();
                },
              ),
            ), */

            SliverPersistentHeader(
              pinned: true,
              delegate: _MyProfilePicture(
                  nombre: widget.nombre,
                  apellidoM: widget.apellidoM,
                  apellidoP: widget.apellidoP,
                  imageUrl: widget.urlFoto),
            ),
            /*   SliverAppBar(
              floating: true,
              snap: true,
              pinned: true,
              elevation: 0.0,
              expandedHeight:
                  orientation == Orientation.portrait ? 300.0 : 200.0,
              backgroundColor: Colors.orange,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double appBarHeight = constraints.maxHeight;
                  double t = (appBarHeight - kToolbarHeight) /
                      (300.0 - kToolbarHeight);
                  double scaleFactor =
                      0.3 + (t * 1.4); // scale factor range between 1.0 to 1.5
                  double topPosition =
                      80.0 * t; // top position range between 50.0 to 0.0

                  return Stack(
                    children: [
                      Positioned(
                        top: topPosition,
                        left: size.width * 0.4,
                        child: Transform.scale(
                          scale: scaleFactor,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: widget.urlFoto,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              width: 100.0,
                              height: 100.0,
                            ),
                          ),
                        ),
                      ),
                      FlexibleSpaceBar(
                        title: Text(
                          "${widget.nombre} ${widget.apellidoP} ${widget.apellidoM}",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Times New Roman',
                          ),
                        ),
                        centerTitle: false,
                      ),
                    ],
                  );
                },
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.black87,
                  size: 35,
                ),
                onPressed: () {
                  // Navegar hacia atrás al homepage
                  Get.back();
                },
              ),
            ), */
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _buildInfoSection(),
                  _buildContactSection(),
                  _buildAddressSection(),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: size.height * 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue[300] as Color,
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        elevation: 20.0,
        color: Colors.white54,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Datos del Cliente",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blueColor),
              ),
              const SizedBox(height: 10),
              _buildInfoRow("ID:", widget.codigoCliente),
              _buildInfoRow("Nombre:", widget.nombre),
              _buildInfoRow("Apellido Paterno:", widget.apellidoP),
              _buildInfoRow("Apellido Materno:", widget.apellidoM),
              _buildInfoRow("Género:", widget.genero),
              _buildInfoRow("CURP:", widget.curp),
              _buildInfoRow("Fecha de Nacimiento:", widget.fechaNacimiento),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue[300] as Color,
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        elevation: 20.0,
        color: Colors.white54,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Contacto",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blueColor),
              ),
              const SizedBox(height: 10),
              _buildInfoRow("Teléfono:", widget.numeroTel.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressSection() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue[300] as Color,
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        elevation: 20.0,
        color: Colors.white54,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Dirección",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blueColor),
              ),
              const SizedBox(height: 10),
              _buildInfoRow("Calle:", widget.calle),
              _buildInfoRow("Colonia:", widget.colonia),
              _buildInfoRow(
                  "Municipio/Delegación:", widget.municipioDelegacion),
              _buildInfoRow("Estado:", widget.estado),
              _buildInfoRow("C.P.:", widget.codigoPostal.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontSize: 17,
                color: Colors.teal,
                fontWeight: FontWeight.w800,
                fontFamily: 'Times New Roman'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(0.68),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class AppColors {
  static const Color blueColor = Color.fromARGB(255, 6, 166, 199);
  static const Color orangeColor = Color(0xFFF57C00);
}

class TextViewCustomer extends StatefulWidget {
  final String texto;
  final Color color;
  final double size;
  const TextViewCustomer({
    super.key,
    required this.texto,
    required this.color,
    required this.size,
  });

  @override
  State<TextViewCustomer> createState() => TextViewCustomerState();
}

class TextViewCustomerState extends State<TextViewCustomer> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fill,
      child: Text(widget.texto,
          style: TextStyle(
            fontSize: widget.size,
            color: widget.color,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}

const _maxHeaderExtent = 350.0;
const _minHeaderExtent = 100.0;
const double _maxImageSize = 250;
const double _minImageSize = 60;

const double _maxTitleSize = 18;
const double _minTitleSize = 13;

class _MyProfilePicture extends SliverPersistentHeaderDelegate {
  final String nombre;
  final String apellidoP;
  final String apellidoM;
  final String imageUrl;

  _MyProfilePicture({
    required this.nombre,
    required this.apellidoM,
    required this.apellidoP,
    required this.imageUrl,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final percent = (shrinkOffset / (_maxHeaderExtent));
    final currentImageSize =
        (_maxImageSize * (1 - percent)).clamp(_minImageSize, _maxImageSize);

    final titleSizev =
        (_maxTitleSize * (1 - percent)).clamp(_minTitleSize, _maxTitleSize);
    final titleSizeH =
        (_maxTitleSize * (1 - percent)).clamp(_maxTitleSize, _maxTitleSize);

    print("porcentaje $percent");
    print(currentImageSize);
    var orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;

    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: orientation == Orientation.portrait
                ? const Alignment(0.0, 0.0)
                : const Alignment(0.005, 0.7), //(X,Y)
            end: const Alignment(0.00, 0.5),
            colors: <Color>[Colors.greenAccent[100] as Color, Colors.white],
          ),
        ),
        child: Stack(
          children: [
            buttonArrow(size, orientation),
            Positioned(
                top: orientation == Orientation.portrait
                    ? (size.height * 0.05)
                    : (size.height * 0.08),
                left: orientation == Orientation.portrait
                    ? ((size.width * 0.18) + (60 * percent))
                    : ((size.width * 0.15) + (80 * percent)),
                height: _maxHeaderExtent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      softWrap: true,
                      textAlign: TextAlign.start,
                      "$nombre $apellidoP",
                      style: TextStyle(
                          fontSize: orientation == Orientation.portrait
                              ? titleSizev
                              : titleSizeH,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Times New Roman',
                          letterSpacing: -1.0),
                    ),
                  ],
                )),
            Positioned(
              height: currentImageSize,
              width: currentImageSize,
              bottom: orientation == Orientation.portrait
                  ? size.height * 0.020
                  : size.height * 0.050,
              left: orientation == Orientation.portrait
                  ? ((size.width * 0.23) * (1 - percent))
                      .clamp((size.width * 0.15), (size.width * 0.23))
                  : ((size.width * 0.32) * (1 - percent))
                      .clamp((size.width * 0.15), (size.width * 0.32)),
              child: Hero(
                tag: imageUrl,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Constants.blueColor,
                      width: 3.0,
                    ),
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: imageUrl,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),

            /*  Positioned(
              bottom: 20.0,
              left: 35.0,
              height: currentImageSize,
              child: Image.network(imageUrl),
            ) */
          ],
        ));
  }

  @override
  double get maxExtent => _maxHeaderExtent;

  @override
  double get minExtent => _minHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

buttonArrow(Size size, Orientation orientation) {
  return Stack(children: [
    Positioned(
      height: 45,
      width: 45,
      left: 20,
      top: 30,
      child: InkWell(
        onTap: () {
          //BOTON Regresar
          Get.back();
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.transparent,
              ),
              child: Icon(
                Icons.arrow_back,
                color: Constants.orangeColor,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    ),
  ]);
}
