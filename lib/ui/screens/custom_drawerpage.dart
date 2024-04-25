import 'package:cobranzas/controllers/controllerDrawer.dart';
import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/models/custom_text_title.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:cobranzas/ui/root_page.dart';
import 'package:cobranzas/ui/screens/widgets/delate_user_type.dart';
import 'package:cobranzas/ui/screens/widgets/new_profile_user.dart';
import 'package:cobranzas/ui/screens/widgets/new_user.dart';
import 'package:cobranzas/ui/screens/widgets/privilege_control.dart';
import 'package:cobranzas/ui/screens/widgets/show_users.dart';
import 'package:flutter/material.dart';
import 'package:cobranzas/controllers/user_controller.dart';
import 'package:get/get.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  static var drawerController = Get.put(Drawercontroller());
  static var userController = Get.put(UserController());
  late bool isSuperUser = true;

  @override
  void initState() {
    drawerController.esSuperUsuario().then((val) {
      isSuperUser = val;
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String obtenerIniciales(String nombreCompleto) {
    List<String> palabras = nombreCompleto.split(' ');
    String iniciales = '';

    for (var i = 0; i < palabras.length; i++) {
      var palabra = palabras[i];
      iniciales += palabra[i].toUpperCase();

      // Si las iniciales superan los 3 caracteres, detener el bucle
      if (iniciales.length >= 3) {
        break;
      }
    }

    // Devolver solo las primeras 3 iniciales
    return iniciales.substring(0, 3);
  }

  @override
  Widget build(BuildContext context) {
    //  final isLoading = true.obs;
    Size size = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;

    return StreamBuilder<Map<String, dynamic>>(
        stream: drawerController.obtenerDatosUsuarioStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
                color: Colors.white,
                child: const Text('No se encontraron datos del usuario'));
          }
          var userData = snapshot.data!;

          return Column(
            children: [
              orientation == Orientation.portrait
                  ? Container(
                      color: Colors.transparent,
                      height: size.height,
                      width: size.width / 1.5,
                      child: Drawer(
                        backgroundColor: Colors.blue.withOpacity(0.4),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.3),
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue[300] as Color,
                                spreadRadius: 0,
                                blurRadius: 0,
                                offset: const Offset(-25, 30),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 12, left: 15, bottom: 15, right: 10),
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 40,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Container(
                                    height: (size.height * 0.2),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.blue[600] as Color,
                                          spreadRadius: 1,
                                          blurRadius: 7,
                                          offset: const Offset(1, 3),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: size.height * 0.02,
                                          left: size.width * 0.05,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.blue[800]
                                                            as Color),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    gradient:
                                                        const LinearGradient(
                                                            begin: Alignment(
                                                                0.09, -0.9),
                                                            end: Alignment(
                                                                -0.6, 0.8),
                                                            colors: [
                                                          Colors.blueGrey,
                                                          Colors.white70,
                                                          Colors.white,
                                                          Colors.white70,
                                                          Colors.blueGrey,
                                                        ])),
                                                child: CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    child: Icon(
                                                      Icons.person,
                                                      color: Colors.blue[700],
                                                      size: 40,
                                                    )),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                isSuperUser == true
                                                    ? "( ${userData["roll_SuperUsuario"]} )"
                                                    : "( ${userData["roll"]} )",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 17,
                                                  color: Colors.cyan[700],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: size.height * 0.1,
                                          left: size.width * 0.03,
                                          child: Stack(children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  color: Colors.transparent,
                                                  width: size.width * 0.55,
                                                  child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: CustomTextTitle(
                                                      title: isSuperUser == true
                                                          ? '¡Hola, ${((userData["nombre_SuperUsuario"]).toString().split(" ").sublist(0, 2).join(" ")).toUpperCase()}!'
                                                          : '¡Hola, ${((userData["nombre"]).toString().split(" ").sublist(0, 2).join(" ")).toUpperCase()}!'
                                                              .toUpperCase(),
                                                      size: 15,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: size.width * 0.55,
                                                  color: Colors.transparent,
                                                  child: FittedBox(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                      isSuperUser == true
                                                          ? (userData[
                                                              "correo_SuperUsuario"])
                                                          : (userData[
                                                              "correo"]),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                        ),
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: IconButton(
                                            iconSize: 30,
                                            icon: const Icon(
                                              Icons.arrow_back,
                                              color: Colors.amber,
                                              applyTextScaling: false,
                                            ),
                                            onPressed: () {
                                              Get.back(); // Navegar hacia atrás
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: getListItemsDrawer(context, size)),
                            ],
                          ),
                        ),
                      ),
                    )
                  :
                  //todo: modo horizontal//
                  Container(
                      color: Colors.transparent,
                      height: size.height,
                      width: size.width / 2.5,
                      child: Drawer(
                        backgroundColor: Colors.blue.withOpacity(0.4),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.3),
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue[300] as Color,
                                spreadRadius: 0,
                                blurRadius: 0,
                                offset: const Offset(-25, 30),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 12, left: 15, bottom: 15, right: 10),
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 40,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Container(
                                    height: (size.height * 0.4),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.blue[600] as Color,
                                          spreadRadius: 1,
                                          blurRadius: 7,
                                          offset: const Offset(1, 3),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: size.height * 0.04,
                                          left: size.width * 0.020,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.blue[800]
                                                            as Color),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    gradient:
                                                        const LinearGradient(
                                                            begin: Alignment(
                                                                0.09, -0.9),
                                                            end: Alignment(
                                                                -0.6, 0.8),
                                                            colors: [
                                                          Colors.blueGrey,
                                                          Colors.white70,
                                                          Colors.white,
                                                          Colors.white70,
                                                          Colors.blueGrey,
                                                        ])),
                                                child: CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    child: Icon(
                                                      Icons.person,
                                                      color: Colors.blue[700],
                                                      size: 40,
                                                    )),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                isSuperUser == true
                                                    ? "(${userData["roll_SuperUsuario"]})"
                                                    : "(${userData["roll"]})",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 17,
                                                  color: Colors.cyan[700],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: size.height * 0.19,
                                          left: size.width * 0.015,
                                          child: Stack(children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  color: Colors.transparent,
                                                  width: size.width * 0.30,
                                                  child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: CustomTextTitle(
                                                      title: isSuperUser == true
                                                          ? '¡Hola, ${((userData["nombre_SuperUsuario"]).toString().split(" ").sublist(0, 2).join(" ")).toUpperCase()}!'
                                                          : '¡Hola, ${((userData["nombre"]).toString().split(" ").sublist(0, 2).join(" ")).toUpperCase()}!'
                                                              .toUpperCase(),
                                                      size: 15,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: size.width * 0.33,
                                                  color: Colors.transparent,
                                                  child: FittedBox(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                      isSuperUser == true
                                                          ? (userData[
                                                              "correo_SuperUsuario"])
                                                          : (userData[
                                                              "correo"]),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                        ),
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: IconButton(
                                            iconSize: 30,
                                            icon: const Icon(
                                              Icons.arrow_back,
                                              color: Colors.amber,
                                              applyTextScaling: false,
                                            ),
                                            onPressed: () {
                                              Get.back(); // Navegar hacia atrás
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: getListItemsDrawer(context, size)),
                            ],
                          ),
                        ),
                      ),
                    )
            ],
          );
        });
  }

  ListView getListItemsDrawer(BuildContext context, Size size) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        createDrawerItem(
            textColorsubTitle: Constants.blueColor,
            iconColor: Colors.blue[800] as Color,
            icon: Icons.home,
            text: 'Inicio',
            onTap: () {
              Get.offAll(() => const RootPage());
            }),
        createDrawerItem(
          textColorTitle: Constants.blueColor,
          iconColor: Colors.blue[800] as Color,
          subOptionsColor: Colors.white12,
          icon: Icons.person,
          text: 'Usuarios',
          onTap: () {},
          subOptions: [
            //todo: opciones de menu desplegable usuarios//
            createDrawerItem(
              iconColor: Colors.tealAccent[700] as Color,
              textColorsubTitle: Colors.black.withOpacity(0.7),
              icon: Icons.person_add,
              text: 'Nuevo usuario',
              onTap: () {
                Get.to(
                  () => const NewUser(),
                  duration: const Duration(milliseconds: 1000),
                  fullscreenDialog: GetPlatform.isMobile,
                  opaque: false,
                  popGesture: true,
                  transition: Transition.circularReveal,
                );
              },
            ),
            createDrawerItem(
              iconColor: Colors.orange[300] as Color,
              textColorsubTitle: Colors.black.withOpacity(0.7),
              icon: Icons.people,
              text: 'Mostrar Usuarios',
              onTap: () async {
                userController.tipoUsuario(
                  "Ver",
                  () => Get.to(
                    () => const ShowUser(),
                    duration: const Duration(milliseconds: 500),
                    fullscreenDialog: GetPlatform.isMobile,
                    opaque: false,
                    popGesture: true,
                    transition: Transition.circularReveal,
                  ),
                  () => Get.to(
                    () => const ShowUser(),
                    duration: const Duration(milliseconds: 500),
                    fullscreenDialog: GetPlatform.isMobile,
                    opaque: false,
                    popGesture: true,
                    transition: Transition.circularReveal,
                  ),
                  () => userController.mensajePrivilegio(
                      "No tiene privilegios para mostrar usuarios", context),
                );
/* 
                Get.to(
                  () => const ShowUser(),
                  duration: const Duration(milliseconds: 1000),
                  fullscreenDialog: GetPlatform.isMobile,
                  opaque: false,
                  popGesture: true,
                  transition: Transition.circularReveal,
                ); */
              },
            ),

            createDrawerItem(
              textColorsubTitle: Colors.black.withOpacity(0.7),
              iconColor: Constants.blueColor,
              icon: Icons.lock_person_rounded,
              text: 'Privilegios de usuario',
              onTap: () {
                Get.to(
                  () => const PrivilegiosPage(),
                  duration: const Duration(milliseconds: 1000),
                  fullscreenDialog: GetPlatform.isMobile,
                  opaque: false,
                  popGesture: true,
                  transition: Transition.circularReveal,
                );
              },
            ),
            createDrawerItem(
              iconColor: Colors.green,
              textColorsubTitle: Colors.black.withOpacity(0.7),
              icon: Icons.account_circle,
              text: 'Nuevo perfil de usuario',
              onTap: () {
                Get.to(
                  () => const NewProfileUser(),
                  duration: const Duration(milliseconds: 1000),
                  fullscreenDialog: GetPlatform.isMobile,
                  opaque: false,
                  popGesture: true,
                  transition: Transition.circularReveal,
                );
              },
            ),
            createDrawerItem(
              textColorsubTitle: Colors.black.withOpacity(0.7),
              icon: Icons.delete_forever,
              iconColor: Colors.red,
              text: 'Eliminar perfil de usuario',
              onTap: () {
                Get.to(
                  () => const DeleteUserType(),
                  duration: const Duration(milliseconds: 1000),
                  fullscreenDialog: GetPlatform.isMobile,
                  opaque: false,
                  popGesture: true,
                  transition: Transition.circularReveal,
                );
              },
            ),
          ],
        ),
        createDrawerItem(
          textColorsubTitle: Constants.blueColor,
          iconColor: Colors.blue[800] as Color,
          icon: Icons.settings,
          text: 'Configuración',
          onTap: () => Navigator.pop(context),
        ),
        Padding(
          padding: EdgeInsets.only(right: size.width * 0.06),
          child: Divider(color: Colors.blueGrey.withOpacity(0.5)),
        ),
        createDrawerItem(
          textColorsubTitle: Colors.blue[800] as Color,
          iconColor: Colors.blue[800] as Color,
          icon: Icons.door_back_door,
          text: 'Cerrar Sesión',
          onTap: () {
            authenticationRepository.showcerrarSesion(
                "¿Estás seguro que quieres cerrar sesión?", context);
          },
        ),
      ],
    );
  }

  Widget createDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color textColorTitle = Colors.black,
    Color textColorsubTitle = Colors.black,
    required Color iconColor,
    List<Widget>? subOptions,
    Color? subOptionsColor,
  }) {
    return subOptions != null
        ? Theme(
            data: ThemeData().copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ExpansionTile(
              leading: Icon(
                icon,
                color: iconColor,
              ),
              title: Text(
                text,
                style: TextStyle(
                  color: textColorTitle,
                  fontWeight: FontWeight.w900,
                ),
              ),
              children: subOptions.map((subOption) {
                return Container(
                  color: subOptionsColor ?? Colors.transparent,
                  child: subOption,
                );
              }).toList(),
            ),
          )
        : ListTile(
            leading: Icon(icon, color: iconColor),
            title: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Text(
                text,
                style: TextStyle(
                  color: textColorsubTitle,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            onTap: onTap,
          );
  }
}
