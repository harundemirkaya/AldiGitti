// ignore_for_file: file_names, use_rethrow_when_possible, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyJourneysViewModel {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchUserReservations() async {
    final currentUserID = FirebaseAuth.instance.currentUser?.uid;

    if (currentUserID == null) {
      return [];
    }
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(currentUserID).get();

      Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
      List<Map<String, dynamic>> reservations =
          List<Map<String, dynamic>>.from(data?['myReservations'] ?? []);

      return reservations;
    } catch (error) {
      print("Error fetching reservations: $error");
      throw error;
    }
  }

  Future<List<Map<String, dynamic>>> fetchUserJourneys() async {
    final currentUserID = FirebaseAuth.instance.currentUser?.uid;

    if (currentUserID == null) {
      return [];
    }

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserID)
        .get();

    Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;

    List<Map<String, dynamic>> journeys =
        List<Map<String, dynamic>>.from(data?['journeys'] ?? []);

    return journeys;
  }
}
