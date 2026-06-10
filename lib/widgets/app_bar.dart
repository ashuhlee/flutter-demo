import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/widgets/search_field.dart';

class NoteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NoteAppBar({
    super.key,
    required this.noteCount,
    required this.searchController,
    required this.onSearchChanged,
  });

  final int noteCount;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ThemeColor.fuchsia.shade50,
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notes',
            style: TextStyle(fontSize: 24, color: Color(0xFF363650)),
          ),
          Text(
            '$noteCount entries',
            style: TextStyle(fontSize: 16, color: ThemeColor.fuchsia.shade800),
          ),
        ],
      ),

      bottom: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: NoteSearchField(
            controller: searchController,
            onChanged: onSearchChanged,
          ),
        ),
      ),
    );
  }
}
