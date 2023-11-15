import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memory_aid/models/note_model.dart';
import 'package:memory_aid/widget/add_note_dialog.dart';
import 'package:memory_aid/widget/noteTile.dart';

import '../../widget/appbar_decoration.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final collection = FirebaseFirestore.instance
        .collection('users/${FirebaseAuth.instance.currentUser!.uid}/notes');
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.of(context).push(
            //     MaterialPageRoute(builder: (context) => const AddNoteDialog()));
            showDialog(context: context, builder: (BuildContext context){
              return const AddNoteDialog();
            });
            
          },
          backgroundColor: theme.colorScheme.secondary,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          //backgroundColor: theme.colorScheme.secondary,
          toolbarHeight: 70,
                  flexibleSpace:const AppbarDecoration(),
          centerTitle: true,
          title:  Text(
            'Notes',
            style: TextStyle(color: theme.colorScheme.tertiary, fontSize: 20,fontWeight: FontWeight.w500),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 10,),
            child: StreamBuilder<QuerySnapshot>(
              stream: collection.snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error = ${snapshot.error}');
                }
                if (snapshot.hasData) {
                  List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10,top: 20,),
                            child: NotesTile(
                                note: NoteModel(
                                    title: documents[index].get('title'),
                                    description:
                                        documents[index].get('description'))));
                      });
                }

                return const Center(child: CircularProgressIndicator());
              },
            )),
      ),
    );
  }
}
