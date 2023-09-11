class Vehicle {
  String? id;
  String? brand;
  String? model;
  String? plate;
  int? year;
  String? policyUrl;
  String? driveLicenceUrl;
  String? permitUrl;
  String? status;

  Vehicle({
    this.id,
    this.brand,
    this.model,
    this.plate,
    this.year,
    this.policyUrl,
    this.driveLicenceUrl,
    this.permitUrl,
    this.status,
  });

  Vehicle.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        brand = json['brand'],
        model = json['model'],
        plate = json['plate'],
        year = json['year'],
        policyUrl = json['policyUrl'],
        driveLicenceUrl = json['driveLicenceUrl'],
        permitUrl = json['permitUrl'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'brand': brand,
        'model': model,
        'plate': plate,
        'year': year,
        'policyUrl': policyUrl,
        'driveLicenceUrl': driveLicenceUrl,
        'permitUrl': permitUrl,
        'status': status,
      };
}
