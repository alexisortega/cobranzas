import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/controllers/user_controller.dart';
import 'package:cobranzas/models/custom_text_title.dart';
import 'package:cobranzas/ui/screens/widgets/customer_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class PrivilegiosPage extends StatefulWidget {
  const PrivilegiosPage({super.key});

  @override
  PrivilegiosScreenState createState() => PrivilegiosScreenState();
}

class PrivilegiosScreenState extends State<PrivilegiosPage> {
  var fondoPrivilegios = "";
  late Map<dynamic, dynamic> privilegios = {};
  final userController = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    loadPrivilegiosFirestore();
    fondoPrivilegios = "assets/fondoPrivilegios.png";
  }

  Future<void> loadPrivilegiosFirestore() async {
    //regresa el usuario que esta activo
    final auth = FirebaseAuth.instance;
    final userId = auth.currentUser?.uid;
// verifica si el usario no es nulo
    if (userId != null) {
      try {
        final privilegeFirebase = userController.getPrivilegiosFromFirestore();
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
        listTileTheme: const ListTileThemeData(
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 17,
          ),
        ),
      ),
      child: ExpansionTile(
        childrenPadding: const EdgeInsets.only(left: 20, right: 15),
        initiallyExpanded: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Constants.orangeColor,
          ),
        ),
        children: sortedKeys.map<Widget>((key) {
          final value = privilegios[key];
          if (value is bool) {
            return ListTile(
              isThreeLine: false,
              title: Text(
                key,
              ),
              trailing: Checkbox(
                checkColor: Colors.white,
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
    var orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: Colors.white,
      body: privilegios.isEmpty
          ? orientation == Orientation.portrait
              ? Container(
                  width: size.width,
                  height: size.height * 0.7,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.transparent,
                              margin: const EdgeInsets.only(left: 20, top: 20),
                              child: TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.arrow_back_outlined,
                                  color: Constants.orangeColor,
                                  size: 35,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.2,
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
                  ))
              //todo: modo horizontal
              : Container(
                  width: size.width,
                  height: size.height,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.transparent,
                              margin: const EdgeInsets.only(left: 20, top: 20),
                              child: TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.arrow_back_outlined,
                                  color: Constants.orangeColor,
                                  size: 35,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.2,
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
                  ))
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  scrolledUnderElevation: 10,
                  forceMaterialTransparency: true,
                  backgroundColor: Colors
                      .transparent, // Un fondo transparente puede ser más atractivo
                  expandedHeight: orientation == Orientation.portrait
                      ? 300.0
                      : 200, // Un poco más de altura para dar espacio al contenido
                  floating:
                      false, // Cambiado a false para un comportamiento más coherente al desplazarse
                  pinned: false, // Mantiene la barra visible al hacer scroll
                  snap: false, // Desactivado para evitar saltos repentinos
                  automaticallyImplyLeading:
                      true, // Dejar Flutter decidir automáticamente sobre el leading widget basado en el contexto de navegación
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
                  elevation: 10,
                  flexibleSpace: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return FlexibleSpaceBar(
                        title: orientation == Orientation.portrait
                            ? Padding(
                                padding: EdgeInsets.only(
                                  left: 0,
                                  right: size.width * 0.0,
                                ),
                                child: const CustomTextTitle(
                                  title: 'PRIVILEGIOS DE USUARIO',
                                  size: 15.0,
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                  left: size.width * 0.15,
                                ),
                                child: const CustomTextTitle(
                                  title: 'PRIVILEGIOS DE USUARIO',
                                  size: 15.0,
                                ),
                              ),
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            orientation == Orientation.portrait
                                ? Positioned(
                                    top: size.width * 0.0,
                                    bottom: size.width * 0.12,
                                    right: size.width * 0.0,
                                    left: size.width * 0.0,
                                    child: Image.asset(
                                      fondoPrivilegios, // Asegúrate de que esta ruta es correcta
                                      fit: BoxFit
                                          .contain, // Cubrir para que la imagen se expanda bien
                                    ),
                                  )
                                : Positioned(
                                    top: size.width * 0.0,
                                    bottom: size.width * 0.0,
                                    right: size.width * 0.5,
                                    left: size.width * 0.0,
                                    child: Image.asset(
                                      fondoPrivilegios, // Asegúrate de que esta ruta es correcta
                                      fit: BoxFit
                                          .contain, // Cubrir para que la imagen se expanda bien
                                    ),
                                  ),
                            // Este overlay oscurece ligeramente la imagen para que el texto resalte más
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.0, 0.5),
                                  end: Alignment(0.0, 0.0),
                                  colors: <Color>[
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
                    buildTree(privilegios, 'TODOS LOS PERFILES :'),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 40,
                      margin: orientation == Orientation.portrait
                          ? const EdgeInsets.only(
                              bottom: 20, left: 20, right: 20)
                          : const EdgeInsets.only(
                              bottom: 20, left: 150, right: 150),
                      child: ElevatedButton(
                        onPressed: () async {
                          await UserController()
                              .savePrivilegeChanges(privilegios, context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10), // Padding interno del botón
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                35), // Borde redondeado del botón
                          ),
                          elevation: 3, // Elevación del botón
                        ),
                        child: const Text(
                          'Guardar Cambios',
                          style: TextStyle(
                            color: Colors.white, // Color del texto del botón
                            fontSize: 14, // Tamaño del texto del botón
                          ),
                        ),
                      ),
                    ),
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
