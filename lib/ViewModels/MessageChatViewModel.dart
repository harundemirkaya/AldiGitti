// ignore_for_file: avoid_print, file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageChatViewModel {
  Future<String> fetchRemoteUserName(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      String driverName = userDoc['name'] ?? '';
      return driverName;
    } catch (e) {
      print("❌ PRINT DEBUG ❌ Fetch Driver Name Failed: $e");
      return "Unknown";
    }
  }
}
