class Task {
  int? id;
  String title;
  String description;
  bool completed;
  DateTime createdAt;

  Task(
      {this.id,
      required this.title,
      required this.description,
      this.completed = false,
      required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      completed: json['completed'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
