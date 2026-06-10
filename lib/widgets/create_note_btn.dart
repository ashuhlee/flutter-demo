
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import 'package:todo_app/constants/colors.dart';

class CreateNoteButton extends StatelessWidget {
  const CreateNoteButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: const Text('Create',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
      icon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color(0xFFE9EBFF),
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Icon(TablerIcons.plus, size: 22, color: Color(0xFFAFB4ED)),
      ),
      backgroundColor: const Color(0xFFFDFCFF),
      foregroundColor: const Color(0xFF363650),
      elevation: 0,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ThemeColor.fuchsia.shade100, width: 1.5),
      ),
    );
  }
}
