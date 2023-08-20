// ignore_for_file: file_names, avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers
import 'package:cloud_firestore/cloud_firestore.dart';

class PublishViewModel {
  Future<bool> addJourney({
    required double fromLatitude,
    required double fromLongitude,
    required double toLatitude,
    required double toLongitude,
    required String date,
    required List<String> cargoType,
    required double maxDesi,
    required String driverID,
  }) async {
    try {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;

      await _firestore.collection('journeys').add({
        'fromLatitude': fromLatitude,
        'fromLongitude': fromLongitude,
        'toLatitude': toLatitude,
        'toLongitude': toLongitude,
        'date':
            date, // eğer timestamp olarak saklamak isterseniz: Timestamp.fromDate(date)
        'cargoType': cargoType,
        'maxDesi': maxDesi,
        'driverID': driverID,
      });
      print("✅ PRINT DEBUG ✅ Successfully Added Journey");
      return true;
    } catch (e) {
      print("❌ Error while adding journey: $e");
      return false;
    }
  }
}
