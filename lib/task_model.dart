class Task {
  final int? id;
  final String text;
  bool isDone;
  DateTime? completionDate;

  Task({
    this.id,
    required this.text,
    this.isDone = false,
    this.completionDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'isDone': isDone ? 1 : 0,
      'completionDate': completionDate?.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      text: map['text'] as String,
      isDone: (map['isDone'] as int) == 1,
      completionDate: map['completionDate'] == null ? null : DateTime.tryParse(map['completionDate'] as String),
    );
  }
}
