import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobranzas/constants.dart';
import 'package:cobranzas/controllers/user_controller.dart';
import 'package:cobranzas/ui/screens/widgets/customer_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivilegiosScreen extends StatefulWidget {
  const PrivilegiosScreen({super.key});

  @override
  PrivilegiosScreenState createState() => PrivilegiosScreenState();
}

class PrivilegiosScreenState extends State<PrivilegiosScreen> {
  late Map<dynamic, dynamic> privilegios = {};
  final userController = Get.find<UserController>();
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

    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      children: sortedKeys.map<Widget>((key) {
        final value = privilegios[key];
        if (value is bool) {
          return ListTile(
            title: Text(key),
            trailing: Checkbox(
              value: value,
              onChanged: (bool? newValue) {
                // Implementa la lógica de actualización si es necesario
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Privilegios de usuario')),
        backgroundColor: Colors.amber,
      ),
      body: privilegios.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                buildTree(privilegios, 'Privilegios'),
              ],
            ),
    );
  }
}
