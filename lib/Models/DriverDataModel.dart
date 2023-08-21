// ignore_for_file: prefer_final_fields, file_names

class DriverDataModel {
  String _driverFromName;
  double _driverFromLat;
  double _driverFromLong;

  String _driverToName;
  double _driverToLat;
  double _driverToLong;

  String _driverDate;
  List<String> _driverCargoType;
  double _driverDesi;
  double _driverPrice;

  String _driverDepartureTime;
  String _driverArrivalTime;

  DriverDataModel({
    required String driverFromName,
    required double driverFromLat,
    required double driverFromLong,
    required String driverToName,
    required double driverToLat,
    required double driverToLong,
    required String driverDate,
    required List<String> driverCargoType,
    required double driverDesi,
    required double driverPrice,
    required String driverDepartureTime,
    required String driverArrivalTime,
  })  : _driverFromName = driverFromName,
        _driverFromLat = driverFromLat,
        _driverFromLong = driverFromLong,
        _driverToName = driverToName,
        _driverToLat = driverToLat,
        _driverToLong = driverToLong,
        _driverDate = driverDate,
        _driverCargoType = driverCargoType,
        _driverDesi = driverDesi,
        _driverPrice = driverPrice,
        _driverDepartureTime = driverDepartureTime,
        _driverArrivalTime = driverArrivalTime;

  String get driverFromName => _driverFromName;
  double get driverFromLat => _driverFromLat;
  double get driverFromLong => _driverFromLong;

  String get driverToName => _driverToName;
  double get driverToLat => _driverToLat;
  double get driverToLong => _driverToLong;

  String get driverDate => _driverDate;
  List<String> get driverCargoType => _driverCargoType;
  double get driverDesi => _driverDesi;
  double get driverPrice => _driverPrice;

  String get driverDepartureTime => _driverDepartureTime;
  String get driverArrivalTime => _driverArrivalTime;

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

  void setDriverCargoType(List<String> cargoType) {
    _driverCargoType = cargoType;
  }

  void setDriverDesi(double driverDesi) {
    _driverDesi = driverDesi;
  }

  void setDriverPrice(double driverPrice) {
    _driverPrice = driverPrice;
  }

  void setDriverDepartureTime(String driverDepartureTime) {
    _driverDepartureTime = driverDepartureTime;
  }

  void setDriverArrivalTime(String driverArrivalTime) {
    _driverArrivalTime = driverArrivalTime;
  }
}
