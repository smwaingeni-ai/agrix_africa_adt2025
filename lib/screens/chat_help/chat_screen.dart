import 'package:flutter/material.dart';
import 'package:agrix_africa_adt2025/models/chat_message.dart';
import 'package:agrix_africa_adt2025/services/chat_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isSending = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(sender: 'You', message: text));
      _isSending = true;
      _controller.clear();
    });

    try {
      final reply = await ChatService.getBotResponse(text);
      setState(() {
        _messages.add(ChatMessage(sender: 'AgriGPT', message: reply));
      });
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
          sender: 'AgriGPT',
          message: '⚠️ Failed to get response. Please try again.',
        ));
      });
    } finally {
      setState(() => _isSending = false);
    }
  }

  Widget _buildMessageBubble(ChatMessage msg) {
    final isUser = msg.sender == 'You';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: isUser ? Colors.green.shade100 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          '${msg.sender}: ${msg.message}',
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('💬 AgriX Chat Assistant')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _buildMessageBubble(_messages[index]),
            ),
          ),
          if (_isSending)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Ask AgriGPT something...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
