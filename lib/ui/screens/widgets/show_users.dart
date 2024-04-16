import 'package:cobranzas/controllers/user_controller.dart';
import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/models/custom_text_title.dart';

import 'package:cobranzas/ui/screens/widgets/new_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  final ScrollController _scrollController = ScrollController();
  Future<List<Map<String, dynamic>>> listUserdata = Future(() => []);
  String search = "";

  @override
  void initState() {
    fondoShowUser = "assets/FondoShowUsers.png";
    listUserdata = userController.getUsersLinkedToSuperUser();

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
          controller: userController.serchShowUser,
          showCursor: true,
          cursorColor: Constants.blueColor,
          enableInteractiveSelection: true,
          decoration: InputDecoration(
            hintText: 'Buscar usuario',
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.7),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  userController.serchShowUser.text = "";
                  search = "";
                  userController.serchShowUser.text = search;
                });
              },
              child: Icon(
                Icons.cancel,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white.withOpacity(0.7),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(
              top: 5,
            ),
          ),
          style: TextStyle(
            color: _scrollController.position.pixels < 300
                ? Colors.black.withOpacity(0.7)
                : Colors.white,
          ),
          onChanged: (value) {
            //guardar el valor del cuadro de texto
            setState(() {
              search = value;
            });
          },
        ),
      ),
    ]);
  }

  void showUserDetailsDialog(Size size, Map<String, dynamic> userData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 8.0,
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "DETALLE DEL USUARIO",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Constants.blueColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow("Nombre: ", userData['nombre']),
                    const SizedBox(height: 12),
                    _buildDetailRow("Correo electrónico: ", userData['correo']),
                    const SizedBox(height: 12),
                    _buildDetailRow("Tipo de usuario: ", userData['roll']),
                    const SizedBox(height: 12),
                    _buildDetailRow("Dirección: ", userData['direccion']),
                    const SizedBox(height: 12),
                    _buildDetailRow("Teléfono", userData['telefono']),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: Colors.blue.withOpacity(0.9),
                        ),
                        child: const Text(
                          "Cerrar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value.isEmail ? value : value.toUpperCase(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: Constants.blueColor.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  void showEditUserDialog(Map<String, dynamic> userData) {
    TextEditingController nombreController =
        TextEditingController(text: userData['nombre']);
    TextEditingController emailController =
        TextEditingController(text: userData['correo']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 8.0,
          backgroundColor: Colors.white,
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Editar usuario",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField("Nombre", nombreController),
                    const SizedBox(height: 12),
                    _buildTextField("Correo electrónico", emailController),
                    const SizedBox(height: 12),
                    _buildTextField("Correo electrónico", emailController),
                    const SizedBox(height: 12),
                    _buildTextField("Correo electrónico", emailController),
                    const SizedBox(height: 12),
                    _buildTextField("Correo electrónico", emailController),
                    const SizedBox(height: 12),
                    _buildTextField("Correo electrónico", emailController),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              backgroundColor: Colors.blue.withOpacity(0.1),
                            ),
                            child: const Text(
                              "Cancelar",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Aquí puedes manejar la lógica para guardar los cambios del usuario
                              // Por ejemplo, puedes obtener los nuevos valores de los controladores nombreController y emailController
                              // Y luego realizar las operaciones necesarias para actualizar los datos del usuario
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: const Text(
                              "Guardar",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
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
                        isSelected == true ? cuadroBusqueda(size) : Container(),
                        IconButton(
                          icon: Icon(
                            isSelected == true
                                ? Icons.search_off_rounded
                                : Icons.search,
                            color: Colors.orange,
                            size: 35,
                          ),
                          onPressed: () async {
                            setState(() {
                              isSelected = !isSelected;

                              userController.serchShowUser.text = "";
                              search = "";
                              userController.serchShowUser.text = search;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              forceMaterialTransparency: true,
              backgroundColor: Colors.white,
              expandedHeight: orientation == Orientation.portrait ? 350.0 : 200,
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

            SliverToBoxAdapter(
              child: SizedBox(
                height: size.height * 0.02,
              ),
            ),

            //todo: Sliver lista de usuarios

            FutureBuilder<List<Map<String, dynamic>>>(
              future: listUserdata,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                } else if (snapshot.hasData &&
                    snapshot.data.toString() != '[]') {
                  List<Map<String, dynamic>> listUsers = snapshot.data ?? [];
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final userData = listUsers[index];
                        if ((userData['nombre'])!
                                .toString()
                                .isCaseInsensitiveContains(search) ||
                            (userData['correo'])!
                                .toString()
                                .isCaseInsensitiveContains(search) ||
                            (userData['roll'])!
                                .toString()
                                .isCaseInsensitiveContains(search)) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal:
                                        orientation == Orientation.portrait
                                            ? 25.0
                                            : 50),
                                child: Slidable(
                                  direction: Axis.horizontal,
                                  dragStartBehavior: DragStartBehavior.start,
                                  closeOnScroll: true,
                                  endActionPane: ActionPane(
                                    extentRatio: 0.40,
                                    motion: const BehindMotion(),
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SlidableAction(
                                        onPressed: (value) async {},
                                        spacing: 7,
                                        icon: Icons.delete,
                                        backgroundColor: Constants.orangeColor,
                                        foregroundColor: Colors.black,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                        label: "Eliminar",
                                        autoClose: true,
                                      ),
                                      SlidableAction(
                                        onPressed: (value) async {
                                          showEditUserDialog(userData);
                                        },
                                        spacing: 7,
                                        icon: Icons.edit,
                                        backgroundColor: Colors.green.shade400,
                                        foregroundColor: Colors.black,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        label: "Editar",
                                        autoClose: true,
                                      ),
                                    ],
                                  ),
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
                                          titleAlignment:
                                              ListTileTitleAlignment.center,
                                          leading: const CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            child: Icon(Icons.person,
                                                color: Colors.black),
                                          ),
                                          title: Container(
                                            color: Colors.transparent,
                                            margin:
                                                const EdgeInsets.only(right: 5),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "${userData['nombre']}"
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${userData['correo']}",
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                "(${userData['roll']})",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Constants.blueColor),
                                              ),
                                            ],
                                          ),
                                          trailing: GestureDetector(
                                              onTap: () {
                                                showEditUserDialog(userData);
                                              },
                                              child: Transform.rotate(
                                                angle: 26.7,
                                                child: Icon(
                                                  size: 30,
                                                  CupertinoIcons
                                                      .square_arrow_down_on_square_fill,
                                                  color: Constants.blueColor,
                                                ),
                                              )),
                                          onTap: () {
                                            showUserDetailsDialog(
                                                size, userData);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                      childCount: listUsers.length,
                    ),
                  );
                } else {
                  var orientation = MediaQuery.of(context).orientation;
                  return SliverToBoxAdapter(
                    child: orientation == Orientation.portrait
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
                                    duration:
                                        const Duration(milliseconds: 3000),
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
                                    duration:
                                        const Duration(milliseconds: 3000),
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
                          ),
                  );
                }
              },
            ),
            //todo: terminacion SliverList
            SliverToBoxAdapter(
              child: SizedBox(
                height: size.height * 0.1,
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
          },
        ),
      ),
    );
  }
}
