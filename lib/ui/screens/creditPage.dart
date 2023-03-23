import 'package:cobranzas/controllers/creditController.dart';
import 'package:cobranzas/models/class_categoryCredits.dart';
import 'package:cobranzas/ui/screens/widgets/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class creditPage extends StatefulWidget {
  const creditPage({super.key});

  @override
  State<creditPage> createState() => _creditPageState();
}

class _creditPageState extends State<creditPage>
    with SingleTickerProviderStateMixin {
  static var controllerCredit = Get.put(creditController());
  late TabController tabController;
  int index = 0;
  int TabsPage = 4;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: TabsPage,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 60,
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent),
              padding: const EdgeInsets.only(
                bottom: 10,
                top: 15,
              ),
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: CustomText(
                          font: GoogleFonts.aldrich(
                            fontSize: 30,
                            color: Constants.blueColor,
                            fontWeight: FontWeight.bold,
                          ),
                          text: '¿Necesitas un crédito?',
                        ),
                      )),
                ],
              ),
            ),
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    width: size.width * 0.95,
                    decoration: BoxDecoration(
                      color: Constants.blueColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Icon(
                            //Icons.search_outlined,
                            Icons.search_sharp,
                            color: Constants.blueColor,
                            size: 30,
                          ),
                        ),
                        Expanded(
                            child: TextFormField(
                          controller: controllerCredit.filterCategory,
                          onChanged: (value) {
                            setState(() {
                              controllerCredit.search = value;

                              if ("nuevo credito".isCaseInsensitiveContains(
                                  controllerCredit.search)) {
                                tabController.animateTo(0);
                              }
                              if ("todos los creditos"
                                  .isCaseInsensitiveContains(
                                      controllerCredit.search)) {
                                tabController.animateTo(1);
                              }

                              if ("pagos del dia".isCaseInsensitiveContains(
                                  controllerCredit.search)) {
                                tabController.animateTo(2);
                              }
                              if ("creditos con adeudo"
                                  .isCaseInsensitiveContains(
                                      controllerCredit.search)) {
                                tabController.animateTo(3);
                              }
                              if ("".isCaseInsensitiveContains(
                                  controllerCredit.search)) {
                                tabController.animateTo(0);
                              }

                              print(controllerCredit.search);
                            });
                          },
                          showCursor: true,
                          decoration: const InputDecoration(
                            hintText: 'Buscar categoría',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        )),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              controllerCredit.filterCategory.text = "";
                              controllerCredit.search = "";
                              controllerCredit.filterCategory.text =
                                  controllerCredit.search;
                              tabController.animateTo(0);
                            });

                            print("salio de codigo caja de texto");
                          },
                          child: Icon(
                            Icons.dangerous_rounded,
                            size: 25,
                            color: Constants.blueColor.withOpacity(.7),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                controller: tabController,
                indicatorColor: Colors.orange,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.blue.withOpacity(0.5),
                isScrollable: true,
                tabs: <Widget>[
                  Tab(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: CustomText(
                          text: "Nuevo\nCrédito",
                          font: GoogleFonts.aldrich(
                            fontSize: 20,
                          )),
                    ),
                  ),
                  Tab(
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: CustomText(
                          text: "Todos\nlos Créditos",
                          font: GoogleFonts.aldrich(fontSize: 20)),
                    ),
                  ),
                  Tab(
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: CustomText(
                          text: "Pagos\ndel día",
                          font: GoogleFonts.aldrich(fontSize: 20)),
                    ),
                  ),
                  Tab(
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: CustomText(
                          text: "Créditos\ncon adeudo",
                          font: GoogleFonts.aldrich(fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.orangeAccent[700]),
                padding: const EdgeInsets.only(top: 10),
                height: size.height / 1.93,
                width: size.width / 1.05,
                child: TabBarView(
                  dragStartBehavior: DragStartBehavior.down,
                  controller: tabController,
                  children: <Widget>[
                    categoryCredit(
                      index: index,
                    ),
                    categoryCredit(
                      index: index + 1,
                    ),
                    categoryCredit(
                      index: index + 2,
                    ),
                    categoryCredit(
                      index: index + 3,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      /*  bottomNavigationBar: Material(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.yellow,
          ),
          height: 60.0,
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 5.0),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.red,
                        style: BorderStyle.solid,
                        width: 1.0),
                  ),
                ),
                child: const Text("filters"),
              ),
              const Icon(Icons.search),
              const Icon(Icons.more),
              Container(
                height: 45.0,
                width: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.red,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[
                    Text("12"),
                    Icon(Icons.monetization_on),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),*/
    );
  }
}
