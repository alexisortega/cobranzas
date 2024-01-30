import 'package:cobranzas/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          height: size.height,
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
          child: ListView(
            
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 5, 33, 82),
                              size: 40,
                            ),
                          ),
                          SizedBox(height: 10, width: 10),
                          Text(
                            '¡Hola, nombre!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "correo",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'Inicio',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: const Icon(Icons.home, color: Colors.white),
                onTap: () {
                  // Lógica para navegar a la pantalla de inicio
                  Navigator.pop(context); // Cierra el Drawer
                },
              ),
              ListTile(
                title: const Text(
                  'Perfil',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: const Icon(Icons.person, color: Colors.white),
                onTap: () {
                  // Lógica para navegar a la pantalla de perfil
                  Navigator.pop(context); // Cierra el Drawer
                },
              ),
              ListTile(
                title: const Text(
                  'Configuración',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: const Icon(Icons.settings, color: Colors.white),
                onTap: () {
                  // Lógica para navegar a la pantalla de configuración
                  Navigator.pop(context); // Cierra el Drawer
                },
              ),
              const Divider(color: Colors.white),
              ListTile(
                title: const Text(
                  'Cerrar Sesión',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: const Icon(Icons.exit_to_app, color: Colors.red),
                onTap: () {
                  // Lógica para cerrar sesión
                  Navigator.pop(context); // Cierra el Drawer
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
