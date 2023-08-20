// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        print("✅ PRINT DEBUG ✅ Login Success");
        return true;
      } else {
        print("❌ PRINT DEBUG ❌ Login Failed: User is null");
        return false;
      }
    } catch (authError) {
      print("❌ PRINT DEBUG ❌ FirebaseAuth Login Error: $authError");
      return false;
    }
  }
}
