// ignore_for_file: file_names, avoid_print

import 'package:aldigitti/Models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PersonalInformationViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getCurrentUserInfo() async {
    User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      return null;
    }

    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(currentUser.uid).get();

    if (!userDoc.exists) {
      return null;
    }

    return UserModel.fromJson({
      'uid': currentUser.uid,
      ...userDoc.data()! as Map<String, dynamic>,
    });
  }

  Future<void> updateUserInfo(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).update(user.toMap());

      if (user.email != null && user.email!.isNotEmpty) {
        User? firebaseUser = _auth.currentUser;
        await firebaseUser!.updateEmail(user.email!);
        print('✅ PRINT DEBUG ✅ User info update success');
      }
    } catch (e) {
      print('❌ PRINT DEBUG ❌ User info update failed: $e');
    }
  }
}
