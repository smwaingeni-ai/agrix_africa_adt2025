class ProgramLog {
  final String programName;
  final String farmer;
  final String resource;
  final String impact;
  final String region;
  final String officer;
  final DateTime date;

  ProgramLog({
    required this.programName,
    required this.farmer,
    required this.resource,
    required this.impact,
    required this.region,
    required this.officer,
    required this.date,
  });

  /// 🔹 Safe empty constructor for forms, placeholder use
  factory ProgramLog.empty() {
    return ProgramLog(
      programName: '',
      farmer: '',
      resource: '',
      impact: '',
      region: '',
      officer: '',
      date: DateTime.now(),
    );
  }

  /// 🔹 From JSON with safety defaults
  factory ProgramLog.fromJson(Map<String, dynamic> json) => ProgramLog(
        programName: json['programName'] ?? '',
        farmer: json['farmer'] ?? '',
        resource: json['resource'] ?? '',
        impact: json['impact'] ?? '',
        region: json['region'] ?? '',
        officer: json['officer'] ?? '',
        date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      );

  /// 🔹 To JSON
  Map<String, dynamic> toJson() => {
        'programName': programName,
        'farmer': farmer,
        'resource': resource,
        'impact': impact,
        'region': region,
        'officer': officer,
        'date': date.toIso8601String(),
      };

  @override
  String toString() =>
      'ProgramLog(program: $programName, farmer: $farmer, date: $date)';
}
