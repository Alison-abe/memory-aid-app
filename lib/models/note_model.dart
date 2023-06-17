import 'package:flutter/material.dart';

class NoteModel with ChangeNotifier{
  String id='';
  final String title;
  final String description;
  NoteModel({required this.title,required this.description});
}