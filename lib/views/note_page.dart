import 'package:flutter/material.dart';

import 'package:todo_app/services/note_database.dart';
import 'package:todo_app/models/note.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/widgets/app_bar.dart';
import 'package:todo_app/widgets/create_note_btn.dart';
import 'package:todo_app/widgets/delete_note_dialog.dart';
import 'package:todo_app/widgets/note_dialog.dart';
import 'package:todo_app/widgets/note_list.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  // notes database + text controllers
  final notesDatabase = NoteDatabase();
  final noteController = TextEditingController();
  final searchController = TextEditingController();

  void addNewNote() {
    showDialog(
      context: context,
      builder: (context) => NoteFormDialog(
        title: 'New Note',
        controller: noteController,
        onSave: () {
          final newNote = Note(
            content: noteController.text,
            createdAt: '',
            updatedAt: null,
          );
          notesDatabase.createNote(newNote);
          Navigator.pop(context);
          noteController.clear();
        },
      ),
    );
  }

  void updateNote(Note note) {
    noteController.text =
        note.content; // prefill text controller w existing note

    showDialog(
      context: context,
      builder: (context) => NoteFormDialog(
        title: 'Update Note',
        controller: noteController,
        onSave: () {
          notesDatabase.updateNote(note, noteController.text);
          Navigator.pop(context);
          noteController.clear();
        },
      ),
    );
  }

  void deleteNote(Note note) {
    showDialog(
      context: context,
      builder: (context) => DeleteFormDialog(
        onDelete: () {
          notesDatabase.deleteNote(note);
          Navigator.pop(context);
        },
      ),
    );
  }

  List<Note> filterNotes(List<Note> notes) {
    final query = searchController.text.toLowerCase();
    return notes
        .where((note) => note.content.toLowerCase().contains(query))
        .toList();
  }

  @override
  void dispose() {
    noteController.dispose();
    searchController.dispose();
    super.dispose();
  }

  Widget buildLoadedNotes(List<Note> allNotes) {
    final notes = filterNotes(allNotes);

    return Scaffold(
      appBar: NoteAppBar(
        noteCount: allNotes.length,
        searchController: searchController,
        onSearchChanged: ((value) {
          setState(() {});
        }),
      ),
      floatingActionButton: CreateNoteButton(onPressed: addNewNote),
      body: NoteList(notes: notes, onEdit: updateNote, onDelete: deleteNote),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: notesDatabase.stream,
      builder: (context, snapshot) {
        // loading
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: ThemeColor.fuchsia.shade700,
              ),
            ),
          );
        }
        final allNotes = snapshot.data!; // loaded
        return buildLoadedNotes(allNotes);
      },
    );
  }
}
