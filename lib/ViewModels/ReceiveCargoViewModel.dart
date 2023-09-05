// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class ReceiveCargoViewModel {
  final _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> fetchReservationDetails(
      String userID, String journeyID) async {
    try {
      DocumentSnapshot journeyDoc =
          await _firestore.collection('journeys').doc(journeyID).get();

      if (!journeyDoc.exists) {
        print("❌ PRINT DEBUG ❌ journeyID $journeyID bulunamadı.");
        return null;
      }

      Map<String, dynamic> journeyData =
          journeyDoc.data() as Map<String, dynamic>;

      if (!journeyData.containsKey('reservations') ||
          journeyData['reservations'] is! Map<String, dynamic>) {
        print(
            "❌ PRINT DEBUG ❌ reservations haritası journeyID $journeyID içerisinde bulunamadı veya beklenen formatta değil.");
        return null;
      }

      Map<String, dynamic> reservations =
          journeyData['reservations'] as Map<String, dynamic>;

      if (!reservations.containsKey(userID)) {
        print(
            "❌ PRINT DEBUG ❌ userID $userID için rezervasyon journeyID $journeyID içerisinde bulunamadı.");
        return null;
      }

      return reservations[userID];
    } catch (e) {
      print("❌ PRINT DEBUG ❌ fetchReservationDetails fonksiyonunda hata: $e");
      return null;
    }
  }
}
