// ignore_for_file: file_names

class Journey {
  final List<String> cargoType;
  final double fromLatitude;
  final String fromName, toName;
  final double toLongitude;
  final String date;
  final double maxDesi;
  final double fromLongitude;
  final String driverID;
  final String driverName;
  final double toLatitude;
  final double price;
  final String departureTime;
  final String arrivalTime;
  final String journeyId;

  Journey({
    required this.cargoType,
    required this.fromLatitude,
    required this.fromName,
    required this.toName,
    required this.toLongitude,
    required this.date,
    required this.maxDesi,
    required this.fromLongitude,
    required this.driverID,
    required this.driverName,
    required this.toLatitude,
    required this.departureTime,
    required this.arrivalTime,
    required this.journeyId,
    this.price = 0.0,
  });

  factory Journey.fromMap(Map<String, dynamic> data) {
    return Journey(
      cargoType: (data['cargoType'] != null)
          ? List<String>.from(data['cargoType'])
          : [],
      fromLatitude: data['fromLatitude'] ?? 0.0,
      fromName: data['fromName'] ?? '',
      toName: data['toName'] ?? '',
      toLongitude: data['toLongitude'] ?? 0.0,
      date: data['date'] ?? '',
      maxDesi: data['maxDesi'] ?? 0.0,
      fromLongitude: data['fromLongitude'] ?? 0.0,
      driverID: data['driverID'] ?? '',
      driverName: data['driverName'] ?? '',
      toLatitude: data['toLatitude'] ?? 0.0,
      price: data['price'] ?? 0.0,
      departureTime: data['departureTime'] ?? '',
      arrivalTime: data['arrivalTime'] ?? '',
      journeyId: data['journeyId'] ?? '',
    );
  }
}
