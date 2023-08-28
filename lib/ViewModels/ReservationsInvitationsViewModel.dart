// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReservationsInvitationsViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<bool, List<dynamic>>> fetchNamesFromUIDs(
      List<dynamic> reservationInvitations) async {
    List<dynamic> namesOrErrors = [];

    for (var uid in reservationInvitations) {
      try {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(uid).get();
        if (userDoc.exists) {
          String? name = userDoc.get('name') as String?;
          if (name != null) {
            namesOrErrors.add(name);
            print("✅ PRINT DEBUG ✅ UID $uid için name değeri $name.");
            return {true: namesOrErrors};
          } else {
            print('❌ PRINT DEBUG ❌ UID $uid için name değeri null.');
          }
        } else {
          print('❌ PRINT DEBUG ❌ UID $uid bulunamadı.');
        }
      } catch (e) {
        print('❌ PRINT DEBUG ❌ UID $uid için sorgulama sırasında hata: $e');
      }
    }

    return {false: namesOrErrors};
  }

  Future<void> addReservationToJourney(
      String journeyID, String reservation) async {
    try {
      DocumentReference journeyRef =
          _firestore.collection('journeys').doc(journeyID);

      DocumentSnapshot journeyDoc = await journeyRef.get();
      Map<String, dynamic> journeyData =
          journeyDoc.data() as Map<String, dynamic>; // Bu satırı ekledik

      if (journeyDoc.exists) {
        List<dynamic> reservations = [];

        if (journeyData.containsKey('reservations')) {
          reservations = journeyData['reservations'] as List<dynamic>;
        }

        if (!reservations.contains(reservation)) {
          reservations.add(reservation);

          await journeyRef.update({'reservations': reservations});
          print(
              "✅ PRINT DEBUG ✅ journeyID $journeyID için reservations'a $reservation eklendi.");
        } else {
          print(
              "ℹ️ PRINT DEBUG ℹ️ journeyID $journeyID için reservations zaten $reservation içeriyor.");
        }
      } else {
        print('❌ PRINT DEBUG ❌ journeyID $journeyID bulunamadı.');
      }
    } catch (e) {
      print(
          '❌ PRINT DEBUG ❌ journeyID $journeyID için sorgulama sırasında hata: $e');
    }
  }

  Future<void> removeReservationUserIDFromUserJourneys(
      String journeyID, String reservationUserID) async {
    try {
      var currentUserID = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserID == null) {
        return;
      }

      DocumentReference userRef =
          _firestore.collection('users').doc(currentUserID);

      DocumentSnapshot userDoc = await userRef.get();

      if (userDoc.exists) {
        List<dynamic> myJourneys =
            userDoc.get('myJourneys') as List<dynamic>? ?? [];

        bool hasChanges = false;

        for (var journey in myJourneys) {
          if (journey['journeyId'] == journeyID) {
            List<dynamic> reservationInvitations =
                journey['reservationInvitations'] as List<dynamic>? ?? [];
            if (reservationInvitations.contains(reservationUserID)) {
              reservationInvitations.remove(reservationUserID);
              journey['reservationInvitations'] = reservationInvitations;
              hasChanges = true;
            }
          }
        }

        if (hasChanges) {
          await userRef.update({'myJourneys': myJourneys});
          print(
              "✅ PRINT DEBUG ✅ journeyID $journeyID için reservationInvitations'dan $reservationUserID silindi.");
        }
      } else {
        print('❌ PRINT DEBUG ❌ currentUserID $currentUserID bulunamadı.');
      }
    } catch (e) {
      print('❌ PRINT DEBUG ❌ currentUserID için sorgulama sırasında hata: $e');
    }
  }
}
