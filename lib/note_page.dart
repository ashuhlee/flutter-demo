
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:intl/intl.dart';
import 'package:change_case/change_case.dart';

import 'package:todo_app/note_database.dart';
import 'package:todo_app/note.dart';
import 'package:todo_app/constants/colors.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  // notes database + text controller
  final notesDatabase = NoteDatabase();
  final noteController = TextEditingController();

  final searchController = TextEditingController();
  int noteCount = 0;

  // add new note
  void addNewNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Note'),
        content: TextField(
          controller: noteController,
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                noteController.clear();
              },
              child: const Text('Cancel')
          ),
          TextButton(
              onPressed: () {
                // create a new note
                final newNote = Note(content: noteController.text, createdAt: '', updatedAt: null);
                notesDatabase.createNote(newNote);

                Navigator.pop(context);
                noteController.clear();
              },
              child: const Text('Save')
          ),
        ]
      ),
    );
  }
  // update existing note
  void updateNote(Note note) {
    // prefill text controller w existing note
    noteController.text = note.content;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Note'),
        content: TextField(
          controller: noteController,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              noteController.clear();
            },
            child: const Text('Cancel')
          ),
          TextButton(
            onPressed: () {
              notesDatabase.updateNote(note, noteController.text);

              Navigator.pop(context);
              noteController.clear();
            },
            child: const Text('Save')
          ),
        ]
      ),
    );
  }
  void deleteNote(Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              noteController.clear();
            },
            child: const Text('Cancel')
          ),
          TextButton(
            onPressed: () {
              notesDatabase.deleteNote(note);

              Navigator.pop(context);
              noteController.clear();
            },
            child: const Text('Delete')
          ),
        ]
      ),
    );
  }

  String formatTime(String raw) {
    final date = DateTime.parse(raw).toLocal();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final noteDay = DateTime(date.year, date.month, date.day);
    final time = DateFormat('h:mm a').format(date);

    if (noteDay == today) {
      return 'today at $time';
    }
    else if (noteDay == yesterday) {
      return 'yesterday at $time';
    }
    else {
      return '${DateFormat('MMMM d').format(date)} at $time';
    }
  }

  // build ui
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColor.fuchsia.shade50,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notes',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF363650)
            )),
            Text('$noteCount entries',
              style: TextStyle(
                fontSize: 16,
                color: ThemeColor.fuchsia.shade800)
            )
          ],
        ),

        bottom: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: searchController,
                  autofocus: false,
                  onChanged: (value) {
                    setState(() {});
                  },
                  cursorColor: ThemeColor.fuchsia.shade500,
                  decoration: InputDecoration(
                    hintText: 'Search notes...',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500
                    ),
                    prefixIcon: Container(
                      margin: EdgeInsets.only(left: 2),
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 11.75),
                      decoration: BoxDecoration(
                        color: ThemeColor.fuchsia.shade200,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Icon(TablerIcons.search, size: 20, color: ThemeColor.fuchsia.shade800),
                    ),
                    prefixIconConstraints: BoxConstraints(),
                    filled: true,
                    fillColor: Color(0xFFFDFCFF),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: ThemeColor.fuchsia.shade100, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: ThemeColor.fuchsia.shade100, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: ThemeColor.fuchsia.shade400, width: 2),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: ThemeColor.fuchsia.shade100, width: 1.5),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 4),
                  ),
                ),

            )
        ),
      ),

      floatingActionButton: FloatingActionButton.extended (
        onPressed: addNewNote,
        label: Text('Create',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400
          ),
        ),
        icon: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Color(0xFFE9EBFF),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(TablerIcons.plus, size: 22, color: Color(0xFFAFB4ED)),
        ),

        backgroundColor: Color(0xFFFDFCFF),
        foregroundColor: Color(0xFF363650),

        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: ThemeColor.fuchsia.shade100,
            width: 1.5,
          ),
        ),
      ),

      // body → stream builder
      body: StreamBuilder(
        stream: notesDatabase.stream,
        builder: (context, snapshot) {
          // loading
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(color: ThemeColor.fuchsia.shade700,));
          }
          // loaded
          final allNotes = snapshot.data!;
          noteCount = allNotes.length;

          final notes = allNotes
              .where((search) => search.content.toLowerCase()
              .contains(searchController.text.toLowerCase()))
              .toList();

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              // get each note
              final note = notes[index];
              final wasEdited = note.updatedAt != null;

              // return as list tile ui
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                padding: EdgeInsets.all(4),

                decoration: BoxDecoration(
                  color: Color(0xFFFDFCFF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: ThemeColor.fuchsia.shade100,
                    width: 1.5
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeColor.fuchsia.shade500.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: Offset(0, 5)

                    )
                  ]
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(note.content,
                        style: TextStyle(
                          color: Color(0xFF363650),
                          fontWeight: FontWeight.w400
                        )
                      ),
                      subtitle: Row(
                        children: [
                          Icon(
                            wasEdited ? TablerIcons.heart_exclamation : TablerIcons.heart,
                            size: 14, color: Colors.grey.shade400
                          ),
                          SizedBox(width: 2),
                          Text(
                            wasEdited ? 'Edited ${formatTime(note.updatedAt!)}' : formatTime(note.createdAt).toUpperFirstCase(),
                            style: TextStyle(color: Colors.grey.shade400, fontSize: 14)
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => updateNote(note),
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                            icon: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                backgroundColor: ThemeColor.teal.shade400,
                                radius: 24,
                                child: Icon(
                                  TablerIcons.edit,
                                  color: ThemeColor.teal.shade600,
                                  size: 26
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          IconButton(
                            onPressed: () => deleteNote(note),
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                            icon: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                backgroundColor: ThemeColor.fuchsia.shade200,
                                radius: 24,
                                child: Icon(
                                    TablerIcons.trash,
                                    color: ThemeColor.fuchsia.shade800,
                                    size: 26
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      ),
    );
  }
}