import 'dart:convert';

class ChatMessage {
  final String id;
  final String sender;   // 'user' or 'bot'
  final String message;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.sender,
    required this.message,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  /// 🔹 Create an empty/default message
  factory ChatMessage.empty() => ChatMessage(
        id: '',
        sender: '',
        message: '',
        timestamp: DateTime.now(),
      );

  /// 🔹 Deserialize from JSON
  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json['id'] ?? '',
        sender: json['sender'] ?? 'user',
        message: json['message'] ?? '',
        timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
      );

  /// 🔹 Serialize to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'sender': sender,
        'message': message,
        'timestamp': timestamp.toIso8601String(),
      };

  /// 🔹 Debug-friendly string
  @override
  String toString() => jsonEncode(toJson());
}
