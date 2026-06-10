import 'package:flutter/material.dart';

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
      title: Text(title),
      content: TextField(controller: controller),
      actions: [
        TextButton(
          child: const Text('Cancel'),

          onPressed: () {
            Navigator.pop(context);
            controller.clear();
          },
        ),
        TextButton(onPressed: onSave, child: const Text('Save')),
      ],
    );
  }
}
