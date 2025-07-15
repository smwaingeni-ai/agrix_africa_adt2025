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

  /// 🔹 Empty constructor for default/form use
  factory TrainingLog.empty() {
    return TrainingLog(
      topic: '',
      trainer: '',
      participants: 0,
      region: '',
      date: DateTime.now(),
    );
  }

  /// 🔹 Safe JSON deserialization
  factory TrainingLog.fromJson(Map<String, dynamic> json) {
    return TrainingLog(
      topic: json['topic'] ?? '',
      trainer: json['trainer'] ?? '',
      participants: json['participants'] ?? 0,
      region: json['region'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
    );
  }

  /// 🔹 Serialize to JSON
  Map<String, dynamic> toJson() => {
        'topic': topic,
        'trainer': trainer,
        'participants': participants,
        'region': region,
        'date': date.toIso8601String(),
      };

  @override
  String toString() =>
      'TrainingLog(topic: $topic, trainer: $trainer, participants: $participants, region: $region, date: $date)';
}
