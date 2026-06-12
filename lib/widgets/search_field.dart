
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import 'package:todo_app/theme/colors.dart';

class NoteSearchField extends StatelessWidget {

  const NoteSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: false,
      onChanged: onChanged,

      cursorColor: ThemeColor.fuchsia.shade500,
      decoration: InputDecoration(
        hintText: 'Search notes...',
        hintStyle: TextStyle(color: Colors.grey.shade500),
        prefixIcon: Container(
          margin: EdgeInsets.only(left: 2),
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: ThemeColor.fuchsia.shade200,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          child: Icon(
            TablerIcons.search,
            size: 22,
            color: ThemeColor.fuchsia.shade800,
          ),
        ),
        prefixIconConstraints: BoxConstraints(),
        filled: true,
        fillColor: Color(0xFFFDFCFF),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: ThemeColor.fuchsia.shade100,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: ThemeColor.fuchsia.shade100,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: ThemeColor.fuchsia.shade400, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: ThemeColor.fuchsia.shade100,
            width: 1.5,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 13),
      ),
    );
  }
}
