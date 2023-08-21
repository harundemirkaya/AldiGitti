// ignore_for_file: file_names, avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class SearchViewModel {
  Future<List<DocumentSnapshot>> fetchNearbyJourneys(
      double userLat, double userLong) async {
    double maxDistance = 100;

    QuerySnapshot journeysSnapshot =
        await FirebaseFirestore.instance.collection('journeys').get();

    List<DocumentSnapshot> filteredJourneys = [];

    for (var journey in journeysSnapshot.docs) {
      double fromLat = journey['fromLatitude'];
      double fromLong = journey['fromLongitude'];

      double distance =
          Geolocator.distanceBetween(userLat, userLong, fromLat, fromLong) /
              1000;

      if (distance <= maxDistance) {
        filteredJourneys.add(journey);
      }
    }

    return filteredJourneys;
  }
}
