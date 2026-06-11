
import 'package:todo_app/models/note.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteDatabase {
  // database → notes
  final database = Supabase.instance.client.from('notes');

  Future createNote(Note newNote) async {
    final count = await database.count();
    await database.insert({
      ...newNote.toMap(),
      'order': count
    });
  }

  // read
  final stream = Supabase.instance.client.from('notes').stream(
    primaryKey: ['id'],
  ).order('order').map((data) {
    final notes = data.map((noteMap) => Note.fromMap(noteMap)).toList();
    notes.sort((a, b) => a.order.compareTo(b.order)); // sort stream by order

    return notes;
  });

  Future updateNote(Note oldNote, String newContent) async {
    await database.update({
      'content': newContent,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    }).eq('id', oldNote.id!);
  }

  Future deleteNote(Note note) async {
    await database.delete().eq('id', note.id!);
  }
  // key: index   value: note
  Future updateOrder(List<Note> notes) async {
    await Future.wait(
      notes.asMap().entries.map((entry) =>
        database.update({'order': entry.key}).eq('id', entry.value.id!)
      )
    );
  }
}