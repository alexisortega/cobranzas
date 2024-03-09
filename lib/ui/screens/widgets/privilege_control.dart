import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/controllers/user_controller.dart';
import 'package:cobranzas/ui/screens/widgets/customer_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PrivilegiosScreen extends StatefulWidget {
  const PrivilegiosScreen({super.key});

  @override
  PrivilegiosScreenState createState() => PrivilegiosScreenState();
}

class PrivilegiosScreenState extends State<PrivilegiosScreen> {
  late Map<dynamic, dynamic> privilegios = {};
  final userController = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    loadPrivilegiosFirestore();
  }

  Future<void> loadPrivilegiosFirestore() async {
    //regresa el usuario que esta activo
    final auth = FirebaseAuth.instance;
    final userId = auth.currentUser?.uid;
// verifica si el usario no es nulo
    if (userId != null) {
      try {
        final privilegeFirebase =
            userController.getPrivilegiosFromFirestore(userId);
        privilegios = await privilegeFirebase;
      } catch (e) {
        printInfo(info: "Error al cargar privilegios desde Firestore: $e");
      }
    }

    // Actualizar el estado para reflejar los cambios en la UI
    if (mounted) {
      setState(() {});
    }
  }

  Widget buildTree(Map<dynamic, dynamic> privilegios, String title) {
    // Ordenar las claves alfabéticamente
    final sortedKeys = privilegios.keys.toList()..sort();

    return Theme(
      data: ThemeData().copyWith(
          dividerColor: Colors.transparent,
          listTileTheme: ListTileThemeData(
            titleTextStyle: TextStyle(color: Constants.orangeColor),
          )),
      child: ExpansionTile(
        childrenPadding: const EdgeInsets.all(10),
        initiallyExpanded: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Constants.blueColor,
          ),
        ),
        children: sortedKeys.map<Widget>((key) {
          final value = privilegios[key];
          if (value is bool) {
            return ListTile(
              isThreeLine: false,
              title: Text(key),
              trailing: Checkbox(
                checkColor: Colors.black,
                splashRadius: 20,
                activeColor: Colors.blue[600],
                value: value,
                onChanged: (bool? newValue) {
                  setState(() {
                    privilegios[key] = newValue;
                  });
                },
              ),
            );
          } else if (value is Map) {
            // Llamada recursiva para construir el árbol para los mapas anidados
            return buildTree(value, key);
          } else {
            // Puedes manejar otros tipos de valores según tus necesidades
            return SizedBox(
              height: 100,
              width: 200,
              child: textViewCustomer(
                  texto: "NO hay datos", color: Constants.blueColor, size: 12),
            );
          }
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: privilegios.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  forceMaterialTransparency: true,
                  backgroundColor: Colors
                      .transparent, // Un fondo transparente puede ser más atractivo
                  expandedHeight:
                      250.0, // Un poco más de altura para dar espacio al contenido
                  floating:
                      false, // Cambiado a false para un comportamiento más coherente al desplazarse
                  pinned: false, // Mantiene la barra visible al hacer scroll
                  snap: false, // Desactivado para evitar saltos repentinos
                  automaticallyImplyLeading:
                      true, // Dejar Flutter decidir automáticamente sobre el leading widget basado en el contexto de navegación
                  iconTheme: const IconThemeData(
                    size: 30, // Ajuste del tamaño de los iconos
                    color: Colors.orange,
                    // Un color llamativo para los iconos
                  ),
                  flexibleSpace: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return FlexibleSpaceBar(
                        title: constraints.maxWidth < 800
                            ? Text(
                                'Privilegios de usuario',
                                style: TextStyle(
                                  color: Constants
                                      .blueColor, // Usa el color que mejor se ajuste a tu paleta
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              )
                            : Center(
                                child: Text(
                                  'Privilegios de usuario',
                                  style: TextStyle(
                                    color: Constants
                                        .blueColor, // Usa el color que mejor se ajuste a tu paleta
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              top: -125,
                              left: 50,
                              child: Image.asset(
                                'assets/pantallaPrivilegios.png', // Asegúrate de que esta ruta es correcta
                                fit: BoxFit
                                    .fill, // Cubrir para que la imagen se expanda bien
                              ),
                            ),
                            // Este overlay oscurece ligeramente la imagen para que el texto resalte más
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.0, 0.5),
                                  end: Alignment(0.0, 0.0),
                                  colors: <Color>[
                                    Colors.black38,
                                    Colors.black12,
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(
                      height: 10,
                    ),
                    buildTree(privilegios, 'Privilegios'),
                  ]),
                ),
                /* SliverToBoxAdapter(
                  child: Container(
                    color: Colors.red,
                    child: Column(
                      children: [
                        ElevatedButton(
                            onPressed: () {}, child: const Icon(Icons.abc))
                      ],
                    ),
                  ),
                ) */
              ],
            ),
    );
  }
}
