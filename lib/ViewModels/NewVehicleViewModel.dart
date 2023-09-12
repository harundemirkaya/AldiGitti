// ignore_for_file: file_names

import 'package:aldigitti/Models/VehicleModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewVehicleViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<bool, String>> addVehicle(Vehicle vehicleData) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return {false: "Oturumunuzun Süresi Dolmuş"};
      }
      String userId = user.uid;

      DocumentReference docRef = _firestore.collection('vehicles').doc(userId);

      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        await docRef.update({
          'vehicles': FieldValue.arrayUnion([vehicleData.toJson()]),
        });
      } else {
        await docRef.set({
          'vehicles': [vehicleData.toJson()],
        });
      }

      return {true: ""};
    } catch (error) {
      return {false: "Hata : ${error.toString()}"};
    }
  }
}
