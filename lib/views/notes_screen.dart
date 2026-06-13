import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:todo_app/services/note_database.dart';
import 'package:todo_app/models/note.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/widgets/app_bar.dart';
import 'package:todo_app/widgets/create_note_btn.dart';
import 'package:todo_app/widgets/delete_note_dialog.dart';
import 'package:todo_app/widgets/note_dialog.dart';
import 'package:todo_app/widgets/note_list.dart';

import '../widgets/search_field.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  // notes database + text controllers
  final database = NoteDatabase();
  final noteController = TextEditingController();
  final searchController = TextEditingController();

  List<Note> _notes = [];

  void _addNewNote() {
    HapticFeedback.lightImpact();
    showDialog(
      context: context,
      builder: (context) => NoteFormDialog(
        title: 'New Note',
        controller: noteController,
        onSave: () async {
          final newNote = Note(
            content: noteController.text,
            createdAt: '',
            updatedAt: null,
          );
          Navigator.pop(context);
          noteController.clear();
          await database.createNote(newNote);
        },
      ),
    );
  }

  void _updateNote(Note note) {
    noteController.text = note.content; // prefill text controller w existing note
    HapticFeedback.lightImpact();
    showDialog(
      context: context,
      builder: (context) => NoteFormDialog(
        title: 'Update Note',
        controller: noteController,
        onSave: () async {
          final updatedNote = noteController.text;

          Navigator.pop(context);
          noteController.clear();
          await database.updateNote(note, updatedNote);
        },
      ),
    );
  }

  void _deleteNote(Note note) {
    HapticFeedback.mediumImpact();
    showDialog(
      context: context,
      builder: (context) => DeleteFormDialog(
        onDelete: () async {
          Navigator.pop(context);
          await database.deleteNote(note);
        },
      ),
    );
  }

  void _reorderNotes(int oldIndex, int newIndex) {
    setState(() {
      final note = _notes.removeAt(oldIndex);
      _notes.insert(newIndex, note);
    });
    database.updateOrder(_notes);
  }

  List<Note> _filterNotes(List<Note> notes) {
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

  Widget _buildLoadedNotes(List<Note> allNotes) {
    _notes = allNotes;
    final notes = _filterNotes(_notes);

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: CreateNoteButton(onPressed: _addNewNote),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.white.withValues(alpha: 0.6),
              ThemeColor.fuchsia.shade50,
              ThemeColor.fuchsia.shade200,
            ],
            stops: [0.0, 0.4, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,)
        ),
        child: Column(
          children: [
            NoteAppBar(noteCount: notes.length),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: NoteSearchField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: NoteList(
                notes: notes,
                isSearching: searchController.text.isNotEmpty,
                onEdit: _updateNote,
                onDelete: _deleteNote,
                onReorder: _reorderNotes,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: database.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) { // loading
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: ThemeColor.fuchsia.shade700,
              ),
            ),
          );
        }
        final allNotes = snapshot.data!; // loaded
        return _buildLoadedNotes(allNotes);
      },
    );
  }
}
