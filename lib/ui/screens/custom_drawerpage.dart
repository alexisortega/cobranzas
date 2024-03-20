import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:cobranzas/ui/root_page.dart';
import 'package:cobranzas/ui/screens/widgets/privilege_control.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    //  final isLoading = true.obs;
    Size size = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;

    return orientation == Orientation.portrait
        ? Drawer(
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
                      elevation: 0,
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
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Constants.blueColor,
                                    child: const Icon(Icons.person_outline,
                                        size: 45.0, color: Colors.white70),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text("(Administrador)",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black54)),
                                ],
                              ),
                            ),
                            Positioned(
                              top: size.height * 0.1,
                              left: size.width * 0.03,
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '¡Hola, Alexis!',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('usuario@example.com',
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
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
                  Expanded(child: getListItemsDrawer(context, size)),
                ],
              ),
            ),
          )
        :
        //todo: modo horizontal//
        Drawer(
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
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        height: (size.height * 0.32),
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
                              left: size.width * 0.025,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Constants.blueColor,
                                    child: const Icon(Icons.person_outline,
                                        size: 45.0, color: Colors.white70),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text("(Administrador)",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black54)),
                                ],
                              ),
                            ),
                            Positioned(
                              top: size.height * 0.16,
                              left: size.width * 0.03,
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '¡Hola, Alexis!',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('usuario@example.com',
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
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
                    child: getListItemsDrawer(context, size),
                  ),
                ],
              ),
            ),
          );
  }

  ListView getListItemsDrawer(BuildContext context, Size size) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        createDrawerItem(
            icon: Icons.home,
            text: 'Inicio',
            onTap: () {
              Get.offAll(() => const RootPage());
            }),
        createDrawerItem(
          icon: Icons.person,
          text: 'Usuarios',
          onTap: () {},
          subOptions: [
            createDrawerItem(
              icon: Icons.person_add,
              text: 'Nuevo usuario',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            createDrawerItem(
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
              icon: Icons.admin_panel_settings,
              text: 'Nuevo tipo de usuario',
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
        createDrawerItem(
          icon: Icons.settings,
          text: 'Configuración',
          onTap: () => Navigator.pop(context),
        ),
        Padding(
          padding: EdgeInsets.only(right: size.width * 0.06),
          child: Divider(color: Colors.blueGrey.withOpacity(0.5)),
        ),
        createDrawerItem(
          icon: Icons.exit_to_app,
          text: 'Cerrar Sesión',
          onTap: () {
            authenticationRepository.showcerrarSesion(
                "¿Estás seguro que quieres cerrar sesión?", context);
          },
          textColor: Colors.cyan[900] as Color,
        ),
      ],
    );
  }

  Widget createDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color textColor = const Color.fromARGB(255, 2, 54, 102),
    List<Widget>? subOptions,
  }) {
    return subOptions != null
        ? Theme(
            data: ThemeData().copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ExpansionTile(
              leading: Icon(
                icon,
                color: textColor,
              ),
              title: Text(text,
                  style:
                      TextStyle(color: textColor, fontWeight: FontWeight.bold)),
              children: subOptions,
            ),
          )
        : ListTile(
            leading: Icon(icon, color: textColor),
            title: Text(text,
                style:
                    TextStyle(color: textColor, fontWeight: FontWeight.bold)),
            onTap: onTap,
          );
  }
}
