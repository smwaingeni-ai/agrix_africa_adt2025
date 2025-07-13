class SustainabilityLog {
  final String activity;
  final String impact;
  final String region;
  final DateTime date;

  SustainabilityLog({
    required this.activity,
    required this.impact,
    required this.region,
    required this.date,
  });

  factory SustainabilityLog.fromJson(Map<String, dynamic> json) {
    return SustainabilityLog(
      activity: json['activity'] ?? '',
      impact: json['impact'] ?? '',
      region: json['region'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activity': activity,
      'impact': impact,
      'region': region,
      'date': date.toIso8601String(),
    };
  }
}
