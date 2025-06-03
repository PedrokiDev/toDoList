class Task {
  final int? id;
  final String text;
  bool isDone;

  Task({this.id, required this.text, this.isDone = false});

  Map<String, dynamic> toMap() {
    return {'id': id, 'text': text, 'isDone': isDone ? 1 : 0};
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      text: map['text'] as String,
      isDone: (map['isDone'] as int) == 1,
    );
  }
}
