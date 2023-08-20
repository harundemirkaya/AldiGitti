// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> register(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        try {
          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'name': name,
            'email': email,
          });
          print("✅ PRINT DEBUG ✅ Register Success");
          return true;
        } catch (firestoreError) {
          print("❌ PRINT DEBUG ❌ Firestore Error: $firestoreError");
          return false;
        }
      } else {
        print("❌ PRINT DEBUG ❌ Register Failed: User is null");
        return false;
      }
    } catch (authError) {
      print("❌ PRINT DEBUG ❌ FirebaseAuth Error: $authError");
      return false;
    }
  }
}
