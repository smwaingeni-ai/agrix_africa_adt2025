import 'dart:convert';

class Task {
  String id;
  String title;
  String description;
  String status; // Possible values: 'Pending', 'In Progress', 'Completed'
  DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
  });

  /// 🔹 Empty instance for form defaults or placeholders
  factory Task.empty() {
    return Task(
      id: '',
      title: '',
      description: '',
      status: 'Pending',
      createdAt: DateTime.now(),
    );
  }

  /// 🔹 Deserialize from JSON with safety
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 'Pending',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  /// 🔹 Serialize to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'status': status,
        'createdAt': createdAt.toIso8601String(),
      };

  @override
  String toString() =>
      'Task(title: $title, status: $status, createdAt: $createdAt)';
}
