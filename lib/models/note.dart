
class Note {
  int? id;
  String content;
  String createdAt;
  String? updatedAt;
  int order;

  Note ({
    this.id,
    required this.content,
    required this.createdAt,
    this.updatedAt,
    this.order = 0
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int,
      content: map['content'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String?,
      order: map['order'] as int
    );
  }
  // note to map
  Map<String, dynamic> toMap() {
    return {
      'content': content
    };
  }
}