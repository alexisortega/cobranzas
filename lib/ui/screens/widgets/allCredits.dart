// ignore: file_names
import 'package:cobranzas/constants.dart';

import 'package:cobranzas/controllers/creditController.dart';
import 'package:cobranzas/ui/screens/widgets/credit_Details.dart';
import 'package:cobranzas/ui/screens/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class AllCredits extends StatefulWidget {
  const AllCredits({super.key});

  @override
  State<AllCredits> createState() => _AllCreditsState();
}

class _AllCreditsState extends State<AllCredits> with TickerProviderStateMixin {
  static var controllerCredit = Get.put(creditController());
  String searchCredits = "";

  bool iconsSearch = false;
  int cont = 0;
  bool _expanded = false;

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutCubic,
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(builder: (BuildContext context, sizeMax) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                stretch: true,
                floating: true,
                forceElevated: false,
                elevation: 3.0,
                backgroundColor: Colors.white,
                expandedHeight: 165,
                pinned: false,
                automaticallyImplyLeading: false,
                systemOverlayStyle: SystemUiOverlayStyle.light,
                snap: true,
                stretchTriggerOffset: 40,
                shadowColor: Colors.orange,
                actions: [
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
                        child: const Icon(
                          size: 30,
                          Icons.search,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  )
                ],
                bottom: iconsSearch == true
                    ? PreferredSize(
                        preferredSize: const Size.fromHeight(48.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 15),
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
                                top: 20,
                              ),
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
                                          Constants.blueColor.withOpacity(.1),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
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
                                              searchCredits = value;
                                              print(value);
                                            });
                                          },
                                          controller:
                                              controllerCredit.filtrarCreditos,
                                          showCursor: true,
                                          decoration: const InputDecoration(
                                            hintText: 'Buscar Crédito ',
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                          ),
                                        )),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              controllerCredit
                                                  .filtrarCreditos.text = "";
                                              searchCredits = "";
                                              controllerCredit.filtrarCreditos
                                                  .text = searchCredits;
                                            });

                                            print(
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
                    : PreferredSize(
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
                                  color: Constants.orangeColor.withOpacity(0.7),
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            ),
                          ],
                        )),
                leading: GestureDetector(
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
                ),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  expandedTitleScale: 2,
                  title: Stack(alignment: Alignment.center, children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        font: GoogleFonts.aldrich(
                          color: Constants.blueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: sizeMax.maxWidth < 400 ? 13 : 15,
                        ),
                        text: 'Todos los créditos',
                      ),
                    ),
                  ]),
                  centerTitle: true,
                  titlePadding: iconsSearch == true
                      ? const EdgeInsets.only(bottom: 65)
                      : const EdgeInsets.only(bottom: 35),
                ),
              ),
              StreamBuilder(
                stream: controllerCredit.getCredits(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.hasData && snapshot.data.toString() != "[]") {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final credit = snapshot.data?[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    text: "Folio: " +
                                                        (credit?[
                                                                "codigo_credito"])
                                                            .toString(),
                                                    font:
                                                        GoogleFonts.aldrich()),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                CustomText(
                                                    text:
                                                        "Monto: ${credit?["monto_solicitado"]}",
                                                    font: GoogleFonts.aldrich(
                                                        textStyle:
                                                            const TextStyle()))
                                              ],
                                            ),
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    "Cliente: ${credit?["propietario_credito"]}",
                                                    style: const TextStyle(
                                                        color: Colors.teal),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ))
                                    ]),
                              ),
                              trailing: Container(
                                  child: const SizedBox(
                                height: 40,
                                child: Icon(Icons.arrow_forward_ios_outlined),
                              )),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                      duration:
                                          const Duration(milliseconds: 780),
                                      child: creditDetails(
                                        codigo_credito:
                                            credit?["codigo_credito"],
                                        dias_semana:
                                            (credit?["dias_semana"]).toString(),
                                        fecha_prestamo:
                                            (credit?["fecha_prestamo"]),
                                        interes_asignado:
                                            credit?["interes_asignado"],
                                        monto_solicitado:
                                            credit?["monto_solicitado"],
                                        numero_pagos: credit?["numero_pagos"],
                                        plazos: credit?["plazos"],
                                        propietario_credito:
                                            credit?["propietario_credito"],
                                        status: 'activo',
                                      ),
                                      type: PageTransitionType.bottomToTop,
                                    ));
                              },
                            ),
                          );
                        },
                        childCount: snapshot.data?.length,
                      ),
                    );
                  } else {
                    return SliverFillRemaining(
                        child: Container(
                            width: size.width,
                            height: size.height,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: size.height / 4,
                                ),
                                SpinKitThreeBounce(
                                  duration: const Duration(milliseconds: 2000),
                                  color: Colors.blue.withOpacity(0.7),
                                  size: 50,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "No hay datos",
                                  style: GoogleFonts.aldrich(
                                    textStyle: TextStyle(
                                      color: Colors.blue.withOpacity(0.8),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      height: 2,
                                    ),
                                  ),
                                ),
                              ],
                            )));
                  }
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
