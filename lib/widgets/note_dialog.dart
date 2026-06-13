import 'package:flutter/material.dart';

import '../theme/colors.dart';

class NoteFormDialog extends StatelessWidget {
  const NoteFormDialog({
    super.key,
    required this.title,
    required this.controller,
    required this.onSave,
  });

  final String title;
  final TextEditingController controller;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      backgroundColor: const Color(0xFFFDFCFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: ThemeColor.fuchsia.shade100,
          width: 1.5,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF6D6D80),
        ),
      ),
      content: TextField(
        controller: controller,
        cursorColor: ThemeColor.fuchsia.shade500,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFF4F4F5),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            controller.clear();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.grey, fontSize: 17),
          ),
        ),
        TextButton(
          onPressed: onSave,
          style: TextButton.styleFrom(
            backgroundColor: ThemeColor.fuchsia.shade200,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 0),
          ),
          child: Text(
            'Save',
            style: TextStyle(
              color: ThemeColor.fuchsia.shade900,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }
}
