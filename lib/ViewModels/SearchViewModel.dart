// ignore_for_file: file_names, avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers
import 'package:aldigitti/Models/JourneyModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class SearchViewModel {
  Future<List<Journey>> fetchNearbyJourneys(
      double userFromLat,
      double userFromLong,
      double userToLat,
      double userToLong,
      String userDate,
      String userCargoType,
      double userDesi) async {
    double maxDistance = 100;

    QuerySnapshot journeysSnapshot =
        await FirebaseFirestore.instance.collection('journeys').get();

    List<Journey> filteredJourneys = [];

    for (var journey in journeysSnapshot.docs) {
      Map<String, dynamic>? data = journey.data() as Map<String, dynamic>?;
      if (data != null) {
        double fromLat = data['fromLatitude'];
        double fromLong = data['fromLongitude'];
        double toLat = data['toLatitude'];
        double toLong = data['toLongitude'];
        String date = data['date'];
        List<dynamic> cargoType = data['cargoType'];
        double desi = data['maxDesi'];

        print(data);

        if (date == userDate &&
            cargoType.contains(userCargoType) &&
            desi >= userDesi) {
          double distanceFrom = Geolocator.distanceBetween(
                  userFromLat, userFromLong, fromLat, fromLong) /
              1000;
          double distanceTo =
              Geolocator.distanceBetween(userToLat, userToLong, toLat, toLong) /
                  1000;

          if (distanceFrom <= maxDistance && distanceTo <= maxDistance) {
            filteredJourneys.add(Journey.fromMap(data));
          }
        }
      }
    }

    return filteredJourneys;
  }
}
