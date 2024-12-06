// models/task.dart
class Task {
  final int id;
  final String content;
  final int status;

  Task({
    required this.id,
    required this.content,
    required this.status,
  });

  Task copyWith({int? id, String? content, int? status}) {
    return Task(
      id: id ?? this.id,
      content: content ?? this.content,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'status': status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      content: map['content'],
      status: map['status'],
    );
  }
}
