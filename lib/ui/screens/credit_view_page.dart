// ignore_for_file: file_names
import 'package:cobranzas/controllers/creditController.dart';
import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/ui/screens/widgets/allCredits.dart';
import 'package:cobranzas/ui/screens/widgets/custom_text.dart';
import 'package:cobranzas/ui/screens/widgets/new_credit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreditViewPage extends StatefulWidget {
  const CreditViewPage({super.key});

  @override
  State<CreditViewPage> createState() => CajaPageState();
}

class CajaPageState extends State<CreditViewPage> {
  static var controllerCredit = Get.put(creditController());

  double currentPage = 0.0;
  double indexPage = 0.0;
  final _pageController = PageController(viewportFraction: 0.75);
  final ScrollController _scrollControllerMenu = ScrollController();
  int selectedIndex = 0;

  @override
  void initState() {
    _pageController.addListener(listener);
    _pageController.addListener(scrollListenerMenu);

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pageController.removeListener(scrollListenerMenu);
    super.dispose();
  }

  void listener() {
    setState(() {
      currentPage = _pageController.page!;
      getColor();
      controllerAnimation(currentPage);
    });
  }

  void controllerAnimation(currentPage) {
    if (currentPage >= 0 && currentPage <= 0.7) {
      indexPage = 0;
    } else if (currentPage > 0.7 && currentPage <= 1.7) {
      indexPage = 1;
    } else if (currentPage > 1.7 && currentPage <= 2.7) {
      indexPage = 2;
    } else if (currentPage > 2.7 && currentPage <= 3.7) {
      indexPage = 3;
    } else if (currentPage > 3.7 && currentPage <= 4.7) {
      indexPage = 4;
    }
  }

  Color getColor() {
    late final Color color;

    if (currentPage >= 0 && currentPage <= 0.7) {
      color = listCreditsData[0].listImage[0].color;
    } else if (currentPage > 0.7 && currentPage <= 1.7) {
      color = listCreditsData[1].listImage[0].color;
    } else if (currentPage > 1.7 && currentPage <= 2.7) {
      color = listCreditsData[2].listImage[0].color;
    } else if (currentPage > 2.7 && currentPage <= 3.7) {
      color = listCreditsData[3].listImage[0].color;
    } else if (currentPage > 3.7 && currentPage <= 4.7) {
      color = listCreditsData[0].listImage[0].color;
    }

    return color;
  }

  void scrollListenerMenu() {
    final newSelectedIndex = _pageController.page!.round();
    if (selectedIndex != newSelectedIndex) {
      setState(() {
        selectedIndex = newSelectedIndex;
      });
      final double offset =
          (_scrollControllerMenu.position.maxScrollExtent * selectedIndex) /
              listCreditsCategoryAcento.length;
      _scrollControllerMenu.animateTo(
          offset + (selectedIndex * (selectedIndex * 20)),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut);
    }
  }

  void scrollPositionTitles() {
    final newSelectedIndex = _pageController.page!.round();
    if (selectedIndex != newSelectedIndex) {
      setState(() {
        selectedIndex = newSelectedIndex;
      });
      final double offset =
          (_scrollControllerMenu.position.maxScrollExtent * selectedIndex) /
              listCreditsCategoryAcento.length;
      _scrollControllerMenu.animateTo(
          offset + (selectedIndex * (selectedIndex * 20)),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut);
    }
  }

