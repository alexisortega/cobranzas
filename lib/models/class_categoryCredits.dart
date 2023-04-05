import 'package:cobranzas/controllers/creditController.dart';

import 'package:cobranzas/models/animations_transtions.dart';
import 'package:cobranzas/ui/screens/widgets/allCredits.dart';

import 'package:cobranzas/ui/screens/widgets/custom_text.dart';
import 'package:cobranzas/ui/screens/widgets/new_credit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:page_transition/page_transition.dart';

// ignore: camel_case_types
class categoryCredit extends StatefulWidget {
  final int index;

  const categoryCredit({
    super.key,
    required this.index,
  });

  @override
  State<categoryCredit> createState() => _categoryCreditState();
}

class _categoryCreditState extends State<categoryCredit> {
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
      List<String> NameCategorys = [
        "Nuevo Crédito",
        "Todos los créditos",
        "Pagos del día",
        "Créditos con adeudo",
      ];
      List<String> Imags = [
        "assets/nuevoCredito.jpg",
        "assets/todosLosCreditos.jpg",
        "assets/fondoListCreditos.jpg",
        "assets/tarjetaCredito.jpg",
      ];
    }

    @override
    void dispose() {
      super.dispose();
    }

    return Container(
      decoration: const BoxDecoration(color: Colors.transparent),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
              const SizedBox(
                height: 40,
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
  return Padding(
    padding: const EdgeInsets.only(
      left: 10,
      right: 10,
      bottom: 10,
      top: 10,
    ),
    child: shakeTransition(
      axis: Axis.vertical,
      duration: const Duration(milliseconds: 1300),
      offset: 200,
      child: Container(
        height: (size.height / 2) - 100,
        width: (size.width / 2),
        decoration: BoxDecoration(
            //contorno blanco
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ]),
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: (size.height / 4) - 10,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      image: DecorationImage(
                        image: AssetImage(imgPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
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
                          fit: BoxFit.fitWidth,
                          child: CustomText(
                              text: nameCategory,
                              font: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Container(
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
                                Navigator.push(
                                    context,
                                    PageTransition(
                                      duration:
                                          const Duration(milliseconds: 780),
                                      // ignore: prefer_const_constructors
                                      child: AllCredits(),
                                      type: PageTransitionType.bottomToTop,
                                    ));
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
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
