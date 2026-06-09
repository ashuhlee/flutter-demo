
import 'package:flutter/material.dart';
import 'package:todo_app/note_database.dart';
import 'package:todo_app/note.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  // notes database + text controller
  final notesDatabase = NoteDatabase();
  final noteController = TextEditingController();

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
                final newNote = Note(content: noteController.text);
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

  // build ui
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewNote,
        child: const Icon(Icons.add),
      ),

      // body → stream builder
      body: StreamBuilder(
        stream: notesDatabase.stream,
        builder: (context, snapshot) {
          // loading
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          // loaded
          final notes = snapshot.data!;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              // get each note
              final note = notes[index];

              // return as list tile ui
              return ListTile(
                title: Text(note.content),
                trailing: SizedBox(
                  width: 100,
                  child: Row(children: [
                    IconButton(
                      onPressed: () => updateNote(note),
                      icon: const Icon(Icons.edit)
                    ),

                    IconButton(
                      onPressed: () => deleteNote(note),
                      icon: const Icon(Icons.delete)
                    )
                  ],
                  ),
                )
              );
            },
          );
        }
      ),
    );
  }
}