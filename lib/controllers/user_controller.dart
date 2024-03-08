import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserController extends GetxController {

  Future<Map<String, dynamic>> getPrivilegiosFromFirestore(String userId) async {
  try {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot docSnapshot =
        await db.collection('SuperUsuarios').doc(userId).get();

    if (docSnapshot.exists) {
      final dynamic privilegiosData = docSnapshot.data();
      return Map<String, dynamic>.from(privilegiosData?['privilegios'] ?? {});
    } else {
      return {};
    }
  } catch (e) {
    print.printInfo(info: "Error al obtener privilegios desde Firestore: $e");
    throw Exception("Error al obtener privilegios desde Firestore");
  }
}

  
}