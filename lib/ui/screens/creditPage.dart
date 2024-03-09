// ignore_for_file: file_names

import 'package:cobranzas/controllers/creditController.dart';
import 'package:cobranzas/models/class_categoryCredits.dart';
import 'package:cobranzas/ui/screens/widgets/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/constants.dart';

class CreditPage extends StatefulWidget {
  const CreditPage({super.key});

  @override
  State<CreditPage> createState() => _CreditPageState();
}

class _CreditPageState extends State<CreditPage>
    with SingleTickerProviderStateMixin {
  static var controllerCredit = Get.put(creditController());
  late TabController tabController;
  int index = 0;
  int tabsPage = 4;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: tabsPage,
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 60,
                    width: size.width,
                    decoration: const BoxDecoration(color: Colors.transparent),
                    padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10),
                    margin: const EdgeInsets.only(
                        top: 10, left: 0, right: 0, bottom: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                            elevation: 0,
                            color: Colors.transparent,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: CustomText(
                                font: TextStyle(
                                  fontSize: 50,
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
                      top: 5,
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

                                    if ("nuevo credito"
                                        .isCaseInsensitiveContains(
                                            controllerCredit.search)) {
                                      tabController.animateTo(0);
                                    }
                                    if ("todos los creditos"
                                        .isCaseInsensitiveContains(
                                            controllerCredit.search)) {
                                      tabController.animateTo(1);
                                    }

                                    if ("pagos del dia"
                                        .isCaseInsensitiveContains(
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

                                    printInfo(info: controllerCredit.search);
                                  });
                                },
                                showCursor: true,
                                decoration: const InputDecoration(
                                  hintText: '¿Qué necesitas?',
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

                                  printInfo(
                                      info: "salio de codigo caja de texto");
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
                    height: 10.0,
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 5, right: 5),
                      child: TabBar(
                        tabAlignment: TabAlignment.start,
                        labelPadding:
                            const EdgeInsets.only(right: 20, left: 20),
                        splashFactory: InkSplash.splashFactory,
                        enableFeedback: true,
                        automaticIndicatorColorAdjustment: true,
                        indicatorWeight: 3.5,
                        dividerColor: Colors.transparent,
                        splashBorderRadius: BorderRadius.circular(15),
                        indicatorSize: TabBarIndicatorSize.tab,
                        controller: tabController,
                        indicatorColor: Colors.orange,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.blue.withOpacity(0.5),
                        isScrollable: true,
                        tabs: const <Widget>[
                          Tab(
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: CustomText(
                                  text: "Nuevo\nCrédito",
                                  font: TextStyle(
                                    fontSize: 20,
                                  )),
                            ),
                          ),
                          Tab(
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: CustomText(
                                  text: "Todos\nlos Créditos",
                                  font: TextStyle(fontSize: 20)),
                            ),
                          ),
                          Tab(
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: CustomText(
                                  text: "Pagos\ndel día",
                                  font: TextStyle(fontSize: 20)),
                            ),
                          ),
                          Tab(
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: CustomText(
                                  text: "Créditos\ncon adeudo",
                                  font: TextStyle(fontSize: 20)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      /* Positioned.fill(
                          child: Image.asset(
                        "assets/wallpaper2.png",
                        fit: BoxFit.cover,
                      )), */
                      Positioned.fill(
                          child: Image.asset(
                        "assets/wallpaper2.png",
                        fit: BoxFit.cover,
                      )),
                      Container(
                        height: size.height * 0.62,
                        width: size.width,
                        color: Colors.transparent,
                        margin: const EdgeInsets.only(
                          left: 20,
                          bottom: 10,
                          right: 20,
                          top: 10,
                        ),

                        /*  decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange[700] as Color,
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(1, 3),
                            ),
                          ],
                        ), */
                        // Colors.orangeAccent[700]),
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),

                        child: TabBarView(
                          physics: const BouncingScrollPhysics(),
                          dragStartBehavior: DragStartBehavior.down,
                          controller: tabController,

                          /*           viewportFraction: 0.68, */
                          children: <Widget>[
                            CategoryCredit(
                              index: index,
                            ),
                            CategoryCredit(
                              index: index + 1,
                            ),
                            CategoryCredit(
                              index: index + 2,
                            ),
                            CategoryCredit(
                              index: index + 3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
