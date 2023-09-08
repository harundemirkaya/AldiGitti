// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class ChangePasswordViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<bool, String>> changePassword(
      String oldPassword, String newPassword, String newPasswordAgain) async {
    if (newPassword != newPasswordAgain) {
      return {false: "Şifreler Eşleşmiyor"};
    }

    User? user = _auth.currentUser;

    if (user == null) {
      return {false: "Kullanıcı Bulunamadı"};
    }

    AuthCredential credential = EmailAuthProvider.credential(
      email: user.email!,
      password: oldPassword,
    );

    try {
      UserCredential userCredential =
          await user.reauthenticateWithCredential(credential);
      await userCredential.user!.updatePassword(newPassword);

      return {true: "Şifre Başarıyla Değiştirildi"};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return {false: "Mevcut şifre yanlış"};
      }

      return {false: "Firebase Auth hatası: ${e.message}"};
    } on PlatformException catch (e) {
      return {false: "Platform hatası: ${e.message}"};
    } catch (e) {
      return {false: "Bir hata oluştu: $e"};
    }
  }
}