  //widgets
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/wallpaper2.png'), // Utiliza AssetImage para cargar la imagen desde tus activos
                fit: BoxFit.cover,
              ),
            ),
            height: size.height * 0.8,
            width: size.width * 1,
            child: Column(
              children: [
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

                                  if (listCreditsCategory[0]
                                          .isCaseInsensitiveContains(
                                              controllerCredit.search) ||
                                      listCreditsCategoryAcento[0]
                                          .isCaseInsensitiveContains(
                                              controllerCredit.search)) {
                                    _pageController.jumpToPage(0);
                                  }
                                  if (listCreditsCategory[1]
                                          .isCaseInsensitiveContains(
                                              controllerCredit.search) ||
                                      listCreditsCategoryAcento[1]
                                          .isCaseInsensitiveContains(
                                              controllerCredit.search)) {
                                    _pageController.jumpToPage(1);
                                  }

                                  if (listCreditsCategory[2]
                                          .isCaseInsensitiveContains(
                                              controllerCredit.search) ||
                                      listCreditsCategoryAcento[2]
                                          .isCaseInsensitiveContains(
                                              controllerCredit.search)) {
                                    _pageController.jumpToPage(2);
                                  }
                                  if (listCreditsCategory[3]
                                          .isCaseInsensitiveContains(
                                              controllerCredit.search) ||
                                      listCreditsCategoryAcento[3]
                                          .isCaseInsensitiveContains(
                                              controllerCredit.search)) {
                                    _pageController.jumpToPage(3);
                                  }
                                  if ("".isCaseInsensitiveContains(
                                      controllerCredit.search)) {
                                    _pageController.jumpToPage(0);
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

                                  _pageController.jumpToPage(0);
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
                  height: 5,
                ),
                SingleChildScrollView(
                  controller: _scrollControllerMenu,
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: size.width * 0.12,
                      right: size.width * 0.45,
                    ),
                    color: Colors.transparent,
                    height: 50,
                    child: Row(
                      children: List.generate(
                        listCreditsCategoryAcento.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(left: 5, right: 10),
                          child: GestureDetector(
                            onDoubleTap: () {},
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });

                              scrollPositionTitles();
                              switch (index) {
                                case 0:
                                  _pageController.jumpToPage(0);
                                  printInfo(info: "pagina 0");

                                  break;
                                case 1:
                                  _pageController.jumpToPage(1);
                                  printInfo(info: "pagina 1");

                                  break;
                                case 2:
                                  printInfo(info: "pagina 2");
                                  _pageController.jumpToPage(2);

                                  break;

                                case 3:
                                  _pageController.jumpToPage(3);
                                  printInfo(info: "pagina 3");

                                  break;
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              decoration: BoxDecoration(
                                color: index == indexPage
                                    ? getColor().withOpacity(0.7)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                listCreditsCategoryAcento[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: size.width > 800 ? 20 : 15,
                                    color: index == indexPage
                                        ? Colors.black
                                        : Colors.blueGrey),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final listData = listCreditsData[index];
                      final listTitles = listData.category.split(" ");

                      return GestureDetector(
                        onTap: (() {
                          switch (index) {
                            case 0:
                              Get.to(
                                  () => NewCredit(
                                        listaData: listCreditsData,
                                      ),
                                  opaque: false,
                                  fullscreenDialog: true,
                                  transition: Transition.circularReveal,
                                  duration: const Duration(milliseconds: 1000));
                              break;

                            case 1:
                              Get.to(
                                  () => AllCredits(
                                        listaData: listCreditsData,
                                      ),
                                  opaque: false,
                                  fullscreenDialog: true,
                                  transition: Transition.circularReveal,
                                  duration: const Duration(milliseconds: 1000));
                              break;
                          }
                        }),
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: index == indexPage ? 50 : 80),
                          child: Transform.translate(
                            offset: Offset(index == indexPage ? 0 : 20, 0),
                            child: LayoutBuilder(builder: (context, sizeMax) {
                              return AnimatedContainer(
                                duration: const Duration(microseconds: 2000),
                                margin: EdgeInsets.only(
                                    top: index == indexPage ? 20 : 40,
                                    bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.75),
                                  borderRadius: BorderRadius.circular(35),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.orange[700] as Color,
                                      spreadRadius: 1,
                                      blurRadius: 22,
                                      offset: const Offset(-10, 7),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 40),
                                        child: orientation ==
                                                Orientation.portrait
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Text(
                                                    listData.category,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  FittedBox(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                      listData.name,
                                                      style: const TextStyle(
                                                        fontSize: 25,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    listData.caption,
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 1,
                                                  ),
                                                  Flexible(
                                                    child: FittedBox(
                                                      fit: BoxFit.fitWidth,
                                                      child: Text(
                                                        listTitles[0],
                                                        style: const TextStyle(
                                                          color: Colors.black38,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            //Telefono en vertical se ajusta el menu
                                            : Flexible(
                                                child: Container(
                                                  color: Colors.transparent,
                                                  width: size.width * 0.35,
                                                  height: size.height,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Flexible(
                                                        flex: 1,
                                                        child: Text(
                                                          listData.category,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Flexible(
                                                        flex: 2,
                                                        child: Text(
                                                          listData.name,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      Flexible(
                                                        flex: 1,
                                                        child: Text(
                                                          listData.caption,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 1,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                    Positioned(
                                      top: sizeMax.maxHeight * 0.06,
                                      left: sizeMax.maxWidth * 0.16,
                                      right: sizeMax.maxWidth * -0.2,
                                      bottom: sizeMax.maxHeight * -0.1,
                                      child: Hero(
                                        tag: listData.name,
                                        child: Image(
                                          fit: BoxFit.contain,
                                          image: AssetImage(
                                              listData.listImage[0].image),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        decoration: BoxDecoration(
                                          color: listData.listImage[0].color
                                              .withOpacity(0.4),
                                          borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(36),
                                            topLeft: Radius.circular(36),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blueGrey
                                                  .withOpacity(0.5),
                                              blurStyle: BlurStyle.inner,
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: const Offset(3, 7),
                                            ),
                                          ],
                                        ),
                                        child: const SizedBox(
                                          height: 70,
                                          width: 90,
                                          child: Icon(
                                            Icons.add,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      );
                    },
                    itemCount: listCreditsData.length,
                  ),
                ),

                //todo:navegacion por las paginas
                /* Container(
            height: 100,
            color: Colors.transparent,
            padding: const EdgeInsets.all(20),
            child: CustomButtomBar(
              color: listcreditsPrueba[0].listImage[0].color,
            ),
          ), */
              ],
            ),
          ),
        ));
  }
}


class Imagecredits {
  Imagecredits(
    this.image,
    this.color,
  );
  final String image;
  final Color color;
}

class Credits {
  Credits(
    this.name,
    this.category,
    this.caption,
    this.punctuation,
    this.listImage,
  );
  final String name;
  final String category;
  final String caption;
  final int punctuation;
  final List<Imagecredits> listImage;
}

final listCreditsCategory = [
  'NUEVO CREDITO',
  'TODOS LOS CREDITOS',
  'CREDITOS CON ADEUDO',
  'CREDITOS DE HOY'
];
final listCreditsCategoryAcento = [
  'NUEVO CRÉDITO',
  'TODOS LOS CRÉDITOS',
  'CRÉDITOS CON ADEUDO',
  'CRÉDITOS DE HOY'
];
//todo: cambiar por el contenido de los creditos//
final listCreditsData = [
  //listcreditsPruba
  Credits(
    'NUEVO CRÉDITO',
    'CRÉDITOS',
    'Indice 1',
    4,
    [
      Imagecredits(
        'assets/tarjetasItem1.png',
        Colors.green,
      ),
    ],
  ),
  Credits(
    'TODOS LOS CRÉDITOS',
    'CRÉDITOS',
    'Indice 2',
    4,
    [
      Imagecredits(
        'assets/tarjetasItem2.png',
        Constants.blueColor,
      ),
    ],
  ),
  Credits(
    'CRÉDITOS CON ADEUDO',
    'CRÉDITOS',
    'Índice 3',
    4,
    [
      Imagecredits(
        'assets/tarjetasItem3.png',
        Constants.orangeColor,
      ),
    ],
  ),
  Credits(
    'CRÉDITOS DE HOY',
    'CRÉDITOS',
    'Índice 4',
    4,
    [
      Imagecredits(
        'assets/tarjetasItem4.png',
        Colors.red,
      ),
    ],
  ),
];
