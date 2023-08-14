// ignore_for_file: file_names, prefer_final_fields

import 'package:aldigitti/Models/CustomerDataModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataProvider with ChangeNotifier {
  CustomerDataModel _customerDataModel = CustomerDataModel(
    customerFromName: "Nereden",
    customerFromLat: 0,
    customerFromLong: 0,
    customerToName: "Nereye",
    customerToLat: 0,
    customerToLong: 0,
    customerDate: DateFormat('dd/MM/yy').format(DateTime.now()),
    cargoType: "Belge",
    customerDesi: 0,
  );

  String get customerFromName => _customerDataModel.customerFromName;
  double get customerFromLat => _customerDataModel.customerFromLat;
  double get customerFromLong => _customerDataModel.customerFromLong;

  String get customerToName => _customerDataModel.customerToName;
  double get customerToLat => _customerDataModel.customerToLat;
  double get customerToLong => _customerDataModel.customerToLong;

  String get customerDate => _customerDataModel.customerDate;
  String get cargoType => _customerDataModel.cargoType;
  double get customerDesi => _customerDataModel.customerDesi;

  void setCustomerFromName(String fromName) {
    _customerDataModel.setCustomerFromName(fromName);
    notifyListeners();
  }

  void setCustomerFromLat(double fromLat) {
    _customerDataModel.setCustomerFromLat(fromLat);
    notifyListeners();
  }

  void setCustomerFromLong(double fromLong) {
    _customerDataModel.setCustomerFromLong(fromLong);
    notifyListeners();
  }

  void setCustomerToName(String toName) {
    _customerDataModel.setCustomerToName(toName);
    notifyListeners();
  }

  void setCustomerToLat(double toLat) {
    _customerDataModel.setCustomerToLat(toLat);
    notifyListeners();
  }

  void setCustomerToLong(double toLong) {
    _customerDataModel.setCustomerToLong(toLong);
    notifyListeners();
  }

  void setCustomerDate(String date) {
    _customerDataModel.setCustomerDate(date);
    notifyListeners();
  }

  void setCargoType(String cargoType) {
    _customerDataModel.setCargoType(cargoType);
    notifyListeners();
  }

  void setCustomerDesi(double customerDesi) {
    _customerDataModel.setCustomerDesi(customerDesi);
    notifyListeners();
  }
}
