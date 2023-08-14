// ignore_for_file: prefer_final_fields

class CustomerDataModel {
  String _customerFromName;
  double _customerFromLat;
  double _customerFromLong;

  String _customerToName;
  double _customerToLat;
  double _customerToLong;

  String _customerDate;
  String _cargoType;
  double _customerDesi;

  CustomerDataModel(
      {required String customerFromName,
      required double customerFromLat,
      required double customerFromLong,
      required String customerToName,
      required double customerToLat,
      required double customerToLong,
      required String customerDate,
      required String cargoType,
      required double customerDesi})
      : _customerFromName = customerFromName,
        _customerFromLat = customerFromLat,
        _customerFromLong = customerFromLong,
        _customerToName = customerToName,
        _customerToLat = customerToLat,
        _customerToLong = customerToLong,
        _customerDate = customerDate,
        _cargoType = cargoType,
        _customerDesi = customerDesi;

  String get customerFromName => _customerFromName;
  double get customerFromLat => _customerFromLat;
  double get customerFromLong => _customerFromLong;

  String get customerToName => _customerToName;
  double get customerToLat => _customerToLat;
  double get customerToLong => _customerToLong;

  String get customerDate => _customerDate;
  String get cargoType => _cargoType;
  double get customerDesi => _customerDesi;

  void setCustomerFromName(String customerFromName) {
    _customerFromName = customerFromName;
  }

  void setCustomerFromLat(double customerFromLat) {
    _customerFromLat = customerFromLat;
  }

  void setCustomerFromLong(double customerFromLong) {
    _customerFromLong = customerFromLong;
  }

  void setCustomerToName(String customerToName) {
    _customerToName = customerToName;
  }

  void setCustomerToLat(double customerToLat) {
    _customerToLat = customerToLat;
  }

  void setCustomerToLong(double customerToLong) {
    _customerToLong = customerToLong;
  }

  void setCustomerDate(String customerDate) {
    _customerDate = customerDate;
  }

  void setCargoType(String cargoType) {
    _cargoType = cargoType;
  }

  void setCustomerDesi(double customerDesi) {
    _customerDesi = customerDesi;
  }
}
