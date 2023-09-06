// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class QRReceiveViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateReservationStatus(
      String reservationID, String userID) async {
    try {
      DocumentReference userDoc = _firestore.collection('users').doc(userID);

      DocumentSnapshot userData = await userDoc.get();
      if (userData.exists) {
        List<dynamic> reservations = userData.get('myReservations') ?? [];

        for (int i = 0; i < reservations.length; i++) {
          if (reservations[i]['journeyID'] == reservationID) {
            reservations[i]['status'] = "Kargo Teslim Alındı";
          }
        }

        await userDoc.update({'myReservations': reservations});
      }

      DocumentReference journeyDoc =
          _firestore.collection('journeys').doc(reservationID);
      DocumentSnapshot journeyData = await journeyDoc.get();

      if (journeyData.exists) {
        Map<String, dynamic> journeyReservations =
            journeyData.get('reservations') ?? [];

        journeyReservations[userID]['status'] = "Kargo Teslim Alındı";

        await journeyDoc.update({'reservations': journeyReservations});
      }
    } catch (e) {
      print('Error updating reservation status: $e');
    }
  }
}
