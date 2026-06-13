import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:change_case/change_case.dart';

import 'package:todo_app/models/note.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/utils/date_formatter.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    required this.onEdit,
    required this.onDelete,
  });

  final Note note;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final wasEdited = note.updatedAt != null;

    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(

        color: Color(0xFFFDFCFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ThemeColor.fuchsia.shade100, width: 1.5),

        boxShadow: [
          BoxShadow(
            color: ThemeColor.fuchsia.shade500.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text( // note title
              note.content,
              style: TextStyle(
                color: Color(0xFF4F4F62),
                fontWeight: FontWeight.w400,
                fontSize: 16.5,
              ),
            ),
            subtitle: Row( // date and time + icons
              children: [
                Icon(
                  wasEdited ? TablerIcons.heart_exclamation : TablerIcons.heart,
                  size: 15,
                  color: Colors.grey.shade400,
                ),
                SizedBox(width: 2),
                Text(
                  wasEdited
                      ? 'Edited ${formatTime(note.updatedAt!)}'
                      : formatTime(note.createdAt).toUpperFirstCase(),
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                ),
              ],
            ),
            trailing: Row( // right icons
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton( // edit button
                  onPressed: onEdit,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  icon: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: CircleAvatar(
                      backgroundColor: ThemeColor.teal.shade400,
                      radius: 24,
                      child: Icon(
                        TablerIcons.edit,
                        color: ThemeColor.teal.shade600,
                        size: 26,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton( // delete button
                  onPressed: onDelete,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  icon: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: CircleAvatar(
                      backgroundColor: ThemeColor.fuchsia.shade200,
                      radius: 24,
                      child: Icon(
                        TablerIcons.trash,
                        color: ThemeColor.fuchsia.shade800,
                        size: 26,
                      )
                    )
                  )
                )
              ]
            )
          )
        ]
      )
    );
  }
}
