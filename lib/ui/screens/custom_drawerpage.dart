import 'package:cobranzas/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
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
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  createDrawerItem(
                    icon: Icons.home,
                    text: 'Inicio',
                    onTap: () => Navigator.pop(context),
                  ),
                  createDrawerItem(
                    icon: Icons.person,
                    text: 'Perfil',
                    onTap: () => Navigator.pop(context),
                    subOptions: [
                      createDrawerItem(
                        icon: Icons.info,
                        text: 'Información de Perfil',
                        onTap: () {
                          // Lógica para la subopción de Información de Perfil
                          print('Perfil > Información de Perfil');
                          Navigator.pop(context);
                        },
                      ),
                      createDrawerItem(
                        icon: Icons.settings,
                        text: 'Configuración de Perfil',
                        onTap: () {
                          // Lógica para la subopción de Configuración de Perfil
                          print('Perfil > Configuración de Perfil');
                          Navigator.pop(context);
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
                    onTap: () => Navigator.pop(context),
                    textColor: Constants.orangeColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
        ? ExpansionTile(
            
            leading: Icon(icon, color: textColor),
            title: Text(text, style: TextStyle(color: textColor)),
            children: subOptions,
          )
        : ListTile(
            leading: Icon(icon, color: textColor),
            title: Text(text, style: TextStyle(color: textColor)),
            onTap: onTap,
          );
  }
}
