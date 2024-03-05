// ignore_for_file: file_names

import 'package:cobranzas/controllers/creditController.dart';
import 'package:cobranzas/models/animations_transtions.dart';
import 'package:cobranzas/ui/screens/widgets/allCredits.dart';
import 'package:cobranzas/ui/screens/widgets/custom_text.dart';
import 'package:cobranzas/ui/screens/widgets/new_credit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class CategoryCredit extends StatefulWidget {
  final int index;

  const CategoryCredit({
    super.key,
    required this.index,
  });

  @override
  State<CategoryCredit> createState() => CategoryCreditState();
}

class CategoryCreditState extends State<CategoryCredit> {
  static var controllerCredits = Get.put(creditController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> Imags = [
      "assets/nuevoCredito.jpg",
      "assets/todosLosCreditos.jpg",
      "assets/fondoListCreditos.jpg",
      "assets/tarjetaCredito.jpg",
    ];

    List<String> NameCategorys = [
      "Nuevo Crédito",
      "Todos los créditos",
      "Pagos del día",
      "Créditos con adeudo",
    ];

    @override
    void initState() {
      super.initState();
    }

    @override
    void dispose() {
      super.dispose();
    }

    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
      color: Colors.transparent,
      child: shakeTransition(
        axis: Axis.vertical,
        offset: 140,
        duration: const Duration(milliseconds: 1500),
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                getcategory(
                  Imags[widget.index],
                  NameCategorys[widget.index],
                  size,
                  widget.index,
                  context,
                ),
              ],
            );
          },
          itemCount: 1,
        ),
      ),
    );
  }
}

Widget getcategory(
  String imgPath,
  String nameCategory,
  Size size,
  int index,
  BuildContext context,
) {
  final List<Color> colors = [
    Colors.orange[200] as Color,
    Colors.orangeAccent,
    Colors.deepOrange[300] as Color, // Rosa
    Colors.orange[500] as Color, // Verde
    // Púrpura intenso
  ];

  Color colorMenu = colors[index % colors.length];

  return LayoutBuilder(
    builder: (context, MaxSize) => Container(
      height: MaxSize.maxHeight > 1000 ? size.height * 0.45 : size.height * 0.5,
      width: MaxSize.maxWidth > 1000 ? size.width * 0.55 : size.width * 0.5,
      decoration: BoxDecoration(
          //contorno blanco
          color: colorMenu.withOpacity(0.7),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.8),
              spreadRadius: 7,
              blurRadius: 17,
              offset: const Offset(3, -5),
            ),
          ]),
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              flex: 2,
              child: Stack(
                children: [
                  Container(
                      padding: const EdgeInsets.all(7),
                      height: (size.height / 4) - 10,
                      width: size.width,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(70),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0)),
                        child: Image.asset(
                          imgPath,
                          fit: BoxFit.cover,
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Flexible(
              fit: FlexFit.loose,
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.only(top: 5),
                height: size.height,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: CustomText(
                            text: nameCategory,
                            font: const TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        height: 50,
                        width: 90,
                        child: ElevatedButton(
                          onPressed: () async {
                            switch (index) {
                              case 0:
                                Navigator.push(
                                    context,
                                    PageTransition(
                                      duration:
                                          const Duration(milliseconds: 780),
                                      child: const NewCredit(),
                                      type: PageTransitionType.bottomToTop,
                                    ));

                                break;

                              case 1:
                                Get.to(
                                  () => const AllCredits(),
                                  duration: const Duration(milliseconds: 1000),
                                  fullscreenDialog: GetPlatform.isMobile,
                                  opaque: false,
                                  popGesture: true,
                                  transition: Transition.downToUp,
                                );

                                break;
                              case 2:
                                break;
                              case 3:
                                break;
                            }
                          },
                          child: const Icon(
                            Icons.arrow_forward,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
