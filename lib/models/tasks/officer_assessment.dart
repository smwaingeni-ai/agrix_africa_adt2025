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

  factory OfficerAssessment.fromJson(Map<String, dynamic> json) {
    return OfficerAssessment(
      activity: json['activity'] ?? '',
      impact: json['impact'] ?? '',
      recommendation: json['recommendation'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activity': activity,
      'impact': impact,
      'recommendation': recommendation,
      'date': date.toIso8601String(),
    };
  }
}
