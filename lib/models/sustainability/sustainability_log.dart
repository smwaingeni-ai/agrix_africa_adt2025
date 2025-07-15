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

  /// 🔹 Safe empty instance (e.g., for forms or default init)
  factory SustainabilityLog.empty() {
    return SustainabilityLog(
      activity: '',
      impact: '',
      region: '',
      date: DateTime.now(),
    );
  }

  /// 🔹 Safe JSON parsing
  factory SustainabilityLog.fromJson(Map<String, dynamic> json) {
    return SustainabilityLog(
      activity: json['activity'] ?? '',
      impact: json['impact'] ?? '',
      region: json['region'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
    );
  }

  /// 🔹 Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'activity': activity,
      'impact': impact,
      'region': region,
      'date': date.toIso8601String(),
    };
  }

  @override
  String toString() =>
      'SustainabilityLog(activity: $activity, impact: $impact, region: $region, date: $date)';
}
