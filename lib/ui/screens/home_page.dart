// ignore_for_file: unnecessary_this, import_of_legacy_library_into_null_safe, unrelated_type_equality_checks, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'package:cobranzas/ui/root_page.dart';
//import 'package:cobranzas/ui/screens/widgets/credit_simulation.dart';
import 'package:cobranzas/ui/screens/widgets/custom_text.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/controllers/clients_Controller.dart';
import 'package:cobranzas/ui/screens/widgets/customer_details.dart';
import 'package:cobranzas/ui/screens/widgets/new_customers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  static var controllerClientes = Get.put(clientsController());

  final selectedIndex = 0;

  bool statusBottomDelete = false;
  var clients = Future(() => []);

  var search = "";
  List<Object> customerData = [];

  bool isloading = false;

  @override
  void initState() {
    clients = controllerClientes.showClientes();
    super.initState();
  }

  static final customCacheManager = CacheManager(
    Config(
      "CustomCacheKey",
      stalePeriod: const Duration(days: 10),
      maxNrOfCacheObjects: 200,
    ),
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //var orientation = MediaQuery.of(context).orientation;

    List<String> ClientesTypes = [
      'Nuevo Cliente',
      'Actualizar',
      'Eliminar',
    ];

    List<Widget> ClientsTypesUpdate = [
      Text(ClientesTypes[0],
          style: TextStyle(
              color: Colors.black.withOpacity(.9),
              fontWeight: FontWeight.bold,
              fontSize: 15)),
      Row(
        children: [
          Text("Actualizando",
              style: TextStyle(
                  color: Colors.lightBlue[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 15)),
          const SizedBox(
            width: 10,
          ),
          Container(
            color: Colors.transparent,
            child: const SpinKitThreeBounce(
              color: Colors.orange,
              size: 15,
            ),
          ),
        ],
      ),
      Text(
        ClientesTypes[2],
        style: TextStyle(
            color: Colors.black.withOpacity(.9),
            fontWeight: FontWeight.bold,
            fontSize: 15),
      )
    ];

    List<Icon> listIcon = [
      Icon(
        Icons.person_add_alt_rounded,
        color: Colors.orange.withOpacity(.9),
      ),
      Icon(Icons.cached_outlined, color: Colors.orange.withOpacity(.9)),
      Icon(Icons.delete, color: Colors.orange.withOpacity(.9)),
      /*Icon(
        Icons.padding_outlined,
        color: Colors.orange.withOpacity(.9),
      )*/
    ];
    List<Icon> listIconUpdate = [
      Icon(
        Icons.person_add_alt_rounded,
        color: Colors.orange.withOpacity(.9),
      ),
      Icon(
        Icons.cached_outlined,
        color: Colors.orange.withOpacity(.9),
        size: 0.1,
      ),
      Icon(Icons.delete, color: Colors.orange.withOpacity(.9)),
      /*Icon(
        Icons.padding_outlined,
        color: Colors.orange.withOpacity(.9),
      )*/
    ];

    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize:
                  MainAxisSize.min, // Set mainAxisSize to MainAxisSize.min
              children: [
                Flexible(
                  flex: 1,
                  child: cuadroBusqueda(size),
                ),
                const SizedBox(
                  height: 5,
                ),
                Flexible(
                  flex: 2,
                  child: listaBotones(
                    size,
                    ClientesTypes,
                    context,
                    listIcon,
                    listIconUpdate,
                    ClientsTypesUpdate,
                  ),
                ),
                /*  Container(
                  height: 70,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                  ),
                  padding: const EdgeInsets.only(
                    bottom: 0,
                    top: 20,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //  etiquetaClientes(),
                    ],
                  ),
                ), */

                Flexible(
                  flex: 1,
                  child: listaClientes(size),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Container listaBotones(
      Size size,
      List<String> ClientesTypes,
      BuildContext context,
      List<Icon> listIcon,
      List<Icon> listIconUpdate,
      List<Widget> ClientsTypesUpdate) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 5),
      margin: const EdgeInsets.only(bottom: 2),
      //altura del contenedor de los botones
      height: 90,
      width: size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: ClientesTypes.length,
          itemBuilder: (buildContext, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 7.5, left: 7.5),
              child: Container(
                margin: const EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                ),
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
                child: ElevatedButton.icon(
                  onPressed: () {
                    selectedIndex == index;
                    switch (index) {
                      case 0:
                        //NUEVOS CLIENTES
                        Navigator.push(
                            context,
                            PageTransition(
                              duration: const Duration(milliseconds: 850),
                              child: const Newcustomers(),
                              type: PageTransitionType.bottomToTop,
                            )).then((_) {
                          setState(() {
                            clients = controllerClientes.showClientes();
                            statusBottomDelete = false;
                          });
                        });

                        break;
                      case 1:
                        //ACTUALIZAR
                        setState(() {
                          statusBottomDelete = false;
                          clients = controllerClientes.showClientes();
                          isloading = true;
                          Get.to(() => const RootPage());
                          if (isloading == true) {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return Center(
                                      child: SpinKitRing(
                                    color: Colors.orange.withOpacity(0.9),
                                    size: 50.0,
                                    lineWidth: 4,
                                    duration: const Duration(seconds: 3),
                                  ));
                                });

                            Future.delayed(const Duration(milliseconds: 2000),
                                () {
                              setState(() {
                                isloading = false;
                                Get.back();
                              });
                            });
                          } else {}
                        });

                        break;
                      case 2:
                        //Eliminar
                        setState(() {
                          statusBottomDelete = !statusBottomDelete;
                          if (statusBottomDelete == true) {}
                        });
                        break;
                      case 3:
                        break;

                      default:
                        break;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    backgroundColor:
                        Colors.transparent, //Colors.blue.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0.0,
                  ),
                  icon: isloading == false
                      ? listIcon[index]
                      : listIconUpdate[index],
                  label: isloading == true
                      ? ClientsTypesUpdate[index]
                      : Text(
                          ClientesTypes[index],
                          style: TextStyle(
                              color: Colors.black.withOpacity(.9),
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                ),
              ),
            );
          }),
    );
  }

  Widget cuadroBusqueda(Size size) {
    return Container(
      width: size.width,
      height: 61,
      padding: const EdgeInsets.only(
        right: 10,
        left: 10,
        top: 10,
      ),
      margin: const EdgeInsets.only(left: 0, right: 0),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            width: size.width * .945,
            height: size.height,
            decoration: BoxDecoration(
              color: Constants.blueColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    //Icons.search_outlined,
                    Icons.search_sharp,
                    color: Constants.blueColor,
                    size: 30,
                  ),
                ),
                Expanded(
                    child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      search = value;
                    });
                  },
                  controller: controllerClientes.filtrar,
                  showCursor: true,
                  decoration: const InputDecoration(
                    hintText: 'Buscar cliente (Código, Nombre)',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                )),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      controllerClientes.filtrar.text = "";
                      search = "";
                      controllerClientes.filtrar.text = search;
                    });
                    clients = controllerClientes.showClientes();
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
    );
  }

  /* final List<Color> colors = [
    Colors.orange[200] as Color,
    Colors.cyan,
    Colors.amber,
    Colors.pink[200] as Color, // Rosa
    Colors.green[100] as Color, // Verde
    // Púrpura intenso
  ]; */

  final List<Color> colors = [
    Colors.orange[200] as Color,
    Colors.orangeAccent,
    Colors.amber,
    Colors.deepOrange[300] as Color, // Rosa
    Colors.orange[500] as Color, // Verde
    // Púrpura intenso
  ];

  Widget etiquetaClientes() {
    return FittedBox(
      fit: BoxFit.contain,
      child: Material(
        elevation: 0,
        color: Colors.transparent,
        child: CustomText(
          font: TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 25,
            color: Constants.orangeColor,
            fontWeight: FontWeight.bold,
          ),
          text: 'Todos los clientes',
        ),
      ),
    );
  }

  Widget listaClientes(Size size) {
    return Container(
      // DATOS DEL CLIENTE
      color: Colors.transparent,
      margin: const EdgeInsets.only(top: 0),
      padding: const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 5),
      height: (size.height / 1.4),
      child: FutureBuilder(
        future: clients,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.toString() != '[]') {
            // LISTA DE CLIENTES

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              // controller: _scrollController,
              slivers: [
                SliverAppBar(
                  pinned: false,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  floating: false,
                  collapsedHeight: 60,
                  foregroundColor: Colors.amber,
                  forceMaterialTransparency: false,
                  forceElevated: false,
                  title: Container(
                    color: Colors.transparent,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Nuevos Clientes",
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 200, // Altura del contenedor de la lista horizontal
                    child: ListView.builder(
                      scrollDirection:
                          Axis.horizontal, // Desplazamiento horizontal
                      itemCount: (snapshot
                          .data!.length), // Número de elementos en la lista
                      itemBuilder: (context, index) {
                        Color colorCard = colors[index % colors.length];
                        final codigo_cliente =
                            (snapshot.data?[index]["codigo_cliente"]);
                        final nombre = (snapshot.data?[index]["nombre"]);
                        final apellido_p =
                            (snapshot.data?[index]["apellido_p"]);
                        final apellido_m =
                            (snapshot.data?[index]["apellido_m"]);
                        final genero = (snapshot.data?[index]["genero"]);
                        final curp = (snapshot.data?[index]["curp"]);
                        final calle = (snapshot.data?[index]["calle"]);
                        final colonia = (snapshot.data?[index]["colonia"]);
                        final municipio_delegacion =
                            (snapshot.data?[index]["municipio_delegacion"]);
                        final estado = (snapshot.data?[index]["estado"]);
                        final codigo_postal =
                            (snapshot.data?[index]["codigo_postal"]);
                        final numero_tel =
                            (snapshot.data?[index]["numero_tel"]);
                        final fecha_nacimiento =
                            (snapshot.data?[index]["fecha_nacimiento"]);
                        final urlFoto = (snapshot.data?[index]["foto_url"]);
                        return Container(
                            padding: const EdgeInsets.only(),
                            width: 160, // Ancho de cada card
                            child: Card(
                              shadowColor: Colors.transparent,
                              color: colorCard,
                              elevation: 18,
                              margin: const EdgeInsets.all(12.0),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                        maxRadius: 28,
                                        child: ClipOval(
                                            child: CachedNetworkImage(
                                          width: size.width,
                                          height: size.height,
                                          fit: BoxFit.cover,
                                          imageUrl: (snapshot.data?[index]
                                              ["foto_url"]),
                                        ))),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${snapshot.data?[index]['nombre']} ${snapshot.data?[index]['apellido_p']}',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      height: 35,
                                      width: 70,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          //ultimos agregados
                                          Get.to(
                                            () => customerDetails(
                                              cont: index,
                                              datos: customerData,
                                              codigoCliente: codigo_cliente,
                                              nombre: nombre,
                                              apellidoP: apellido_p,
                                              apellidoM: apellido_m,
                                              genero: genero,
                                              curp: curp,
                                              calle: calle,
                                              colonia: colonia,
                                              municipioDelegacion:
                                                  municipio_delegacion,
                                              estado: estado,
                                              codigoPostal: codigo_postal,
                                              numeroTel: numero_tel,
                                              fechaNacimiento: fecha_nacimiento
                                                  .toDate()
                                                  .toString()
                                                  .substring(0, 10)
                                                  .split("-")
                                                  .reversed
                                                  .join("/"),
                                              urlFoto: urlFoto,
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_outlined,
                                          size: 25,
                                          color: Constants.blueColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                SliverAppBar(
                  pinned: false,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.red,
                  elevation: 15.0,
                  floating: true,
                  collapsedHeight: 60,
                  foregroundColor: Colors.amber,
                  scrolledUnderElevation: 4.5,
                  forceMaterialTransparency: true,
                  forceElevated: true,
                  title: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            etiquetaClientes(),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "(Mostrando ${snapshot.data?.length} clientes)",
                              style: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int cont) {
                      if ((snapshot.data?[cont]['nombre'])!
                              .toString()
                              .isCaseInsensitiveContains(search) ||
                          (snapshot.data?[cont]['codigo_cliente'])!
                              .toString()
                              .isCaseInsensitiveContains(search) ||
                          (snapshot.data?[cont]['apellido_p'])!
                              .toString()
                              .isCaseInsensitiveContains(search) ||
                          (snapshot.data?[cont]['apellido_m'])!
                              .toString()
                              .isCaseInsensitiveContains(search) ||
                          (snapshot.data?[cont]['apellido_p'] +
                                  " " +
                                  snapshot.data?[cont]['apellido_m'])!
                              .toString()
                              .isCaseInsensitiveContains(search) ||
                          (snapshot.data?[cont]['nombre'] +
                                  " " +
                                  snapshot.data?[cont]['apellido_p'] +
                                  " " +
                                  snapshot.data?[cont]['apellido_m'])!
                              .toString()
                              .isCaseInsensitiveContains(search)) {
                        return principalMetodo(
                          snapshot,
                          cont,
                          context,
                          size,
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                    childCount: snapshot.data?.length,
                  ),
                ),
              ],
            );
          } else {
            var orientation = MediaQuery.of(context).orientation;
            return orientation == Orientation.portrait
                ? SingleChildScrollView(
                    child: Container(
                      width: size.width,
                      height: size.height * 0.7,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          SpinKitThreeBounce(
                            duration: const Duration(milliseconds: 3000),
                            color: Colors.blue.withOpacity(0.7),
                            size: 50,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "No hay datos",
                            style: TextStyle(
                              color: Colors.blue.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              height: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                :
                //todo: no hay data cuando el telefono esta horizontal
                Container(
                    width: size.width,
                    height: size.height * 0.4,
                    color: Colors.transparent,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          SpinKitThreeBounce(
                            duration: const Duration(milliseconds: 3000),
                            color: Colors.blue.withOpacity(0.7),
                            size: 50,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "No hay datos",
                            style: TextStyle(
                              color: Colors.blue.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              height: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          }
        },
      ),
    );
  }

  /* Widget listaClientes(Size size) {
    return Container(
      // DATOS DEL CLIENTE
      color: Colors.transparent,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 19),
      height: (size.height / 1.78) - 40,
      child: FutureBuilder(
        future: clients,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.toString() != '[]') {
            // LISTA DE CLIENTES
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int cont) {
                      if ((snapshot.data?[cont]['nombre'])!
                              .toString()
                              .isCaseInsensitiveContains(search) ||
                          (snapshot.data?[cont]['codigo_cliente'])!
                              .toString()
                              .isCaseInsensitiveContains(search) ||
                          (snapshot.data?[cont]['apellido_p'])!
                              .toString()
                              .isCaseInsensitiveContains(search) ||
                          (snapshot.data?[cont]['apellido_m'])!
                              .toString()
                              .isCaseInsensitiveContains(search) ||
                          (snapshot.data?[cont]['apellido_p'] +
                                  " " +
                                  snapshot.data?[cont]['apellido_m'])!
                              .toString()
                              .isCaseInsensitiveContains(search) ||
                          (snapshot.data?[cont]['nombre'] +
                                  " " +
                                  snapshot.data?[cont]['apellido_p'] +
                                  " " +
                                  snapshot.data?[cont]['apellido_m'])!
                              .toString()
                              .isCaseInsensitiveContains(search)) {
                        return principalMetodo(
                          snapshot,
                          cont,
                          context,
                          size,
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                    childCount: snapshot.data?.length,
                  ),
                ),
              ],
            );
          } else {
            return Container(
              width: size.width,
              height: size.height,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  SpinKitThreeBounce(
                    duration: const Duration(milliseconds: 2000),
                    color: Colors.blue.withOpacity(0.7),
                    size: 50,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "No hay datos",
                    style: TextStyle(
                      color: Colors.blue.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      height: 2,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  } */

/* 
  Widget listaClientes(Size size) {
    return Container(
      // DATOS DEL CLIENTE
      color: Colors.transparent,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 19),
      height: (size.height / 1.78) - 40,
      child: FutureBuilder(
        future: clients,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.toString() != '[]') {
            // LISTA DE CLIENTES
            return ListView.builder(
                itemCount: snapshot.data?.length, //lista en firebase
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext contexto, int cont) {
                  if ((snapshot.data?[cont]['nombre'])
                          .toString()
                          .isCaseInsensitiveContains(search) ||
                      (snapshot.data?[cont]['codigo_cliente'])
                          .toString()
                          .isCaseInsensitiveContains(search) ||
                      (snapshot.data?[cont]['apellido_p'])
                          .toString()
                          .isCaseInsensitiveContains(search) ||
                      (snapshot.data?[cont]['apellido_m'])
                          .toString()
                          .isCaseInsensitiveContains(search) ||
                      (snapshot.data?[cont]['apellido_p'] +
                              " " +
                              snapshot.data?[cont]['apellido_m'])
                          .toString()
                          .isCaseInsensitiveContains(search) ||
                      (snapshot.data?[cont]['nombre'] +
                              " " +
                              snapshot.data?[cont]['apellido_p'] +
                              " " +
                              snapshot.data?[cont]['apellido_m'])
                          .toString()
                          .isCaseInsensitiveContains(search)) {
                    return principalMetodo(
                      snapshot,
                      cont,
                      context,
                      size,
                    );
                  } else {
                    return Container();
                  }
                });
          } else {
            return Container(
                width: size.width,
                height: size.height,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    SpinKitThreeBounce(
                      duration: const Duration(milliseconds: 2000),
                      color: Colors.blue.withOpacity(0.7),
                      size: 50,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "No hay datos",
                      style: TextStyle(
                        color: Colors.blue.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        height: 2,
                      ),
                    ),
                  ],
                ));
          }
        },
      ),
    );
  } */

  Widget principalMetodo(
    AsyncSnapshot<List<dynamic>> snapshot,
    int cont,
    BuildContext context,
    Size size,
  ) {
    return GestureDetector(
      onTap: () {
        customerData = [
          "Codigo: " + snapshot.data?[cont]["codigo_cliente"],
          "Nombre: " + snapshot.data?[cont]["nombre"],
          "Apellido Paterno: " + snapshot.data?[cont]["apellido_p"],
          "Apellido Materno: " + snapshot.data?[cont]["apellido_m"],
          "Genero: " + snapshot.data?[cont]["genero"],
          "Curp: " + snapshot.data?[cont]["curp"],
          "Calle: " + snapshot.data?[cont]["calle"],
          "Colonia: " + snapshot.data?[cont]["colonia"],
          "Municio ó Delegación: " +
              snapshot.data?[cont]["municipio_delegacion"],
          "Estado: " + snapshot.data?[cont]["estado"],
          "CP: " + (snapshot.data?[cont]["codigo_postal"]).toString(),
          "Telefono :" + (snapshot.data?[cont]["numero_tel"]).toString(),
          "Fecha de nacimiento: " +
              (snapshot.data?[cont]["fecha_nacimiento"])
                  .toDate()
                  .toString()
                  .substring(0, 10)
                  .split("-")
                  .reversed
                  .join("/"),
        ];

        final codigo_cliente = (snapshot.data?[cont]["codigo_cliente"]);
        final nombre = (snapshot.data?[cont]["nombre"]);
        final apellido_p = (snapshot.data?[cont]["apellido_p"]);
        final apellido_m = (snapshot.data?[cont]["apellido_m"]);
        final genero = (snapshot.data?[cont]["genero"]);
        final curp = (snapshot.data?[cont]["curp"]);
        final calle = (snapshot.data?[cont]["calle"]);
        final colonia = (snapshot.data?[cont]["colonia"]);
        final municipio_delegacion =
            (snapshot.data?[cont]["municipio_delegacion"]);
        final estado = (snapshot.data?[cont]["estado"]);
        final codigo_postal = (snapshot.data?[cont]["codigo_postal"]);
        final numero_tel = (snapshot.data?[cont]["numero_tel"]);
        final fecha_nacimiento = (snapshot.data?[cont]["fecha_nacimiento"]);
        final urlFoto = (snapshot.data?[cont]["foto_url"]);

        /*
          snapshot.data?[cont]["interes_asignado"],
          snapshot.data?[cont]["monto_solicitado"],
          snapshot.data?[cont]["monto_inicial"],
          snapshot.data?[cont]["plazos"],
          (snapshot.data?[cont]["fecha_prestamo"])
              .toDate()
              .toString()
              .substring(0, 10)
              .split("-")
              .reversed
              .join("/"),
          (snapshot.data?[cont]["dias_semana"]).toString().substring(
              1, (snapshot.data?[cont]["dias_semana"]).toString().length - 1),
              */

        Navigator.push(
            context,
            PageTransition(
                duration: const Duration(milliseconds: 600),
                child: customerDetails(
                  cont: cont,
                  datos: customerData,
                  codigoCliente: codigo_cliente,
                  nombre: nombre,
                  apellidoP: apellido_p,
                  apellidoM: apellido_m,
                  genero: genero,
                  curp: curp,
                  calle: calle,
                  colonia: colonia,
                  municipioDelegacion: municipio_delegacion,
                  estado: estado,
                  codigoPostal: codigo_postal,
                  numeroTel: numero_tel,
                  fechaNacimiento: fecha_nacimiento
                      .toDate()
                      .toString()
                      .substring(0, 10)
                      .split("-")
                      .reversed
                      .join("/"),
                  urlFoto: urlFoto,
                ),
                type: PageTransitionType.bottomToTop));
      },
      child: FadeInRight(
        duration: const Duration(milliseconds: 100),
        delay: Duration(milliseconds: 20 * cont),
        child: Stack(alignment: Alignment.center, children: [
          DecoratedBox(
              decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          )),
          Card(
            color: Colors.transparent,
            clipBehavior: Clip.none,
            elevation: 0.0,
            child: Container(
              color: Colors.transparent,
              margin: const EdgeInsets.only(
                top: 5,
                bottom: 5,
              ),
              child: Slidable(
                direction: Axis.horizontal,
                dragStartBehavior: DragStartBehavior.start,
                closeOnScroll: true,
                endActionPane: ActionPane(
                  extentRatio: 0.33,
                  motion: const BehindMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (value) async {
                        await controllerClientes.showDeleteMessage(
                            "Realmente deseas eliminar a ${(snapshot.data?[cont]["nombre"])}?",
                            (snapshot.data?[cont]["codigo_cliente"]));

                        setState(() {
                          statusBottomDelete = false;
                          clients = clientsController().showClientes();
                        });
                      },
                      spacing: 7,
                      icon: Icons.delete,
                      backgroundColor: Constants.orangeColor,
                      foregroundColor: Colors.black,
                      borderRadius: BorderRadius.circular(7),
                      label: "Eliminar",
                      autoClose: true,
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
                //listas
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue[400] as Color,
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  // altura de los container
                  height: 90,
                  padding: const EdgeInsets.only(
                    left: 8,
                    top: 2,
                  ),
                  // el margen de altura del contenedor
                  margin: const EdgeInsets.only(
                      bottom: 1, top: 0, right: 10, left: 0),
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            //posiciones del marco de la foto
                            width: 70.0,
                            height: 72.0,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[800],
                              shape: BoxShape.circle,
                            ),
                          ),
                          Positioned(
                              //posiciones de la foto
                              bottom: 4,
                              left: 0,
                              right: 0,
                              top: 5,
                              child: SizedBox(
                                  height: 80.0,
                                  child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          //al presionar la imagen de perfil cliente
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          child: (snapshot.data?[cont]
                                                          ["foto_url"]) ==
                                                      null ||
                                                  (snapshot.data?[cont]
                                                          ["foto_url"])
                                                      .toString()
                                                      .isEmpty
                                              ? Text(
                                                  "${(snapshot.data?[cont]["nombre"]).substring(0, 1)}",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 23,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.bold))
                                              : ClipOval(
                                                  child: Hero(
                                                    tag: (snapshot.data?[cont]
                                                        ["foto_url"]),
                                                    child: CachedNetworkImage(
                                                      key: UniqueKey(),
                                                      imageUrl:
                                                          (snapshot.data?[cont]
                                                              ["foto_url"]),
                                                      fit: BoxFit.cover,
                                                      height: size.height,
                                                      width: 63,
                                                      cacheManager:
                                                          customCacheManager,
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  downloadProgress) =>
                                                              Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress,
                                                          color:
                                                              Colors.blue[900],
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      )))),
                          Positioned(
                            //poscisiones del texto

                            left: 75,
                            top: 2,

                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  //contenedor de nombre
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 10,
                                      top: 10,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    width: SizeNameTextContainer(size),
                                    color: Colors.transparent,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                          maxLines: 2,
                                          "${snapshot.data?[cont]['codigo_cliente']} ${snapshot.data?[cont]['nombre']}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color:
                                                Colors.black.withOpacity(0.8),
                                          )),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        const EdgeInsets.only(top: 2, left: 10),
                                    padding: const EdgeInsets.only(
                                        bottom: 1, left: 2),
                                    alignment: Alignment.centerLeft,
                                    width: SizeNameTextContainer(size),
                                    color: Colors.transparent,
                                    child: Text(
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      maxLines: 1,

                                      "${snapshot.data?[cont]['apellido_p']} ${snapshot.data?[cont]['apellido_m']}",
                                      //"${snapshot.data?[cont]['apellido_m']}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.cyan[700]),

                                      // ignore: unnecessary_string_escapes
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 60,
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  if (statusBottomDelete == true) {
                                    await clientsController().showDeleteMessage(
                                        '¿Seguro que quieres eliminar a\n ${snapshot.data?[cont]["nombre"]}?',
                                        '${snapshot.data?[cont]["codigo_cliente"]}');
                                    setState(() {
                                      clients =
                                          controllerClientes.showClientes();
                                    });
                                  } else {
                                    statusBottomDelete = false;
                                    setState(() {
                                      clients =
                                          controllerClientes.showClientes();
                                    });
                                  }
                                },
                                child: Icon(Icons.delete,
                                    size: 25,
                                    color: statusBottomDelete == true
                                        ? Colors.orange.withOpacity(.8)
                                        : Colors.transparent)),
                            GestureDetector(
                                onTap: () {
                                  if (statusBottomDelete == true) {
                                    setState(() {
                                      statusBottomDelete = false;
                                      clients =
                                          controllerClientes.showClientes();
                                    });
                                  } else {
                                    statusBottomDelete = false;
                                  }
                                },
                                child: Icon(Icons.check_box,
                                    size: 25,
                                    color: statusBottomDelete == true
                                        ? Colors.green.withOpacity(.8)
                                        : Colors.transparent)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  SizeNameTextContainer(Size size) {
    if (size.width >= 201) {
      return size.width - 230;
    }
  }
}
