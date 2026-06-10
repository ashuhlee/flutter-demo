
import 'package:todo_app/note.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteDatabase {
  // database → notes
  final database = Supabase.instance.client.from('notes');

  // create
  Future createNote(Note newNote) async {
    await database.insert(newNote.toMap());
  }

  // read
  final stream = Supabase.instance.client.from('notes').stream(
    primaryKey: ['id'],
  ).map((data) => data.map((noteMap) => Note.fromMap(noteMap)).toList());

  // update
  Future updateNote(Note oldNote, String newContent) async {
    await database.update({
      'content': newContent,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    }).eq('id', oldNote.id!);
  }

  // delete
  Future deleteNote(Note note) async {
    await database.delete().eq('id', note.id!);
  }
}