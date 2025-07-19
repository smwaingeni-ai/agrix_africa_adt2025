resolve this file by addressing this...✅ 2. Wrong or Missing Constructor Parameters
🚨 File	❌ Problem	✅ Fix
ChatMessage()	id required but not provided	Pass id: UniqueKey().toString()...in /lib/models/chat_message.dart. Provide production ready code, current code:.....import 'dart:convert';
import 'package:uuid/uuid.dart';

/// Represents a single chat message between user and system (bot).
class ChatMessage {
  final String id;               // Unique message ID
  final String sender;           // 'user' or 'bot'
  final String message;          // Message content
  final DateTime timestamp;      // Time sent

  static const List<String> validSenders = ['user', 'bot'];

  ChatMessage({
    required this.id,
    required this.sender,
    required this.message,
    DateTime? timestamp,
  })  : assert(validSenders.contains(sender), 'Sender must be "user" or "bot"'),
        timestamp = timestamp ?? DateTime.now();

  /// 🔹 Create an empty/default message (used for testing or UI placeholder)
  factory ChatMessage.empty() => ChatMessage(
        id: const Uuid().v4(),
        sender: 'user',
        message: '',
        timestamp: DateTime.now(),
      );

  /// 🔹 Create a new message with automatic ID and timestamp
  factory ChatMessage.create({
    required String sender,
    required String message,
  }) {
    return ChatMessage(
      id: const Uuid().v4(),
      sender: sender,
      message: message,
    );
  }

  /// 🔹 Deserialize from JSON with ID fallback
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    return ChatMessage(
      id: id is String && id.isNotEmpty ? id : const Uuid().v4(),
      sender: json['sender'] ?? 'user',
      message: json['message'] ?? '',
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
    );
  }

  /// 🔹 Serialize to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'sender': sender,
        'message': message,
        'timestamp': timestamp.toIso8601String(),
      };

  /// 🔹 Helpful for debugging
  @override
  String toString() => jsonEncode(toJson());
}
