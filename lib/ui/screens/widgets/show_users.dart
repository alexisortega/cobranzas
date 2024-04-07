import 'package:cobranzas/controllers/user_controller.dart';
import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/models/custom_text_title.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:cobranzas/ui/screens/widgets/new_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowUser extends StatefulWidget {
  const ShowUser({super.key});

  @override
  State<ShowUser> createState() => ShowUserState();
}

class ShowUserState extends State<ShowUser>
    with SingleTickerProviderStateMixin {
  static var userController = Get.put(UserController());

  late String fondoShowUser = "";

  final List<String> users = [
    'Usuario 1',
    'Usuario 2',
    'Usuario 3',
    'Usuario 4',
    'Usuario 5',
    'Usuario 6',
    'Usuario 7',
    'Usuario 8',
    'Usuario 9',
    'Usuario 10',
    'Usuario 11',
    'Usuario 12',
    'Usuario 13',
    'Usuario 14',
    'Usuario 15',
    'Usuario 16',
    'Usuario 17',
    'Usuario 18',
    'Usuario 19',
    'Usuario 20',

    // Agrega más usuarios según sea necesario
  ];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    fondoShowUser = "assets/FondoShowUsers.png";

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget cuadroBusqueda(Size size) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Container(
        margin: const EdgeInsets.all(8.5),
        height: size.height,
        width: size.width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.withOpacity(0.5),
              Colors.blueGrey.withOpacity(0.2),
            ],
          ),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: 'Buscar usuario',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
            suffixIcon: Icon(
              Icons.cancel,
              color: Colors.white.withOpacity(0.7),
            ),
            prefixIcon:
                Icon(Icons.search, color: Colors.white.withOpacity(0.7)),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(
              top: 5,
            ),
          ),
          style: const TextStyle(color: Colors.black),
          onChanged: (value) {
            // Handle search functionality
          },
        ),
      ),
    ]);
  }

  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;

    return SafeArea(
      top: false,
      child: Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                leading: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    iconSize: 40,
                    splashColor: Colors.blue,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent),

                    autofocus: true,
                    icon: Icon(
                      Icons.arrow_back,
                      color: Constants.orangeColor,
                    ), // Cambia 'Icons.menu' por el icono que desees
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                actions: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    alignment: orientation == Orientation.portrait
                        ? Alignment.centerRight
                        : isSelected == true
                            ? Alignment.center
                            : Alignment.centerRight,
                    color: Colors.transparent,
                    height: size.height,
                    width: orientation == Orientation.portrait
                        ? size.width * 0.87
                        : size.width * 0.90,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          isSelected == true
                              ? cuadroBusqueda(size)
                              : Container(),
                          IconButton(
                            icon: Icon(
                              isSelected == true
                                  ? Icons.search_off_rounded
                                  : Icons.search,
                              color: Colors.orange,
                              size: 35,
                            ),
                            onPressed: () async {
                              /*  late bool priv = false;
                              await userController
                                  .obtenerPrivilegioUsuario("Gerente", "Ver")
                                  .then((value) {
                                setState(() {
                                  priv = value;
                                });
                              }); */

                              /*      print("privilegio es: $priv"); */

                              await userController.tipoUsuario(
                                  "Ver",
                                  () => mensaje1("Es superUser"),
                                  () => mensaje1("tiene permisos"),
                                  () => mensaje1("no tiene permisos"));

                              setState(() {
                                isSelected = !isSelected;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                forceMaterialTransparency: true,
                backgroundColor: Colors.red,
                expandedHeight:
                    orientation == Orientation.portrait ? 350.0 : 200,
                floating: false,
                pinned: orientation == Orientation.portrait
                    ? isSelected == true
                        ? true
                        : false
                    : isSelected == true
                        ? true
                        : false,
                snap: false,
                scrolledUnderElevation: 40,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  title: orientation == Orientation.portrait
                      ? Container(
                          height: size.height * 0.13,
                          width: size.width * 0.54,
                          color: Colors.transparent,
                          padding: EdgeInsets.only(
                            left: size.width * 0.016,
                            top: size.height * 0.11,
                            bottom: 0.0,
                          ),
                          child: const CustomTextTitle(
                            title: 'TODOS LOS USUARIOS',
                            size: 14.0,
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                            left: size.width * 0.2,
                          ),
                          child: isSelected == false
                              ? const CustomTextTitle(
                                  title: 'TODOS LOS USUARIOS',
                                  size: 14.0,
                                )
                              : null,
                        ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      orientation == Orientation.portrait
                          ? Positioned(
                              left: size.width * 0.0,
                              right: size.width * 0.25,
                              top: size.height * 0.08,
                              bottom: size.height * 0.0,
                              child: Image.asset(
                                fondoShowUser, //imagen AppBar
                                fit: BoxFit
                                    .fitHeight, // Cubrir para que la imagen se expanda bien
                              ),
                            )
                          : Positioned(
                              left: size.width * 0.01,
                              top: size.height * -0.001,
                              right: size.width * 0.6,
                              bottom: size.height * -0.10,
                              child: Image.asset(
                                fondoShowUser, //imagen AppBar
                                fit: BoxFit
                                    .fitHeight, // Cubrir para que la imagen se expanda bien
                              ),
                            ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.0, 0.5), //(X,Y)
                            end: Alignment(0.0, 0.0),
                            colors: <Color>[Colors.black12, Colors.transparent],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /*  SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 80.0,
              forceMaterialTransparency: true,
              forceElevated: true,
              floating: true,
              pinned: true,
              snap: false,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: size.height * 0.1,
                      width: size.width * 0.95,
                      margin: const EdgeInsets.only(
                        left: 0,
                        bottom: 0,
                        right: 10,
                        top: 0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.blue.withOpacity(0.5),
                            Colors.blueGrey.withOpacity(0.2),
                          ],
                        ),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Buscar usuario',
                          hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.7)),
                          suffixIcon: Icon(
                            Icons.cancel,
                            color: Colors.white.withOpacity(0.7),
                          ),
                          prefixIcon: Icon(Icons.search,
                              color: Colors.white.withOpacity(0.7)),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                            top: 5,
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                        onChanged: (value) {
                          // Handle search functionality
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ), */
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: orientation == Orientation.portrait
                                  ? 25.0
                                  : 50),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue[300] as Color,
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: const Offset(1, 3),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                ListTile(
                                  titleAlignment: ListTileTitleAlignment.center,
                                  leading: const CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child:
                                        Icon(Icons.person, color: Colors.black),
                                  ),
                                  title: SizedBox(
                                    width: 80,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Usuario ${index + 1}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'user${index + 1}@example.com',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '(Administrador)',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Constants.blueColor),
                                      ),
                                    ],
                                  ),
                                  trailing: const Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  ),
                                  onTap: () {
                                    // Acción al seleccionar el usuario
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  childCount: users.length,
                ),
              ),
              //todo:terminacion Sliver

              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 100,
                ),
              ),
            ],
          ),
          floatingActionButton: AnimatedBuilder(
              animation: _scrollController,
              builder: (context, child) {
                return _scrollController.hasClients &&
                        _scrollController.offset > 100
                    ? FloatingActionButton(
                        heroTag: "",
                        enableFeedback: false,
                        onPressed: () {
                          _scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        backgroundColor: Constants.blueColor,
                        shape: CircleBorder(
                            eccentricity: 1,
                            side: BorderSide(
                                width: 0.5, color: Constants.orangeColor)),
                        elevation: 4.0, // Elevación del botón
                        splashColor: Constants.orangeColor,
                        child: const Icon(
                          Icons.arrow_upward_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                      )
                    : FloatingActionButton(
                        onPressed: () {
                          Get.off(() => const NewUser());
                        },
                        heroTag: "",
                        backgroundColor: Constants.blueColor,
                        shape: CircleBorder(
                            eccentricity: 1,
                            side: BorderSide(
                                width: 0.5, color: Constants.orangeColor)),
                        elevation: 4.0, // Elevación del botón
                        splashColor: Constants.orangeColor,
                        child: Icon(
                          Icons.person_add,
                          color: Constants.orangeColor,
                          size: 30,
                        ), // Color de salpicadura al presionar
                      );
              })),
    );
  }

  Future<dynamic> mensaje1(String s) async {
    return await authenticationRepository.showMessage("Aviso", s, context);
  }
}
