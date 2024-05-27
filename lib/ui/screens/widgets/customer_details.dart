import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/ui/screens/widgets/edit_clients.dart';
import 'package:cobranzas/ui/screens/widgets/full_screen_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
/*     var orientation = MediaQuery.of(context).orientation; */
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(widget.fechaNacimiento);

            String formatFechaN = widget.fechaNacimiento;
            print(formatFechaN);

            DateFormat format = DateFormat("dd/MM/yyyy");
            DateTime convertFechaN = format.parse(formatFechaN);

            print(convertFechaN);

            Get.to(() => EditClients(
                  idClient: widget.codigoCliente,
                  nombre: widget.nombre,
                  apellidoP: widget.apellidoP,
                  apellidoM: widget.apellidoM,
                  genero: widget.genero,
                  curp: widget.curp,
                  calle: widget.calle,
                  colonia: widget.colonia,
                  municioDelegacion: widget.municipioDelegacion,
                  estado: widget.estado,
                  codigoPostal: widget.codigoPostal,
                  fechaNacimiento: convertFechaN,
                  tel: widget.numeroTel,
                  urlFoto: widget.urlFoto,
                ));
          },
          backgroundColor: Colors.blue, // Color primario azul
          tooltip: 'Editar',
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.lightBlue[100] as Color, width: 2),
          ),
          elevation: 10,
          splashColor: Colors.orange.withOpacity(0.5),
          child: Icon(Icons.edit,
              color: Colors.orange[400]), // Color de splash más claro
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        backgroundColor: Colors.white,
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _MyProfilePicture(
                  nombre: widget.nombre,
                  apellidoM: widget.apellidoM,
                  apellidoP: widget.apellidoP,
                  imageUrl: widget.urlFoto),
            ),
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
              _buildInfoRow(
                  "Fecha de Nacimiento:", widget.fechaNacimiento.toString()),
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

const double _maxTitleSize = 14;
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
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => FullScreenImage(url: imageUrl));
                      },
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
