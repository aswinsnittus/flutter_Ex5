// lib/note_model.dart
class Note {
  String title;
  String content;
  DateTime createdAt;

  Note({
    required this.title,
    required this.content,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // For convenience when passing via routes, we can convert to/from Map
  Map<String, dynamic> toMap() => {
        'title': title,
        'content': content,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Note.fromMap(Map<String, dynamic> map) => Note(
        title: map['title'] as String,
        content: map['content'] as String,
        createdAt: DateTime.parse(map['createdAt'] as String),
      );
}
