// ignore_for_file: file_names

import 'package:aldigitti/Models/UserModel.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
