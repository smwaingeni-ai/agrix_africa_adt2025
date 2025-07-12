import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chat_message.dart';

class ChatService {
  static const String _chatKey = 'chat_messages';

  List<ChatMessage> _messages = [];

  /// 🔹 Public getter for chat messages
  List<ChatMessage> get messages => List.unmodifiable(_messages);

  /// 🔹 Load chat history from SharedPreferences
  Future<void> loadMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_chatKey);
      if (jsonString != null) {
        final List<dynamic> decoded = jsonDecode(jsonString);
        _messages = decoded.map((msg) => ChatMessage.fromJson(msg)).toList();
      }
    } catch (e) {
      print('❌ Failed to load messages: $e');
    }
  }

  /// 🔹 Save messages to local storage
  Future<void> saveMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(_messages.map((msg) => msg.toJson()).toList());
      await prefs.setString(_chatKey, jsonString);
    } catch (e) {
      print('❌ Failed to save messages: $e');
    }
  }

  /// 🔹 Add a new message and persist it
  Future<void> addMessage(ChatMessage message) async {
    _messages.add(message);
    await saveMessages();
  }

  /// 🔹 Clear all saved messages
  Future<void> clearMessages() async {
    _messages.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chatKey);
  }

  /// 🔹 Simulated AgriGPT bot response (offline)
  static Future<String> getBotResponse(String userMessage) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return '🤖 AgriGPT: You asked "$userMessage" — Please clarify or choose a category.';
  }
}
