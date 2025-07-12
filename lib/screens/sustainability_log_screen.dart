import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SustainabilityLogScreen extends StatefulWidget {
  const SustainabilityLogScreen({super.key});

  @override
  State<SustainabilityLogScreen> createState() =>
      _SustainabilityLogScreenState();
}

class _SustainabilityLogScreenState extends State<SustainabilityLogScreen> {
  final TextEditingController _farmer = TextEditingController();
  final TextEditingController _practice = TextEditingController();
  final TextEditingController _comment = TextEditingController();
  String _status = 'Adopted';

  Future<void> _saveLog() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/sustainability_log.json');

    final logEntry = {
      'timestamp': DateTime.now().toIso8601String(),
      'farmer': _farmer.text,
      'practice': _practice.text,
      'status': _status,
      'comment': _comment.text,
    };

    List<dynamic> logs = [];
    if (await file.exists()) {
      final content = await file.readAsString();
      if (content.isNotEmpty) {
        logs = jsonDecode(content);
      }
    }

    logs.add(logEntry);
    await file.writeAsString(jsonEncode(logs));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Sustainability log saved')),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _farmer.dispose();
    _practice.dispose();
    _comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sustainability Log')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _farmer,
              decoration: const InputDecoration(labelText: 'Farmer'),
            ),
            TextField(
              controller: _practice,
              decoration: const InputDecoration(labelText: 'Practice Type'),
            ),
            DropdownButtonFormField<String>(
              value: _status,
              items: ['Adopted', 'Not Adopted']
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (val) => setState(() => _status = val ?? 'Adopted'),
              decoration: const InputDecoration(labelText: 'Adoption Status'),
            ),
            TextField(
              controller: _comment,
              decoration:
                  const InputDecoration(labelText: 'Officer Comment'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveLog,
              child: const Text('Save Log'),
            ),
          ],
        ),
      ),
    );
  }
}
