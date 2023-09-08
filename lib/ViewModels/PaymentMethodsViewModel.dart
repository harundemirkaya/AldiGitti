// ignore_for_file: file_names, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentMethodsViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> checkBankAccount() async {
    try {
      User? user = _auth.currentUser;

      if (user == null) {
        return false;
      }

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

      if (userData != null &&
          userData['bankAccount'] != null &&
          (userData['bankAccount'] as List).isNotEmpty) {
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>?> getBankAccountDetails() async {
    try {
      User? user = _auth.currentUser;

      if (user == null) {
        return null;
      }

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

      if (userData != null &&
          userData['bankAccount'] != null &&
          (userData['bankAccount'] as List).isNotEmpty) {
        return (userData['bankAccount'] as List)[0] as Map<String, dynamic>;
      }

      return null;
    } catch (e) {
      print("❌ PRINT DEBUG ❌ Error: $e");
      return null;
    }
  }

  Future<bool> removeBankAccount() async {
    try {
      User? user = _auth.currentUser;

      if (user == null) {
        return false;
      }

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

      if (userData != null &&
          userData['bankAccount'] != null &&
          (userData['bankAccount'] as List).isNotEmpty) {
        List bankAccounts = userData['bankAccount'] as List;
        bankAccounts.removeAt(0);

        await _firestore
            .collection('users')
            .doc(user.uid)
            .update({'bankAccount': bankAccounts});

        return true;
      }

      return false;
    } catch (e) {
      print("❌ PRINT DEBUG ❌ Error: $e");
      return false;
    }
  }
}
