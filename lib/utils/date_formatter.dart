
import 'package:intl/intl.dart';

String formatTime(String raw) {
  final date = DateTime.parse(raw).toLocal();
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));

  final noteDay = DateTime(date.year, date.month, date.day);
  final time = DateFormat('h:mm a').format(date);

  if (noteDay == today) {
    return 'today at $time';
  } else if (noteDay == yesterday) {
    return 'yesterday at $time';
  } else {
    return '${DateFormat('MMMM d').format(date)} at $time';
  }
}