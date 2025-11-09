// lib/notes_list_screen.dart
import 'package:flutter/material.dart';
import 'note_model.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  final List<Note> _notes = [];

  // Handle result coming back from /edit or /view (create/edit/delete)
  Future<void> _openEditScreen({Note? note, int? index}) async {
    // Pass an arguments map so receiver knows whether it's edit or new
    final result = await Navigator.pushNamed(
      context,
      '/edit',
      arguments: {
        'note': note?.toMap(),
        'index': index,
      },
    );

    // result expected as map: { action: 'create'|'update'|'delete', 'note': map, 'index': int? }
    if (result is Map<String, dynamic>) {
      final action = result['action'] as String?;
      final noteMap = result['note'] as Map<String, dynamic>?;
      final idx = result['index'] as int?;
      if (action == 'create' && noteMap != null) {
        setState(() {
          _notes.insert(0, Note.fromMap(noteMap));
        });
      } else if (action == 'update' && noteMap != null && idx != null) {
        setState(() {
          _notes[idx] = Note.fromMap(noteMap);
        });
      } else if (action == 'delete' && idx != null) {
        setState(() {
          _notes.removeAt(idx);
        });
      }
    }
  }

  Future<void> _openViewScreen(int index) async {
    final result = await Navigator.pushNamed(
      context,
      '/view',
      arguments: {
        'note': _notes[index].toMap(),
        'index': index,
      },
    );

    // Process possible deletion or update from view screen
    if (result is Map<String, dynamic>) {
      final action = result['action'] as String?;
      final noteMap = result['note'] as Map<String, dynamic>?;
      final idx = result['index'] as int?;
      if (action == 'update' && noteMap != null && idx != null) {
        setState(() {
          _notes[idx] = Note.fromMap(noteMap);
        });
      } else if (action == 'delete' && idx != null) {
        setState(() {
          _notes.removeAt(idx);
        });
      }
    }
  }

  Widget _buildEmpty() => const Center(
        child: Text(
          'No notes yet.\nTap + to add a new note.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: _notes.isEmpty
          ? _buildEmpty()
          : ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, i) {
                final note = _notes[i];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(
                      note.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      note.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      '${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    onTap: () => _openViewScreen(i),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openEditScreen(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
