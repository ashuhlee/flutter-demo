
import 'dart:ui';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

import 'package:todo_app/models/note.dart';
import 'package:todo_app/widgets/note_card.dart';
import '../theme/colors.dart';

class NoteList extends StatelessWidget {
  const NoteList({
    super.key,
    required this.notes,
    required this.onEdit,
    required this.onDelete,
    required this.onReorder
  });

  final List<Note> notes;
  final void Function(Note note) onEdit;
  final void Function(Note note) onDelete;
  final void Function(int oldIndex, int newIndex) onReorder;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      itemCount: notes.length,

      onReorderStart: (index) {
        HapticFeedback.selectionClick();
      },
      onReorderItem: (int oldIndex, int newIndex) {
        onReorder(oldIndex, newIndex);
      },
      onReorderEnd: (index) {
        HapticFeedback.mediumImpact();
      },

      proxyDecorator: (Widget child, int index, animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final double animValue = Curves.easeInOutCubic.transform(animation.value);
            final scale = lerpDouble(1, 1.04, animValue)!;

            return Transform.scale(
              scale: scale,
              child: Material(
                shadowColor: ThemeColor.fuchsia.shade300.withValues(alpha: 0.05),
                elevation: 16,
                color: Colors.transparent,
                child: child
              ),
            );
          },
          child: child,
        );
      },
      itemBuilder: (context, index) {
        final note = notes[index]; // get each note

        return Padding( // wrap each note with padding
          key: ValueKey(note.id),
          padding: const EdgeInsets.symmetric(vertical: 10),

          child: NoteCard( // return the list tile ui
            note: note,
            onEdit: () => onEdit(note),
            onDelete: () => onDelete(note)
          ),
        );
      },
    );
  }
}
