import 'package:flutter/material.dart';

class DeleteFormDialog extends StatelessWidget {
  const DeleteFormDialog({super.key, required this.onDelete});

  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Note?'),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(onPressed: onDelete, child: const Text('Delete')),
      ],
    );
  }
}
