// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddBankViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> addBankAccount({
    required String accountOwnerName,
    required String iban,
    required String bankName,
  }) async {
    try {
      User? user = _auth.currentUser;

      if (user == null) {
        return false;
      }

      Map<String, String> bankAccount = {
        'accountOwnerName': accountOwnerName,
        'iban': iban,
        'bankName': bankName,
      };

      await _firestore.collection('users').doc(user.uid).update({
        'bankAccount': FieldValue.arrayUnion([bankAccount]),
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
