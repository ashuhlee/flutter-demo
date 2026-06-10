
import 'package:flutter/material.dart';

import 'package:todo_app/models/note.dart';
import 'package:todo_app/widgets/note_card.dart';

class NoteList extends StatelessWidget {
  const NoteList({
    super.key,
    required this.notes,
    required this.onEdit,
    required this.onDelete
  });

  final List<Note> notes;
  final void Function(Note note) onEdit;
  final void Function(Note note) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index]; // get each note

        return NoteCard( // return as list tile ui
          note: note,
          onEdit: () => onEdit(note),
          onDelete: () => onDelete(note)
        );
      },
    );
  }
}
