// ignore_for_file: file_names, avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PublishViewModel {
  Future<bool> addJourney({
    required double fromLatitude,
    required double fromLongitude,
    required String fromName,
    required double toLatitude,
    required double toLongitude,
    required String toName,
    required String date,
    required List<String> cargoType,
    required double maxDesi,
    required double price,
    required String departureTime,
    required String arrivalTime,
  }) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var driverUID = FirebaseAuth.instance.currentUser?.uid;
    if (driverUID != null) {
      try {
        DocumentSnapshot userDocument =
            await _firestore.collection('users').doc(driverUID).get();
        String driverName = userDocument['name'] ?? '';

        DocumentReference journeyRef = _firestore.collection('journeys').doc();

        String journeyId = journeyRef.id;

        await journeyRef.set({
          'journeyId': journeyId,
          'fromLatitude': fromLatitude,
          'fromLongitude': fromLongitude,
          'fromName': fromName,
          'toLatitude': toLatitude,
          'toLongitude': toLongitude,
          'toName': toName,
          'date': date,
          'cargoType': cargoType,
          'maxDesi': maxDesi,
          'driverID': driverUID,
          'driverName': driverName,
          'price': price,
          'departureTime': departureTime,
          'arrivalTime': arrivalTime,
        });

        await _firestore.collection('users').doc(driverUID).update({
          'myJourneys': FieldValue.arrayUnion([
            {
              'journeyId': journeyId,
              'fromName': fromName,
              'toName': toName,
              'date': date
            }
          ])
        });

        print("✅ PRINT DEBUG ✅ Successfully Added Journey with ID: $journeyId");
        return true;
      } catch (e) {
        print("❌ Error while adding journey: $e");
        return false;
      }
    }
    return false;
  }

  Future<bool> checkForApprovedVehicle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    User? currentUser = auth.currentUser;

    if (currentUser != null) {
      String currentUserId = currentUser.uid;

      try {
        DocumentSnapshot vehicleDoc =
            await firestore.collection('vehicles').doc(currentUserId).get();

        if (vehicleDoc.exists) {
          List vehicles = vehicleDoc['vehicles'] ?? [];

          for (var vehicle in vehicles) {
            if (vehicle['status'] == 'Onaylı Araç') {
              return true;
            }
          }
        }
      } catch (e) {
        print("❌ Error while checking for approved vehicle: $e");
        return false;
      }
    }

    return false;
  }
}
