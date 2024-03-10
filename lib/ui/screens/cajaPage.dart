// ignore_for_file: file_names
import 'package:cobranzas/models/constants.dart';
import 'package:flutter/material.dart';

class CajaPage extends StatefulWidget {
  const CajaPage({super.key});

  @override
  State<CajaPage> createState() => CajaPageState();
}

class CajaPageState extends State<CajaPage> {
  final _pageController = PageController(viewportFraction: 0.75);

  //widgets
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
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
                const CustomAppBar(),
                const SizedBox(
                  height: 1,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    color: Colors.transparent,
                    height: 50,
                    child: Row(
                      children: List.generate(
                        listCategoryPrueba.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(left: 5, right: 10),
                          child: Text(
                            listCategoryPrueba[index],
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Constants.blueColor),
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
                      final dataListShoes = listShoesPrueba[index];
                      final listTile = dataListShoes.category.split(" ");

                      return Padding(
                        padding: const EdgeInsets.only(right: 80.0),
                        child: Transform.translate(
                          offset: const Offset(40, 0),
                          child: LayoutBuilder(builder: (context, sizeMax) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(35),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange[300] as Color,
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          dataListShoes.category,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          dataListShoes.name,
                                          style: const TextStyle(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          dataListShoes.price,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            listTile[0],
                                            style: const TextStyle(
                                              color: Colors.black38,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: sizeMax.maxHeight * 0.06,
                                    left: sizeMax.maxWidth * 0.16,
                                    right: sizeMax.maxWidth * -0.2,
                                    bottom: sizeMax.maxHeight * -0.1,
                                    child: Image(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                          dataListShoes.listImage[0].image),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.4),
                                        borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(24),
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
                                      child: InkWell(
                                        onTap: () {},
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
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      );
                    },
                    itemCount: listShoesPrueba.length,
                  ),
                ),

                //todo:navegacion por las paginas
                /* Container(
              height: 100,
              color: Colors.transparent,
              padding: const EdgeInsets.all(20),
              child: CustomButtomBar(
                color: listShoesPrueba[0].listImage[0].color,
              ),
            ), */
              ],
            ),
          ),
        ));
  }
}

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => CustomAppBarState();
}

class CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight + 5,
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/icono_app.png"),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.credit_card),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

class CustomButtomBar extends StatefulWidget {
  const CustomButtomBar({
    required this.color,
    super.key,
  });

  final Color color;

  @override
  State<CustomButtomBar> createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomButtomBar> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 2000,
      ),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.house,
                size: 36,
              ),
            ),
            Container(
              height: double.infinity,
              width: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color,
                  ),
                  child: Center(
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: widget.color),
                          child: Center(
                            child: Container(
                              height: 5,
                              width: 5,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person_outline_outlined,
                size: 36,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomButtom extends StatefulWidget {
  const CustomButtom({
    super.key,
    this.onTap,
    this.color,
    this.borderRadius,
    required this.child,
    this.height = 50,
    this.width = 50,
    this.margin,
    this.padding,
  });
  final BorderRadiusGeometry? borderRadius;

  final EdgeInsetsGeometry? margin;

  final EdgeInsetsGeometry? padding;

  final Color? color;

  final VoidCallback? onTap;

  final double height;

  final double width;

  final Widget child;

  @override
  State<CustomButtom> createState() => CustomButtomState();
}

class CustomButtomState extends State<CustomButtom> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.color ?? Colors.white,
      borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          alignment: Alignment.center,
          margin: widget.margin,
          padding: widget.margin,
          width: widget.width,
          height: widget.height,
        ),
      ),
    );
  }
}

class ShakeTransition2 extends StatefulWidget {
  const ShakeTransition2({
    super.key,
    this.duration = const Duration(milliseconds: 700),
    required this.child,
    this.offset = 140,
    this.axis = Axis.horizontal,
    this.left = true,
  });

  final Widget child;
  final Duration duration;
  final double offset;
  final Axis axis;
  final bool left;

  @override
  State<ShakeTransition2> createState() => ShakeTransition2State();
}

class ShakeTransition2State extends State<ShakeTransition2> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      builder: (context, value, Widget? child) {
        return Transform.translate(
          offset: widget.left
              ? Offset((-value * widget.offset), (value * widget.offset))
              : Offset((value * widget.offset), (-value * -widget.offset)),
          child: child,
        );
      },
      tween: Tween(begin: 1.0, end: 0.0),
      duration: widget.duration,
      curve: Curves.easeInOut,
      child: widget.child,
    );
  }
}

class ImageShoes {
  ImageShoes(
    this.image,
    this.color,
  );
  final String image;
  final Color color;
}

class Shoes {
  Shoes(
    this.name,
    this.category,
    this.price,
    this.punctuation,
    this.listImage,
  );
  final String name;
  final String category;
  final String price;
  final int punctuation;
  final List<ImageShoes> listImage;
}

final listCategoryPrueba = [
  'Nuevos Creditos',
  'Todos los creditos',
  'Pagos',
  'adeudos'
];
//todo: cambiar por el contenido de los creditos//
final listShoesPrueba = [
  Shoes(
    'NUEVO CRÉDITO',
    'CRÉDITOS',
    'Indice 1',
    4,
    [
      ImageShoes(
        'assets/tarjetasItem1.png',
        Colors.green,
      ),
    ],
  ),
  Shoes(
    'TODOS LOS CRÉDITOS',
    'CRÉDITOS',
    'Indice 2',
    4,
    [
      ImageShoes(
        'assets/tarjetasItem2.png',
        Constants.blueColor,
      ),
    ],
  ),
  Shoes(
    'CRÉDITOS CON ADEUDO',
    'Créditos',
    'Índice 3',
    4,
    [
      ImageShoes(
        'assets/tarjetasItem3.png',
        Constants.orangeColor,
      ),
    ],
  ),
];
