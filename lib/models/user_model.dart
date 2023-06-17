import 'package:flutter/material.dart';

class UserProfile with ChangeNotifier {
  final String uid;
  final String age;
  final String phNo;
  final String ctname;
  final String ctphno;
  final String ctemail;
  UserProfile(
      {required this.uid,
      required this.age,
      required this.phNo,
      required this.ctname,
      required this.ctphno,
      required this.ctemail,
      });
}
