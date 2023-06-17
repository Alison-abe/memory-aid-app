import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memory_aid/models/note_model.dart';

class NoteProvider with ChangeNotifier{
  addNote(NoteModel note) {
   final noteId = FirebaseFirestore.instance
        .collection('users/${FirebaseAuth.instance.currentUser!.uid}/notes')
        .doc();
   noteId.set({
      'id':noteId,
      'title':note.title,
      'description':note.description,
   });
   notifyListeners();
  }
}