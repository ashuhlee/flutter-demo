import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/theme/colors.dart';

class NoteAppBar extends StatelessWidget {
  const NoteAppBar({
    super.key,
    required this.noteCount,
  });

  final int noteCount;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 40, 26, 0),
        padding: const EdgeInsets.fromLTRB(20, 16, 0, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent notes',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB387A4),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _Pill(
                      color: ThemeColor.teal.shade400,
                      textColor: const Color(0xFF5A9AAD),
                      borderColor: const Color(0xFFCFEBF5),
                      text: noteCount == 1
                          ? '$noteCount entry'
                          : '$noteCount entries',
                    ),
                    const SizedBox(width: 8),
                    _Pill(
                      color: const Color(0xFFFFE9E1),
                      textColor: const Color(0xFFE99D79),
                      borderColor: const Color(0xFFFFD9B5),
                      text: 'Synced',
                      icon: Icons.cloud_outlined,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                _IconCircle(asset: 'assets/icons/settings.svg'),
                _IconCircle(asset: 'assets/icons/user_circle.svg'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.color,
    required this.textColor,
    required this.borderColor,
    required this.text,
    this.icon,
  });

  final Color color;
  final Color textColor;
  final Color borderColor;
  final String text;
  final IconData? icon;

  // pills
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: textColor),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: TextStyle(fontSize: 15, color: textColor, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _IconCircle extends StatelessWidget {
  const _IconCircle({required this.asset});

  final String asset;

  // circle icons
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Color(0xFFFDFCFF),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(10),
        child: SvgPicture.asset(asset, width: 40, height: 40),
      ),
    );
  }
}