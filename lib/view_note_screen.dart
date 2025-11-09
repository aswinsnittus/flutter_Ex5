// lib/view_note_screen.dart
import 'package:flutter/material.dart';
import 'note_model.dart';

class ViewNoteScreen extends StatelessWidget {
  const ViewNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args == null || args['note'] == null || args['index'] == null) {
      // If no args provided, go back
      return Scaffold(
        appBar: AppBar(title: const Text('Note'), backgroundColor: Colors.blueAccent),
        body: const Center(child: Text('No note found')),
      );
    }

    final note = Note.fromMap(args['note'] as Map<String, dynamic>);
    final index = args['index'] as int;

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Note'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Return delete instruction to the previous screen
              Navigator.pop(context, {'action': 'delete', 'index': index});
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              // Navigate to edit screen with current note data
              final result = await Navigator.pushNamed(
                context,
                '/edit',
                arguments: {
                  'note': note.toMap(),
                  'index': index,
                },
              );
              // If edit returned something, pass it back upward
              if (result is Map<String, dynamic>) {
                Navigator.pop(context, result);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Created: ${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year} ${note.createdAt.hour}:${note.createdAt.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const Divider(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      note.content,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
