class LogEntry {
  final String timestamp; // ISO 8601 string or formatted datetime
  final String result;    // AI output or action summary
  final String cost;      // e.g., "$0.03" or "0.02 tokens"

  LogEntry({
    required this.timestamp,
    required this.result,
    required this.cost,
  });

  /// 🔹 Empty constructor for default/form use
  factory LogEntry.empty() => LogEntry(
        timestamp: '',
        result: '',
        cost: '',
      );

  /// 🔹 Deserialize from JSON map
  factory LogEntry.fromJson(Map<String, dynamic> json) => LogEntry(
        timestamp: json['timestamp'] ?? '',
        result: json['result'] ?? '',
        cost: json['cost'] ?? '',
      );

  /// 🔹 Serialize to JSON map
  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
        'result': result,
        'cost': cost,
      };

  @override
  String toString() => 'LogEntry(time: $timestamp, cost: $cost, result: $result)';
}
