import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memory_aid/models/note_model.dart';
import 'package:memory_aid/provider/note_provider.dart';
import 'package:memory_aid/widget/textField.dart';
import 'package:provider/provider.dart';

class AddNoteDialog extends StatelessWidget {
  const AddNoteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController notetitle = TextEditingController();
    TextEditingController noteDesc = TextEditingController();
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "New Note",
                style: GoogleFonts.manrope(),
              ),
              const SizedBox(
                height: 20,
              ),
              Textfield(controller: notetitle, label: 'Title'),
              const SizedBox(
                height: 20,
              ),
              Textfield(controller: noteDesc, label: 'Description'),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary, // Set the background color
                  ),
                  onPressed: () {
                    Provider.of<NoteProvider>(context, listen: false).addNote(
                        NoteModel(
                            title: notetitle.text, description: noteDesc.text));
                    Navigator.of(context).pop();
                  },
                  child:  Text('Add Note',
                  style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
