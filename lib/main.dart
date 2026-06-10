
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:todo_app/note_page.dart';
import 'package:todo_app/constants/colors.dart';

Future<void> main() async {
  await dotenv.load();
  // supabase setup
  await Supabase.initialize(
    url: 'https://avcklniqdldcnatrdhun.supabase.co',
    publishableKey: dotenv.get('PUBLISHABLE_KEY'),
  );
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ThemeColor.fuchsia.shade50
      ),
      home: NotePage(),
    );
  }
}
