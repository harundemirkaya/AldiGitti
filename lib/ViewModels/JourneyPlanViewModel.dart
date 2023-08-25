// ignore_for_file: file_names, avoid_print

import 'package:aldigitti/Models/JourneyModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JourneyPlanViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getReservationNames(String journeyID) async {
    List<String> userNames = [];

    DocumentSnapshot journeySnapshot =
        await _firestore.collection('journeys').doc(journeyID).get();

    if (!journeySnapshot.exists) {
      return [];
    }

    Map<String, dynamic> journeyData =
        journeySnapshot.data() as Map<String, dynamic>;
    List<String> userIDs = List<String>.from(journeyData['reservations'] ?? []);

    for (String userID in userIDs) {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(userID).get();
      if (userSnapshot.exists) {
        userNames.add(userSnapshot['name']);
      }
    }

    return userNames;
  }

  Future<Map<bool, String>> deleteJourney(String journeyID) async {
    try {
      var currentUserID = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserID == null) {
        return {false: 'Kullanıcı Bulunamadı.'};
      }

      DocumentSnapshot journeySnapshot =
          await _firestore.collection('journeys').doc(journeyID).get();

      if (!journeySnapshot.exists) {
        return {false: 'Silinmek istenen yolculuk bulunamadı.'};
      }

      await _firestore.collection('journeys').doc(journeyID).delete();

      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(currentUserID).get();

      if (!userSnapshot.exists) {
        return {false: 'Kullanıcı bulunamadı.'};
      }

      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      List<Map<String, dynamic>> myJourneys =
          List<Map<String, dynamic>>.from(userData['myJourneys'] ?? []);

      myJourneys.removeWhere((journey) => journey['journeyId'] == journeyID);

      await _firestore
          .collection('users')
          .doc(currentUserID)
          .update({'myJourneys': myJourneys});

      return {true: 'Yolculuk başarıyla silindi.'};
    } catch (e) {
      return {false: 'Bir hata oluştu: $e'};
    }
  }

  Future<Journey?> fetchJourneyById(String journeyID) async {
    try {
      DocumentSnapshot journeySnapshot =
          await _firestore.collection('journeys').doc(journeyID).get();

      if (!journeySnapshot.exists) {
        return null;
      }

      Map<String, dynamic> journeyData =
          journeySnapshot.data() as Map<String, dynamic>;
      return Journey.fromMap(journeyData);
    } catch (e) {
      print("❌ PRINT DEBUG ❌ $e");
      return null;
    }
  }
}
