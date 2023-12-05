import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExerciseProvider with ChangeNotifier {
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  Future<bool> getIsAttempted() async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users/${FirebaseAuth.instance.currentUser!.uid}/exercise')
        .doc('${currentDate}')
        .get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      final isAttempted = data['isAttempted'] as bool;
      return isAttempted;
    } else {
      return false; // Return a default value if the document doesn't exist
    }
  }

  Future<int> getScore() async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users/${FirebaseAuth.instance.currentUser!.uid}/exercise')
        .doc('${currentDate}')
        .get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      final isAttempted = data['score'] as int;
      return isAttempted;
    } else {
      return 0; // Return a default value if the document doesn't exist
    }
  }
}
