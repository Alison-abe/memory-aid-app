import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class ProfileProvider with ChangeNotifier {
  addProfile(UserProfile user) {
   final profileId = FirebaseFirestore.instance
        .collection('users')
        .doc('${FirebaseAuth.instance.currentUser!.uid}');
   profileId.set({
      'uid':user.uid,
      'age':user.age,
      'phno':user.phNo,
      'ct_name':user.ctname,
      'ct_phno':user.ctphno,
      'ct_email':user.ctemail
   });
  }
}
