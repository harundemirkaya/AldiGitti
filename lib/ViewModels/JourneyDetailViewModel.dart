// ignore_for_file: file_names, avoid_print, iterable_contains_unrelated_type

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JourneyDetailViewModel {
  Future<List<dynamic>> addReservation(String journeyID) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    String date = "";
    String fromName = "";
    String toName = "";

    var uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) return [false, "Unknown Error"];

    DocumentReference journeyRef =
        firestore.collection('journeys').doc(journeyID);
    DocumentSnapshot journeySnapshot = await journeyRef.get();

    if (!journeySnapshot.exists) {
      print("❌ PRINT DEBUG ❌ Belge bulunamadı");
      return [false, "Yolculuk Başladı ya da İptal Edildi."];
    }

    List<String> reservations = [];
    String driverID = "";
    var journeyData = journeySnapshot.data();

    if (journeyData is Map<String, dynamic>) {
      date = journeyData['date'];
      fromName = journeyData['fromName'];
      toName = journeyData['toName'];
      driverID = journeyData['driverID'];
      if (journeyData.containsKey('reservations')) {
        reservations = List<String>.from(journeyData['reservations'] as List);
      }
    }

    if (driverID == uid) {
      print("❌ PRINT DEBUG ❌ Sürücü kendi yolculuğuna rezervasyon yapamaz");
      return [false, "Sürücü kendi yolculuğuna rezervasyon yapamaz"];
    }

    if (!reservations.contains(uid)) {
      reservations.add(uid);
      await journeyRef
          .set({'reservations': reservations}, SetOptions(merge: true));

      DocumentReference driverRef = firestore.collection('users').doc(driverID);
      DocumentSnapshot driverSnapshot = await driverRef.get();

      if (driverSnapshot.exists) {
        var driverData = driverSnapshot.data();
        List<Map<String, dynamic>> driverJourneys = [];

        if (driverData is Map<String, dynamic>) {
          if (driverData.containsKey('myJourneys')) {
            driverJourneys = List<Map<String, dynamic>>.from(
                driverData['myJourneys'] as List);
          }

          var matchedJourney = driverJourneys
              .firstWhere((journey) => journey['journeyId'] == journeyID);
          if (!matchedJourney.containsKey('reservations')) {
            matchedJourney['reservations'] = [];
          }
          matchedJourney['reservations'].add(uid);
          await driverRef
              .set({'myJourneys': driverJourneys}, SetOptions(merge: true));
        }
      }
    } else {
      print("❌ PRINT DEBUG ❌ UID zaten reservations listesinde var");
      return [false, "Bu yolculuğa zaten rezervasyon yaptınız."];
    }

    DocumentReference userRef = firestore.collection('users').doc(uid);
    DocumentSnapshot userSnapshot = await userRef.get();

    if (!userSnapshot.exists) {
      print("❌ PRINT DEBUG ❌ Kullanıcı belgesi bulunamadı");
      return [false, "Kullanıcı Bulunamadı"];
    }

    List<Map<String, dynamic>> myReservations = [];
    var userData = userSnapshot.data();

    if (userData is Map<String, dynamic>) {
      if (userData.containsKey('myReservations')) {
        myReservations =
            List<Map<String, dynamic>>.from(userData['myReservations'] as List);
      }
    }

    if (myReservations.contains(journeyID)) {
      print("❌ PRINT DEBUG ❌ Reservation Already Exists");
      return [false, "Bu yolculuğa zaten rezervasyon yaptınız."];
    } else {
      Map<String, dynamic> newReservation = {
        'journeyID': journeyID,
        'date': date,
        'fromName': fromName,
        'toName': toName,
        'status': "Onay Bekliyor",
      };
      myReservations.add(newReservation);

      await userRef
          .set({'myReservations': myReservations}, SetOptions(merge: true));
    }

    print("✅ PRINT DEBUG ✅ Rezervasyon başarıyla eklendi veya güncellendi");
    return [true, "success"];
  }

  Future<List<dynamic>> driverUserIsCurrentUserControl(String journeyID) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return [false, "Unknown Error"];
    DocumentReference journeyRef =
        firestore.collection('journeys').doc(journeyID);
    DocumentSnapshot journeySnapshot = await journeyRef.get();

    if (!journeySnapshot.exists) {
      print("❌ PRINT DEBUG ❌ Belge bulunamadı");
      return [false, "Yolculuk Başladı ya da İptal Edildi."];
    }

    String driverID = "";
    var journeyData = journeySnapshot.data();

    if (journeyData is Map<String, dynamic>) {
      driverID = journeyData['driverID'];
    }

    if (driverID == uid) {
      print("❌ PRINT DEBUG ❌ Kendinize Mesaj Gönderemezsiniz");
      return [false, "Kendinize Mesaj Gönderemezsiniz"];
    }

    return [true, "success"];
  }
}
