// ignore_for_file: file_names, avoid_print

import 'package:aldigitti/Models/VehicleModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyVehiclesViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Vehicle>?> getUserVehicles() async {
    User? user = _auth.currentUser;

    if (user == null) {
      return null;
    }

    try {
      CollectionReference vehicles = _firestore.collection('vehicles');
      DocumentSnapshot userVehiclesDoc = await vehicles.doc(user.uid).get();

      if (userVehiclesDoc.exists) {
        var data = userVehiclesDoc.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('vehicles')) {
          List<dynamic> vehiclesListDynamic = data['vehicles'] as List<dynamic>;
          List<Vehicle> vehiclesList = vehiclesListDynamic.map((v) {
            return Vehicle.fromJson(v as Map<String, dynamic>);
          }).toList();
          return vehiclesList;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
