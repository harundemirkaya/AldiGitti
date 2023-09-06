// ignore_for_file: file_names, prefer_const_constructors

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeliverCargoViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late StreamSubscription<DocumentSnapshot> _subscription;

  Future<void> listenToReservationStatus(
      String journeyID, BuildContext context) async {
    final currentUserID = _auth.currentUser?.uid;

    if (currentUserID == null) return;

    final userDoc = _firestore.collection('users').doc(currentUserID);

    _subscription = userDoc.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        final reservations =
            snapshot.data()?['myReservations'] as List<dynamic>?;
        if (reservations != null) {
          final reservation = reservations.firstWhere(
              (reservation) => reservation['journeyID'] == journeyID,
              orElse: () => {});

          if (reservation.isNotEmpty &&
              reservation['status'] == "Kargo Teslim Alındı") {
            stopListening();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Kargo Teslim Alındı"),
                  content: Text("Kargo Başarıyla Teslim Alındı"),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Tamam'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
      }
    });
  }

  void stopListening() {
    _subscription.cancel();
  }
}
