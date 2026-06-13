import 'package:flutter/material.dart';

import '../theme/colors.dart';

class DeleteFormDialog extends StatelessWidget {
  const DeleteFormDialog({super.key, required this.onDelete});

  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      backgroundColor: const Color(0xFFFDFCFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: ThemeColor.fuchsia.shade100, width: 1.5),
      ),
      title: const Text(
        'Delete Note?',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF6D6D80),
        ),
      ),
      content: const Text(
        " This action can't be reversed",
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.grey, fontSize: 17),
          ),
        ),
        TextButton(
          onPressed: onDelete,
          style: TextButton.styleFrom(
            backgroundColor: ThemeColor.fuchsia.shade200,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 0),
          ),
          child: Text(
            'Delete',
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
