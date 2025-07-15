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

  /// 🔹 Empty instance for default usage (e.g. forms, drafts)
  factory TaskModel.empty() {
    return TaskModel(
      title: '',
      description: '',
      result: '',
      date: DateTime.now(),
    );
  }

  /// 🔁 Convert to JSON
  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'result': result,
        'date': date.toIso8601String(),
      };

  /// 🔁 Parse from JSON with fallbacks
  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        result: json['result'] ?? '',
        date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      );

  @override
  String toString() =>
      'TaskModel(title: $title, result: $result, date: $date)';
}
