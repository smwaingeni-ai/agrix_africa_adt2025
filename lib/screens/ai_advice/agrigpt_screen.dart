import 'package:flutter/material.dart';

class AgriGPTScreen extends StatefulWidget {
  const AgriGPTScreen({super.key});

  @override
  State<AgriGPTScreen> createState() => _AgriGPTScreenState();
}

class _AgriGPTScreenState extends State<AgriGPTScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage() {
    final question = _controller.text.trim();
    if (question.isEmpty) return;

    FocusScope.of(context).unfocus(); // 🔹 Hide keyboard

    setState(() {
      _messages.add({'role': 'user', 'text': question});
      _messages.add({
        'role': 'bot',
        'text': '🤖 AI Response to "$question"\n\n[This will soon be powered by OpenAI API or a local model]',
      });
      _controller.clear();
    });

    // TODO: Replace with actual API call to OpenAI or your smart assistant backend
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AgriGPT – Smart Farming Assistant'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Chat message list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final isUser = msg['role'] == 'user';
                  final text = msg['text'] ?? '';

                  return Align(
                    alignment: isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: isUser
                            ? Colors.green.shade100
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        text,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  );
                },
              ),
            ),

            // 🔹 Input box
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Ask a farming question...',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                    tooltip: 'Send',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
