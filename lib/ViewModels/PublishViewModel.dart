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

        await _firestore.collection('journeys').add({
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
        print("✅ PRINT DEBUG ✅ Successfully Added Journey");
        return true;
      } catch (e) {
        print("❌ Error while adding journey: $e");
        return false;
      }
    }
    return false;
  }
}
