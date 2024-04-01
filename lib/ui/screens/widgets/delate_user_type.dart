import 'package:cobranzas/controllers/user_controller.dart';
import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/models/custom_text_title.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class DeleteUserType extends StatefulWidget {
  const DeleteUserType({super.key});

  @override
  State<DeleteUserType> createState() => _DeleteUserTypeState();
}

class _DeleteUserTypeState extends State<DeleteUserType> {
  final userController = Get.put(UserController());
  late Future<Map<String, dynamic>> privilegiosFuture;
  List<String> perfilesAEliminar = [];
  late String fondoEliminarPerfilUsuario = "";
  @override
  void initState() {
    privilegiosFuture = userController.getPrivilegiosFromFirestore();
    fondoEliminarPerfilUsuario = "assets/fondoEliminarPerfilUsuario.png";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;

    return SafeArea(
      maintainBottomViewPadding: true,
      top: false,
      child: Scaffold(
        body: FutureBuilder<Map<String, dynamic>>(
          future: privilegiosFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data.toString() != "{}") {
              final privilegios = snapshot.data ?? {};

              return CustomScrollView(
                slivers: [
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
                    iconTheme: const IconThemeData(
                      size: 35, // Ajuste del tamaño de los iconos
                      color: Colors.orange,

                      // Un color llamativo para los iconos
                    ),
                    elevation: 10,
                    flexibleSpace: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return FlexibleSpaceBar(
                          title: orientation == Orientation.portrait
                              ? Stack(
                                  children: [
                                    Container(
                                      height: 50,
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.038),
                                        child: const CustomTextTitle(
                                          title: "ELIMINAR PERFIL DE USUARIO",
                                          size: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.17),
                                  child: const CustomTextTitle(
                                    title: "ELIMINAR PERFIL DE USUARIO",
                                    size: 14,
                                  )),
                          background: Stack(
                            fit: StackFit.expand,
                            children: [
                              orientation == Orientation.portrait
                                  ? Positioned(
                                      top: size.height * -0.01,
                                      bottom: size.height * 0.02,
                                      left: size.width * 0.0,
                                      right: size.width * 0.0,
                                      child: Image.asset(
                                        fondoEliminarPerfilUsuario, // Asegúrate de que esta ruta es correcta
                                        fit: BoxFit
                                            .contain, // Cubrir para que la imagen se expanda bien
                                      ),
                                    )
                                  : Positioned(
                                      top: size.height * -0.001,
                                      bottom: size.height * -0.05,
                                      left: size.width * 0.0,
                                      right: size.width * 0.6,
                                      child: Image.asset(
                                        fondoEliminarPerfilUsuario, // Asegúrate de que esta ruta es correcta
                                        fit: BoxFit
                                            .contain, // Cubrir para que la imagen se expanda bien
                                      ),
                                    ),
                              // Este overlay oscurece ligeramente la imagen para que el texto resalte más
                              const DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.0, 0.6),
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
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 30,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final key = privilegios.keys.elementAt(index);
                        final value = privilegios[key];
                        final bool isChecked =
                            value == 'true'; // Convertir cadena a booleano

                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.orange[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: orientation == Orientation.portrait
                              ? const EdgeInsets.only(
                                  top: 10, left: 20, right: 20)
                              : const EdgeInsets.only(
                                  top: 10, left: 50, right: 50),
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(
                                right: 10, left: 20, top: 0),
                            title: Text(
                              key,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 22,
                                color: Colors.black,
                              ),
                            ),
                            trailing: Checkbox(
                              activeColor: Colors.blue,
                              checkColor: Colors.white,
                              autofocus: true,
                              focusColor: Colors.amber,
                              value: isChecked,
                              onChanged: (newValue) {
                                setState(() {
                                  privilegios[key] = newValue.toString();
                                  // Si el Checkbox se deselecciona, agrega o elimina el perfil de usuario de la lista a eliminar

                                  if (newValue!) {
                                    // Si el checkbox se marca
                                    setState(() {
                                      // Agregar el perfil a la lista de perfiles a eliminar
                                      perfilesAEliminar.add(key);
                                    });
                                  } else {
                                    setState(() {
                                      // elimina el perfil que no se va a eliminar ya selecionados y se deselecciono
                                      perfilesAEliminar.remove(key);
                                    });
                                  }

                                  /* if (newValue!) {
                                    if (perfilesAEliminar.contains(key)) {
                                      perfilesAEliminar.remove(key);
                                    } else {
                                      perfilesAEliminar.add(key);
                                    }
                                  } else {
                          
                          
                                  } */
                                });
                              },
                            ),
                          ),
                        );
                      },
                      childCount: privilegios.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(
                        left: size.width * 0.2,
                        right: size.width * 0.2,
                        top: 20,
                        bottom: 20,
                      ),
                      child: ElevatedButton(
                        autofocus: true,
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.cyan,
                        ),
                        onPressed: () async {
                          try {
                            bool isLoading = false;
                            //verificar si los checkbox no estan vacios
                            if (perfilesAEliminar.isNotEmpty) {
                              // Eliminar todos los perfiles seleccionados
                              setState(() {
                                isLoading = true;
                              });

                              if (isLoading == true) {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return SpinKitRing(
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      color: Constants.orangeColor,
                                      size: 50.0,
                                      lineWidth: 4,
                                    );
                                  },
                                );

                                Future.delayed(
                                    const Duration(milliseconds: 1000), () {
                                  setState(() {
                                    isLoading = false;
                                    Get.back();
                                  });
                                }).whenComplete(() async {
                                  await Future.wait(perfilesAEliminar.map(
                                      (perfil) => userController
                                          .eliminarPerfilUsuario(perfil)));

                                  // Limpiar la lista de perfiles a eliminar después de la eliminación
                                  setState(() {
                                    perfilesAEliminar.clear();
                                  });
                                  // Actualizar la interfaz de usuario después de eliminar todos los perfiles
                                  privilegiosFuture = userController
                                      .getPrivilegiosFromFirestore()
                                      .whenComplete(() => setState(() {
                                            authenticationRepository
                                                .showMessage(
                                              "Aviso",
                                              "El perfil de usuario se elimino correctamente",
                                              context,
                                            );
                                          }));
                                });
                              } else {
                                authenticationRepository.showMessage(
                                    "Advertencia",
                                    "Algo salio mal, intente más tarde",
                                    context);
                              }
                            } else {
                              //
                              authenticationRepository.showMessage(
                                  "Aviso",
                                  "Necesitas seleccionar un perfil de usuario para eliminar",
                                  context);
                            }
                          } catch (e) {
                            printError(info: "$e");
                            authenticationRepository.showMessage("Advertencia",
                                "Algo salio mal, intente más tarde", context);
                          }
                        },
                        child: const Text(
                          'Eliminar perfil de usuario',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
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
                            Container(
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    color: Colors.transparent,
                                    margin: const EdgeInsets.only(
                                        left: 20, top: 20),
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
                              height: 20,
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
                  //todo: modo horizontal
                  : SingleChildScrollView(
                      child: Container(
                        width: size.width,
                        height: size.height * 0.6,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                    margin: const EdgeInsets.only(
                                        left: 20, top: 20),
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
                        ),
                      ),
                    );
            }
          },
        ),
        /* floatingActionButton: FloatingActionButton(
          onPressed: () {
            /*   perfilesAEliminar.forEach((perfil) {
              eliminarPerfilUsuario(perfil);
            }); */
          },
          child: const Icon(Icons.delete),
        ), */
      ),
    );
  }
}
