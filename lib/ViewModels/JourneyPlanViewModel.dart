// ignore_for_file: file_names, avoid_print

import 'package:aldigitti/Models/JourneyModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JourneyPlanViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, String>> getReservationNamesWithUIDs(
      String journeyID) async {
    Map<String, String> userNamesWithUIDs = {};

    DocumentSnapshot journeySnapshot =
        await _firestore.collection('journeys').doc(journeyID).get();

    if (!journeySnapshot.exists) {
      return {};
    }

    Map<String, dynamic> journeyData =
        journeySnapshot.data() as Map<String, dynamic>;

    List<String> userIDs =
        List<String>.from(journeyData['reservations']?.keys ?? []);

    for (String userID in userIDs) {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(userID).get();
      if (userSnapshot.exists) {
        userNamesWithUIDs[userID] = userSnapshot['name'];
      }
    }

    return userNamesWithUIDs;
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

      Map<String, dynamic> journeyData =
          journeySnapshot.data() as Map<String, dynamic>;

      List<Map<String, dynamic>> reservations = journeyData['reservations']
          .values
          .toList()
          .cast<Map<String, dynamic>>();

      for (String reservationUserID in journeyData['reservations'].keys) {
        DocumentSnapshot userSnapshot =
            await _firestore.collection('users').doc(reservationUserID).get();

        if (userSnapshot.exists) {
          List<Map<String, dynamic>> userReservations =
              List<Map<String, dynamic>>.from(
                  userSnapshot.get('myReservations') ?? []);

          for (var reservation in userReservations) {
            if (reservation['journeyID'] == journeyID) {
              reservation['status'] = 'Yolculuk İptal Edildi';
            }
          }

          await _firestore
              .collection('users')
              .doc(reservationUserID)
              .update({'myReservations': userReservations});
        }
      }

      bool allConfirmed = true;
      for (var reservation in reservations) {
        if (reservation['status'] != "Onaylandı") {
          allConfirmed = false;
          break;
        }
      }

      if (!allConfirmed) {
        return {
          false:
              'Teslim Aldığınız Kargolar Bulunduğundan Dolayı Yolculuk Silinemez'
        };
      }

      DocumentSnapshot currentUserSnapshot =
          await _firestore.collection('users').doc(currentUserID).get();

      if (!currentUserSnapshot.exists) {
        return {false: 'Kullanıcı bulunamadı.'};
      }

      Map<String, dynamic> currentUserData =
          currentUserSnapshot.data() as Map<String, dynamic>;

      List<Map<String, dynamic>> myJourneys =
          List<Map<String, dynamic>>.from(currentUserData['myJourneys'] ?? []);

      Map<String, dynamic>? targetJourney;
      for (var journey in myJourneys) {
        if (journey['journeyId'] == journeyID) {
          targetJourney = journey;
          break;
        }
      }

      if (targetJourney == null) {
        return {false: 'Aradığınız yolculuk bulunamadı.'};
      }

      List<String> reservationInvitations =
          List<String>.from(targetJourney['reservationInvitations'] ?? []);

      List<String> allAffectedUsers = reservationInvitations;

      for (String affectedUserId in allAffectedUsers) {
        DocumentSnapshot userSnapshot =
            await _firestore.collection('users').doc(affectedUserId).get();

        if (userSnapshot.exists) {
          List<Map<String, dynamic>> userReservations =
              List<Map<String, dynamic>>.from(
                  userSnapshot.get('myReservations') ?? []);

          for (var reservation in userReservations) {
            if (reservation['journeyID'] == journeyID) {
              reservation['status'] = 'Yolculuk İptal Edildi';
            }
          }

          await _firestore
              .collection('users')
              .doc(affectedUserId)
              .update({'myReservations': userReservations});
        }
      }

      await _firestore.collection('journeys').doc(journeyID).delete();

      myJourneys.remove(targetJourney);
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

  Future<bool> removeUserFromJourneyReservations(
      String journeyID, String userID) async {
    try {
      DocumentReference journeyRef =
          _firestore.collection('journeys').doc(journeyID);
      DocumentSnapshot journeySnapshot = await journeyRef.get();

      if (!journeySnapshot.exists) {
        print("❌ PRINT DEBUG ❌ Journey ID ile eşleşen yolculuk bulunamadı.");
        return false;
      }

      Map<String, dynamic> journeyData =
          journeySnapshot.data() as Map<String, dynamic>;
      List<String> reservations =
          List<String>.from(journeyData['reservations'] ?? []);

      if (!reservations.remove(userID)) {
        print(
            "❌ PRINT DEBUG ❌ Belirtilen kullanıcı yolculuk rezervasyonlarında bulunamadı.");
        return false;
      }

      await journeyRef.update({'reservations': reservations});

      DocumentReference userRef = _firestore.collection('users').doc(userID);
      DocumentSnapshot userSnapshot = await userRef.get();

      if (!userSnapshot.exists) {
        print("❌ PRINT DEBUG ❌ User ID ile eşleşen kullanıcı bulunamadı.");
        return false;
      }

      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      List<Map<String, dynamic>> userReservations =
          List<Map<String, dynamic>>.from(userData['myReservations'] ?? []);

      for (Map<String, dynamic> reservation in userReservations) {
        if (reservation['journeyID'] == journeyID) {
          reservation['status'] = "İptal Edildi";
          break;
        }
      }

      await userRef.update({'myReservations': userReservations});

      return true;
    } catch (e) {
      print("❌ PRINT DEBUG ❌ $e");
      return false;
    }
  }

  Future<Map<bool, String>> deleteReservation(String journeyID) async {
    try {
      var currentUserID = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserID == null) {
        print("❌ PRINT DEBUG ❌ Oturum açmış kullanıcı bulunamadı.");
        return {false: "Kullanıcı Bulunamadı"};
      }

      DocumentSnapshot journeySnapshot =
          await _firestore.collection('journeys').doc(journeyID).get();

      if (!journeySnapshot.exists) {
        print(
            "❌ PRINT DEBUG ❌ Belirtilen ID ile yolculuk bulunamadı. $journeyID");
        return {false: "Yolculuk Bulunamadı"};
      }

      Map<String, dynamic> journeyData =
          journeySnapshot.data() as Map<String, dynamic>;
      if (journeyData['status'] == 'İptal Edildi') {
        print("❌ PRINT DEBUG ❌ Bu yolculuk zaten iptal edilmiş.");
        return {false: "Bu yolculuk zaten iptal edilmiş."};
      }

      if (journeyData['reservations'][currentUserID]['status'] ==
              'Kargo Teslim Alındı' ||
          journeyData['reservations'][currentUserID]['status'] ==
              'Kargo Yola Çıktı' ||
          journeyData['reservations'][currentUserID]['status'] ==
              'Kargo Teslim Edildi') {
        print(
            "❌ PRINT DEBUG ❌ Kargo Teslim Alındıktan Sonra Rezervasyon İptal Edilemez.");
        return {
          false: "Kargo Teslim Alındıktan Sonra Rezervasyon İptal Edilemez."
        };
      }

      String driverID =
          (journeySnapshot.data() as Map<String, dynamic>)['driverID'] ?? "";

      if (driverID.isEmpty) {
        print("❌ PRINT DEBUG ❌ Yolculukta sürücü ID'si bulunamadı.");
        return {false: "Yolculukta sürücü bulunamadı."};
      }

      DocumentReference currentUserRef =
          _firestore.collection('users').doc(currentUserID);
      DocumentSnapshot currentUserSnapshot = await currentUserRef.get();

      if (currentUserSnapshot.exists) {
        Map<String, dynamic> currentUserData =
            currentUserSnapshot.data() as Map<String, dynamic>;
        List<Map<String, dynamic>> currentUserJourneys =
            List<Map<String, dynamic>>.from(
                currentUserData['myReservations'] ?? []);

        currentUserJourneys
            .removeWhere((journey) => journey['journeyID'] == journeyID);

        await currentUserRef.update({'myReservations': currentUserJourneys});
      }

      DocumentReference driverRef =
          _firestore.collection('users').doc(driverID);
      DocumentSnapshot driverSnapshot = await driverRef.get();

      if (driverSnapshot.exists) {
        DocumentReference journeyRef =
            _firestore.collection('journeys').doc(journeyID);
        DocumentSnapshot journeyUpdateSnapshot = await journeyRef.get();

        if (journeyUpdateSnapshot.exists) {
          Map<String, dynamic> journeyData =
              journeyUpdateSnapshot.data() as Map<String, dynamic>;
          Map<String, dynamic> reservationsList =
              Map<String, dynamic>.from(journeyData['reservations'] ?? []);

          reservationsList.remove(currentUserID);

          await journeyRef.update({'reservations': reservationsList});
        }
        Map<String, dynamic> driverData =
            driverSnapshot.data() as Map<String, dynamic>;
        List<Map<String, dynamic>> driverJourneys =
            List<Map<String, dynamic>>.from(driverData['myJourneys'] ?? []);

        for (Map<String, dynamic> journey in driverJourneys) {
          if (journey['journeyId'] == journeyID &&
              journey.containsKey('reservationInvitations')) {
            List<String> reservations =
                List<String>.from(journey['reservationInvitations']);
            reservations.remove(currentUserID);
            journey['reservationInvitations'] = reservations;
            break;
          }
        }

        await driverRef.update({'myJourneys': driverJourneys});
      }

      return {true: ""};
    } catch (e) {
      print("❌ PRINT DEBUG ❌ $e");
      return {false: e.toString()};
    }
  }

  Future<Map<bool, String>> startJourney(String journeyID) async {
    try {
      DocumentSnapshot journeySnapshot =
          await _firestore.collection('journeys').doc(journeyID).get();

      if (!journeySnapshot.exists) {
        print("❌ PRINT DEBUG ❌ Journey not found.");
        return {false: "Yolculuk Bulunamadı."};
      }

      Map<String, dynamic> journeyData =
          journeySnapshot.data() as Map<String, dynamic>;

      Map<String, dynamic> reservationsMap =
          Map<String, dynamic>.from(journeyData['reservations'] ?? {});

      for (String userID in reservationsMap.keys) {
        if (reservationsMap[userID]['status'] != "Kargo Teslim Alındı") {
          print("❌ PRINT DEBUG ❌ Not all packages have been received.");
          return {
            false:
                "Yolculuğa Başlamak İçin Rezervasyonlarınızdaki Tüm Kargoları Teslim Almalısınız."
          };
        }
      }

      for (String userID in reservationsMap.keys) {
        DocumentSnapshot userSnapshot =
            await _firestore.collection('users').doc(userID).get();

        if (userSnapshot.exists) {
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;

          List<Map<String, dynamic>> userReservations =
              List<Map<String, dynamic>>.from(userData['myReservations'] ?? []);

          for (Map<String, dynamic> reservation in userReservations) {
            if (reservation['journeyID'] == journeyID) {
              reservation['status'] = "Kargo Yola Çıktı";
            }
          }

          await _firestore
              .collection('users')
              .doc(userID)
              .update({'myReservations': userReservations});

          reservationsMap[userID]['status'] = "Kargo Yola Çıktı";
        }
      }

      await _firestore.collection('journeys').doc(journeyID).update({
        'reservations': reservationsMap,
        'status': "Kargo Yola Çıktı",
      });

      print("✅ PRINT DEBUG ✅ Journey has started successfully.");
      return {true: "Yolculuk Başarıyla Başlatıldı."};
    } catch (e) {
      print("❌ PRINT DEBUG ❌ $e");
      return {false: e.toString()};
    }
  }

  Future<bool> checkJourneyStatus(String journeyID) async {
    try {
      DocumentSnapshot journeySnapshot =
          await _firestore.collection('journeys').doc(journeyID).get();

      if (!journeySnapshot.exists) {
        print("❌ PRINT DEBUG ❌ Journey not found.");
        return false;
      }

      Map<String, dynamic> journeyData =
          journeySnapshot.data() as Map<String, dynamic>;

      if (journeyData.containsKey('status') &&
          journeyData['status'] == "Kargo Yola Çıktı") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("❌ PRINT DEBUG ❌ $e");
      return false;
    }
  }
}
