// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AvailableBalanceViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> fetchUserBalance() async {
    User? user = _auth.currentUser;

    if (user == null) {
      print("❌ PRINT DEBUG ❌ Kullanıcı bulunamadı");
      return {"balance": 0, "actions": []};
    }

    DocumentSnapshot doc =
        await _firestore.collection('users').doc(user.uid).get();

    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      int balance = data['balance'] ?? 0;
      List<dynamic> actions = data['actions'] ?? [];

      return {"balance": balance, "actions": actions};
    } else {
      return {"balance": 0, "actions": []};
    }
  }
}
