// ignore_for_file: file_names, use_build_context_synchronously

import 'package:aldigitti/Models/UserModel.dart';
import 'package:aldigitti/Providers/UserProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class RegisterViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final BuildContext context;

  RegisterViewModel({required this.context});

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
          Provider.of<UserProvider>(context, listen: false)
              .setUser(UserModel(uid: userCredential.user!.uid));
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
