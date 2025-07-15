class OfficerAssessment {
  final String activity;
  final String impact;
  final String recommendation;
  final DateTime date;

  OfficerAssessment({
    required this.activity,
    required this.impact,
    required this.recommendation,
    required this.date,
  });

  /// 🔹 Empty constructor for form initialization or placeholders
  factory OfficerAssessment.empty() {
    return OfficerAssessment(
      activity: '',
      impact: '',
      recommendation: '',
      date: DateTime.now(),
    );
  }

  /// 🔹 Parse from JSON with fallbacks
  factory OfficerAssessment.fromJson(Map<String, dynamic> json) {
    return OfficerAssessment(
      activity: json['activity'] ?? '',
      impact: json['impact'] ?? '',
      recommendation: json['recommendation'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
    );
  }

  /// 🔹 Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'activity': activity,
      'impact': impact,
      'recommendation': recommendation,
      'date': date.toIso8601String(),
    };
  }

  @override
  String toString() =>
      'OfficerAssessment(activity: $activity, impact: $impact, recommendation: $recommendation, date: $date)';
}
