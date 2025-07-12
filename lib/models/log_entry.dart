class LogEntry {
  final String timestamp;
  final String result;
  final String cost;

  LogEntry({
    required this.timestamp,
    required this.result,
    required this.cost,
  });

  factory LogEntry.fromJson(Map<String, dynamic> json) => LogEntry(
        timestamp: json['timestamp'] ?? '',
        result: json['result'] ?? '',
        cost: json['cost'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
        'result': result,
        'cost': cost,
      };
}
