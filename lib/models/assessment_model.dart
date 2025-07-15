class AssessmentModel {
  String farmId;
  String issuesFound;
  String recommendation;
  DateTime assessmentDate;

  AssessmentModel({
    required this.farmId,
    required this.issuesFound,
    required this.recommendation,
    required this.assessmentDate,
  });

  /// 🔹 Empty constructor for safe form/default usage
  factory AssessmentModel.empty() {
    return AssessmentModel(
      farmId: '',
      issuesFound: '',
      recommendation: '',
      assessmentDate: DateTime.now(),
    );
  }

  /// 🔹 Parse from JSON with null-safe fallbacks
  factory AssessmentModel.fromJson(Map<String, dynamic> json) {
    return AssessmentModel(
      farmId: json['farmId'] ?? '',
      issuesFound: json['issuesFound'] ?? '',
      recommendation: json['recommendation'] ?? '',
      assessmentDate:
          DateTime.tryParse(json['assessmentDate'] ?? '') ?? DateTime.now(),
    );
  }

  /// 🔹 Serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'farmId': farmId,
      'issuesFound': issuesFound,
      'recommendation': recommendation,
      'assessmentDate': assessmentDate.toIso8601String(),
    };
  }

  @override
  String toString() =>
      'AssessmentModel(farmId: $farmId, issues: $issuesFound, recommendation: $recommendation, date: $assessmentDate)';
}
