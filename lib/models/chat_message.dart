class ChatMessage {
  String sender;
  String message;
  DateTime timestamp;

  ChatMessage({
    required this.sender,
    required this.message,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'sender': sender,
        'message': message,
        'timestamp': timestamp.toIso8601String(),
      };

  static ChatMessage fromJson(Map<String, dynamic> json) => ChatMessage(
        sender: json['sender'] ?? 'Unknown',
        message: json['message'] ?? '',
        timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
      );
}
