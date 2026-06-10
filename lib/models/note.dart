
class Note {
  int? id;
  String content;
  String createdAt;
  String? updatedAt;

  Note ({
    this.id,
    required this.content,
    required this.createdAt,
    this.updatedAt,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int,
      content: map['content'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String?
    );
  }
  // note to map
  Map<String, dynamic> toMap() {
    return {
      'content': content
    };
  }
}