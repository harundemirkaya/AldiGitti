// ignore_for_file: prefer_final_fields, file_names

class DriverDataModel {
  String _driverFromName;
  double _driverFromLat;
  double _driverFromLong;

  String _driverToName;
  double _driverToLat;
  double _driverToLong;

  String _driverDate;
  String _driverCargoType;
  double _driverDesi;
  double _driverPrice;

  DriverDataModel({
    required String driverFromName,
    required double driverFromLat,
    required double driverFromLong,
    required String driverToName,
    required double driverToLat,
    required double driverToLong,
    required String driverDate,
    required String driverCargoType,
    required double driverDesi,
    required double driverPrice,
  })  : _driverFromName = driverFromName,
        _driverFromLat = driverFromLat,
        _driverFromLong = driverFromLong,
        _driverToName = driverToName,
        _driverToLat = driverToLat,
        _driverToLong = driverToLong,
        _driverDate = driverDate,
        _driverCargoType = driverCargoType,
        _driverDesi = driverDesi,
        _driverPrice = driverPrice;

  String get driverFromName => _driverFromName;
  double get driverFromLat => _driverFromLat;
  double get driverFromLong => _driverFromLong;

  String get driverToName => _driverToName;
  double get driverToLat => _driverToLat;
  double get driverToLong => _driverToLong;

  String get driverDate => _driverDate;
  String get driverCargoType => _driverCargoType;
  double get driverDesi => _driverDesi;
  double get driverPrice => _driverPrice;

  void setDriverFromName(String driverFromName) {
    _driverFromName = driverFromName;
  }

  void setDriverFromLat(double driverFromLat) {
    _driverFromLat = driverFromLat;
  }

  void setDriverFromLong(double driverFromLong) {
    _driverFromLong = driverFromLong;
  }

  void setDriverToName(String driverToName) {
    _driverToName = driverToName;
  }

  void setDriverToLat(double driverToLat) {
    _driverToLat = driverToLat;
  }

  void setDriverToLong(double driverToLong) {
    _driverToLong = driverToLong;
  }

  void setDriverDate(String driverDate) {
    _driverDate = driverDate;
  }

  void setDriverCargoType(String cargoType) {
    _driverCargoType = cargoType;
  }

  void setDriverDesi(double driverDesi) {
    _driverDesi = driverDesi;
  }

  void setDriverPrice(double driverPrice) {
    _driverPrice = driverPrice;
  }
}
