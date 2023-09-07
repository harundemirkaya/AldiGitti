// ignore_for_file: file_names

class UserModel {
  final String uid;
  final String? name;
  final String? surname;
  final String? email;
  final String? telephoneNumber;
  final String? gender;
  final String? birthDate;

  UserModel({
    required this.uid,
    this.email,
    this.name,
    this.surname,
    this.telephoneNumber,
    this.gender,
    this.birthDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      surname: json['surname'],
      telephoneNumber: json['telephoneNumber'],
      gender: json['gender'],
      email: json['email'],
      birthDate: json['birthDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'surname': surname,
      'telephoneNumber': telephoneNumber,
      'gender': gender,
      'email': email,
      'birthDate': birthDate,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'surname': surname,
      'gender': gender,
      'email': email,
      'birthDate': birthDate,
      'telephoneNumber': telephoneNumber,
    };
  }
}
