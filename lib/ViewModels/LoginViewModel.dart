// ignore_for_file: file_names, avoid_print, use_build_context_synchronously

import 'package:aldigitti/Models/UserModel.dart';
import 'package:aldigitti/Providers/UserProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LoginViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final BuildContext context;

  LoginViewModel({required this.context});

  Future<bool> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        print("✅ PRINT DEBUG ✅ Login Success");
        Provider.of<UserProvider>(context, listen: false)
            .setUser(UserModel(uid: userCredential.user!.uid));
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
