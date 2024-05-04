// ignore_for_file: file_names
import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/controllers/creditController.dart';
import 'package:cobranzas/ui/screens/credit_view_page.dart';
import 'package:cobranzas/ui/screens/widgets/credit_Details.dart';
import 'package:cobranzas/ui/screens/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'package:page_transition/page_transition.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class AllCredits extends StatefulWidget {
  const AllCredits({
    super.key,
    required this.listaData,
  });
  final List<Credits> listaData;
  @override
  State<AllCredits> createState() => _AllCreditsState();
}

class _AllCreditsState extends State<AllCredits> with TickerProviderStateMixin {
  static var controllerCredit = Get.put(creditController());

  bool iconsSearch = false;
  bool _expanded = false;
  late AnimationController controller;
  late Animation<double> animation;

  late String fondo = "";
  @override
  void initState() {
    super.initState();
    fondo = widget.listaData[1].listImage[0].image;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void toggleContainer() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return KeyboardDismissOnTap(
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: LayoutBuilder(builder: (BuildContext context, sizeMax) {
            return CustomScrollView(
              slivers: <Widget>[
                KeyboardVisibilityBuilder(
                  builder: (p0, isKeyboardVisible) => SliverAppBar(
                    forceMaterialTransparency: true,
                    stretch: true,
                    floating: true,
                    forceElevated: false,
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                    expandedHeight:
                        sizeMax.maxWidth > 400 && isKeyboardVisible ? 100 : 175,
                    collapsedHeight: 60,
                    pinned: true,
                    snap: true,
                    actions: <Widget>[
                      SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          width: size.width,
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          Get.back();
                                        });
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Icon(
                                          size: 40,
                                          Icons.arrow_back,
                                          color: Constants.orangeColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          iconsSearch = !iconsSearch;
                                          toggleContainer();
                                        });
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Icon(
                                          size: 40,
                                          Icons.search,
                                          color: Constants.orangeColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                    bottom: iconsSearch == true
                        ? PreferredSize(
                            preferredSize: const Size.fromHeight(38.0),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0, bottom: 0),
                              child: AnimatedBuilder(
                                animation: animation,
                                builder: (context, Widget? child) {
                                  return Container(
                                    height: animation.value * 60,
                                    color: Colors.transparent,
                                    child: child,
                                  );
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                        ),
                                        width: size.width * 0.935,
                                        height: sizeMax.maxWidth > 300
                                            ? size.height * 0.15
                                            : size.height * 0.05,
                                        decoration: BoxDecoration(
                                          color:
                                              Colors.blueGrey.withOpacity(.35),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                //Icons.search_outlined,
                                                iconsSearch == true
                                                    ? Icons.search_sharp
                                                    : null,
                                                color: Constants.blueColor,
                                                size: 25,
                                              ),
                                            ),
                                            Expanded(
                                                child: TextFormField(
                                              onChanged: (value) {
                                                setState(() {
                                                  controllerCredit.search =
                                                      value;
                                                  printInfo(info: value);
                                                });
                                              },
                                              controller: controllerCredit
                                                  .filtrarCreditos,
                                              showCursor: true,
                                              decoration: const InputDecoration(
                                                hintText: 'Buscar Crédito ',
                                                hintStyle: TextStyle(
                                                    color: Colors.black),
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                              ),
                                            )),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  controllerCredit
                                                      .filtrarCreditos
                                                      .text = "";
                                                  controllerCredit.search = "";
                                                  controllerCredit
                                                          .filtrarCreditos
                                                          .text =
                                                      controllerCredit.search;
                                                });

                                                printInfo(
                                                    info:
                                                        "salio de codigo caja de texto");
                                              },
                                              child: Icon(
                                                iconsSearch == true
                                                    ? Icons.dangerous_rounded
                                                    : null,
                                                size: 20,
                                                color: Constants.blueColor
                                                    .withOpacity(.7),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : null,
                    /*PreferredSize(
                            preferredSize: const Size.fromHeight(48.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  margin:
                                      const EdgeInsets.only(left: 15, bottom: 5),
                                  child: Text(
                                    'Conoce los detalles del préstamo...',
                                    style: TextStyle(
                                      fontSize: sizeMax.maxWidth < 400 ? 15 : 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red[50],
                                      fontFamily: 'OpenSans',
                                    ),
                                  ),
                                ),
                              ],
                            ))*/
                    leading: null,
                    automaticallyImplyLeading: false,
                    /*leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Constants.orangeColor.withOpacity(0.5),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Constants.blueColor,
                          ),
                        ),
                      ),
                    ),*/
                    flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        expandedTitleScale: 1.3,
                        title: iconsSearch == false
                            ? Text(
                                'Todos los Créditos',
                                style: TextStyle(
                                    color: Constants.blueColor,
                                    fontWeight: FontWeight.bold),
                              )
                            : Opacity(
                                opacity: 0.0,
                                child: Text(
                                  'Todos los Créditos',
                                  style: TextStyle(
                                      color: Constants.blueColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                        background: Stack(
                          children: [
                            Positioned(
                              top: size.height * -0.02,
                              bottom: size.height * 0.02,
                              left: size.width < 800
                                  ? (size.width * -0.3)
                                  : (size.width * -0.5),
                              right: size.width * 0.1,
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationZ(-0.6),
                                child: Image.asset(
                                  fondo,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                        centerTitle: true,
                        titlePadding: iconsSearch == true
                            ? const EdgeInsets.only(bottom: 50, left: 205)
                            : const EdgeInsets.only(bottom: 5)),
                  ),
                ),
//Lista de creditos

                const SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                ),
                sliverlistCredits(),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  StreamBuilder<List<dynamic>> sliverlistCredits() {
    return StreamBuilder(
        stream: controllerCredit.getCredits(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData && snapshot.data.toString() != "[]") {
            return SliverList.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final credit = snapshot.data?[index];

                if (credit["codigo_credito"]
                        .toString()
                        .isCaseInsensitiveContains(controllerCredit.search) ||
                    credit["propietario_credito"]
                        .toString()
                        .isCaseInsensitiveContains(controllerCredit.search)) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 18, right: 18, top: 10, bottom: 10),
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
                        child: ListTile(
                          title: Container(
                            color: Colors.transparent,
                            height: 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          text: "Folio: " +
                                              (credit?["codigo_credito"])
                                                  .toString(),
                                          font: const TextStyle(),
                                        ),
                                        const SizedBox(width: 5),
                                        CustomText(
                                          text:
                                              "Monto: ${credit?["monto_solicitado"]}",
                                          font: const TextStyle(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "Cliente: ${credit?["propietario_credito"]}",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.teal),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: const SizedBox(
                            height: 40,
                            child: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                duration: const Duration(milliseconds: 780),
                                child: CreditDetails(
                                  codigoCredito: credit?["codigo_credito"],
                                  diasSemana:
                                      (credit?["dias_semana"]).toString(),
                                  fechaPrestamo: (credit?["fecha_prestamo"]),
                                  interesAsignado: credit?["interes_asignado"],
                                  montoSolicitado: credit?["monto_solicitado"],
                                  numeroPagos: credit?["numero_pagos"],
                                  plazos: credit?["plazos"],
                                  propietarioCredito:
                                      credit?["propietario_credito"],
                                  status: credit?["status"] ?? "SIN STATUS",
                                ),
                                type: PageTransitionType.bottomToTop,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            );
          } else {
            return SliverFillRemaining(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 400,
                  width: 500,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 200,
                      ),
                      SpinKitThreeBounce(
                        duration: const Duration(milliseconds: 2000),
                        color: Colors.blue.withOpacity(0.9),
                        size: 50,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "No hay datos",
                        style: TextStyle(
                          color: Colors.blue.withOpacity(0.9),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          height: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
