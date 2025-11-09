// lib/main.dart
import 'package:flutter/material.dart';
import 'notes_list_screen.dart';
import 'edit_note_screen.dart';
import 'view_note_screen.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes Taking App - Navigation Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const NotesListScreen(),
        '/edit': (context) => const EditNoteScreen(),
        '/view': (context) => const ViewNoteScreen(),
      },
    );
  }
}
