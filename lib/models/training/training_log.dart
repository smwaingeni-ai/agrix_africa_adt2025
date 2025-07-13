class TrainingLog {
  final String topic;
  final String trainer;
  final int participants;
  final String region;
  final DateTime date;

  TrainingLog({
    required this.topic,
    required this.trainer,
    required this.participants,
    required this.region,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'topic': topic,
        'trainer': trainer,
        'participants': participants,
        'region': region,
        'date': date.toIso8601String(),
      };

  factory TrainingLog.fromJson(Map<String, dynamic> json) {
    return TrainingLog(
      topic: json['topic'] ?? '',
      trainer: json['trainer'] ?? '',
      participants: json['participants'] ?? 0,
      region: json['region'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
    );
  }
}
