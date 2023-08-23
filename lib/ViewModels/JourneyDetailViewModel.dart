// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JourneyDetailViewModel {
  Future<bool> addReservation(String journeyID) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      try {
        DocumentReference journeyRef =
            _firestore.collection('journeys').doc(journeyID);

        DocumentSnapshot journeySnapshot = await journeyRef.get();

        if (!journeySnapshot.exists) {
          print("❌ Belge bulunamadı");
          return false;
        }

        List<String> reservations = [];
        var data = journeySnapshot.data();
        if (data is Map<String, dynamic>) {
          if (data.containsKey('reservations')) {
            reservations = List<String>.from(data['reservations'] as List);
          }
        }

        if (!reservations.contains(uid)) {
          reservations.add(uid);
        } else {
          print(
              "⚠️ PRINT DEBUG ⚠️ UID already exists in the reservations list");
          return false;
        }
        await journeyRef
            .set({'reservations': reservations}, SetOptions(merge: true));

        print("✅ PRINT DEBUG ✅ Reservation successfully added or updated");
        return true;
      } catch (e) {
        print("❌ Error while adding journey: $e");
        return false;
      }
    }
    return false;
  }
}
