class ChatMessage {
  String sender;
  String message;
  DateTime timestamp;

  ChatMessage({
    required this.sender,
    required this.message,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  /// Converts the chat message to JSON format.
  Map<String, dynamic> toJson() => {
        'sender': sender,
        'message': message,
        'timestamp': timestamp.toIso8601String(),
      };

  /// Creates a ChatMessage instance from a JSON map.
  static ChatMessage fromJson(Map<String, dynamic> json) => ChatMessage(
        sender: json['sender'] ?? 'Unknown',
        message: json['message'] ?? '',
        timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
      );
}
