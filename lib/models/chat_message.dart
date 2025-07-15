class ChatMessage {
  String sender;
  String message;
  DateTime timestamp;

  ChatMessage({
    required this.sender,
    required this.message,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  /// 🔹 Empty instance for defaults/placeholders
  factory ChatMessage.empty() {
    return ChatMessage(
      sender: '',
      message: '',
      timestamp: DateTime.now(),
    );
  }

  /// 🔹 Deserialize from JSON with fallbacks
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      sender: json['sender'] ?? 'Unknown',
      message: json['message'] ?? '',
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
    );
  }

  /// 🔹 Serialize to JSON
  Map<String, dynamic> toJson() => {
        'sender': sender,
        'message': message,
        'timestamp': timestamp.toIso8601String(),
      };

  @override
  String toString() =>
      'ChatMessage(sender: $sender, message: $message, timestamp: $timestamp)';
}
