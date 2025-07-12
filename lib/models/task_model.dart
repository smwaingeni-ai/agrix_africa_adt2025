class TaskModel {
  final String title;
  final String description;
  final String result;
  final DateTime date;

  TaskModel({
    required this.title,
    required this.description,
    required this.result,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'result': result,
        'date': date.toIso8601String(),
      };

  static TaskModel fromJson(Map<String, dynamic> json) => TaskModel(
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        result: json['result'] ?? '',
        date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      );
}
