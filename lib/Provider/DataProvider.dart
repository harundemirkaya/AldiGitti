// ignore_for_file: file_names

import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  String _fromName = "Nereden";
  double _fromLat = 0;
  double _fromLong = 0;

  String _toName = "Nereye";
  double _toLat = 0;
  double _toLong = 0;

  String get fromName => _fromName;
  double get fromLat => _fromLat;
  double get fromLong => _fromLong;

  String get toName => _toName;
  double get toLat => _toLat;
  double get toLong => _toLong;

  void setFromData(String fromName, double fromLat, double fromLong) {
    _fromName = fromName;
    _fromLat = fromLat;
    _fromLong = fromLong;
    notifyListeners();
  }

  void setToData(String toName, double toLat, double toLong) {
    _toName = toName;
    _toLat = toLat;
    _toLong = toLong;
    notifyListeners();
  }
}
