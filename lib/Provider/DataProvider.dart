// ignore_for_file: file_names, prefer_final_fields

import 'package:aldigitti/Models/CustomerDataModel.dart';
import 'package:aldigitti/Models/DriverDataModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataProvider with ChangeNotifier {
  // CUSTOMER MODEL

  CustomerDataModel _customerDataModel = CustomerDataModel(
    customerFromName: "Nereden",
    customerFromLat: 0,
    customerFromLong: 0,
    customerToName: "Nereye",
    customerToLat: 0,
    customerToLong: 0,
    customerDate: DateFormat('dd/MM/yy').format(DateTime.now()),
    customerCargoType: "Belge",
    customerDesi: 0,
  );

  String get customerFromName => _customerDataModel.customerFromName;
  double get customerFromLat => _customerDataModel.customerFromLat;
  double get customerFromLong => _customerDataModel.customerFromLong;

  String get customerToName => _customerDataModel.customerToName;
  double get customerToLat => _customerDataModel.customerToLat;
  double get customerToLong => _customerDataModel.customerToLong;

  String get customerDate => _customerDataModel.customerDate;
  String get customerCargoType => _customerDataModel.customerCargoType;
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

  void setCustomerCargoType(String cargoType) {
    _customerDataModel.setCustomerCargoType(cargoType);
    notifyListeners();
  }

  void setCustomerDesi(double customerDesi) {
    _customerDataModel.setCustomerDesi(customerDesi);
    notifyListeners();
  }

  // DRIVER MODEL
  DriverDataModel _driverDataModel = DriverDataModel(
    driverFromName: "Nereden",
    driverFromLat: 0,
    driverFromLong: 0,
    driverToName: "Nereye",
    driverToLat: 0,
    driverToLong: 0,
    driverDate: DateFormat('dd/MM/yy').format(DateTime.now()),
    driverCargoType: "0",
    driverDesi: 0,
    driverPrice: 0,
  );

  String get driverFromName => _driverDataModel.driverFromName;
  double get driverFromLat => _driverDataModel.driverFromLat;
  double get driverFromLong => _driverDataModel.driverFromLong;

  String get driverToName => _driverDataModel.driverToName;
  double get driverToLat => _driverDataModel.driverToLat;
  double get driverToLong => _driverDataModel.driverToLong;

  String get driverDate => _driverDataModel.driverDate;
  String get driverCargoType => _driverDataModel.driverCargoType;
  double get driverDesi => _driverDataModel.driverDesi;
  double get driverPrice => _driverDataModel.driverPrice;

  void setDriverFromName(String fromName) {
    _driverDataModel.setDriverFromName(fromName);
    notifyListeners();
  }

  void setDriverFromLat(double fromLat) {
    _driverDataModel.setDriverFromLat(fromLat);
    notifyListeners();
  }

  void setDriverFromLong(double fromLong) {
    _driverDataModel.setDriverFromLong(fromLong);
    notifyListeners();
  }

  void setDriverToName(String toName) {
    _driverDataModel.setDriverToName(toName);
    notifyListeners();
  }

  void setDriverToLat(double toLat) {
    _driverDataModel.setDriverToLat(toLat);
    notifyListeners();
  }

  void setDriverToLong(double toLong) {
    _driverDataModel.setDriverToLong(toLong);
    notifyListeners();
  }

  void setDriverDate(String date) {
    _driverDataModel.setDriverDate(date);
    notifyListeners();
  }

  void setDriverCargoType(String cargoType) {
    _driverDataModel.setDriverCargoType(cargoType);
    notifyListeners();
  }

  void setDriverDesi(double driverDesi) {
    _driverDataModel.setDriverDesi(driverDesi);
    notifyListeners();
  }

  void setDriverPrice(double driverPrice) {
    _driverDataModel.setDriverPrice(driverPrice);
    notifyListeners();
  }
}
