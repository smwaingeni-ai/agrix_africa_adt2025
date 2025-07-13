import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class LivestockScreen extends StatefulWidget {
  const LivestockScreen({super.key});

  @override
  State<LivestockScreen> createState() => _LivestockScreenState();
}

class _LivestockScreenState extends State<LivestockScreen> {
  File? _image;
  String? _diagnosis;
  final TextEditingController _noteController = TextEditingController();

  final Map<String, String?> _answers = {};
  final List<String> _questions = [
    '1. Is the animal refusing to eat or drink?',
    '2. Is there discharge from eyes, nose, or mouth?',
    '3. Are there visible skin lesions or wounds?',
    '4. Is the animal limping or moving abnormally?',
    '5. Are there signs of abnormal behavior (e.g., aggression or weakness)?',
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
        _diagnosis = "🐄 Possible infection or injury symptoms detected (Simulated)";
      });
    }
  }

  void _submitDiagnosis() {
    final allAnswered = _answers.length == _questions.length && !_answers.containsValue(null);

    if (!allAnswered) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('⚠️ Please answer all questions before submitting.')),
      );
      return;
    }

    final issues = _answers.values.where((a) => a == 'Yes').length;
    final result = issues >= 3
        ? '⚠️ Veterinary attention advised. Possible symptoms of illness or distress.'
        : '✅ No major issues observed. Continue monitoring livestock daily.';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Livestock Diagnosis'),
        content: Text(result),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  Future<void> _saveEntry() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/livestock_log.json');

    final entry = {
      'timestamp': DateTime.now().toIso8601String(),
      'diagnosis': _diagnosis ?? '',
      'note': _noteController.text,
    };

    List<dynamic> logs = [];
    if (await file.exists()) {
      final content = await file.readAsString();
      logs = json.decode(content);
    }

    logs.add(entry);
    await file.writeAsString(json.encode(logs));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Entry saved')),
    );
  }

  void _shareEntry() {
    if (_diagnosis != null) {
      Share.share('Livestock Diagnosis:\n$_diagnosis\nNote: ${_noteController.text}');
    }
  }

  Widget _buildQuestion(String q) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(q, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Row(
          children: [
            Radio<String>(
              value: 'Yes',
              groupValue: _answers[q],
              onChanged: (val) => setState(() => _answers[q] = val),
            ),
            const Text('Yes'),
            Radio<String>(
              value: 'No',
              groupValue: _answers[q],
              onChanged: (val) => setState(() => _answers[q] = val),
            ),
            const Text('No'),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Livestock Diagnosis')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Capture Livestock Image'),
              onPressed: _pickImage,
            ),
            const SizedBox(height: 10),
            if (_image != null) Image.file(_image!, height: 200),
            if (_diagnosis != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(_diagnosis!, style: const TextStyle(fontSize: 16)),
              ),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: 'Add Notes'),
            ),
            const SizedBox(height: 16),
            ..._questions.map(_buildQuestion),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.check),
              label: const Text('Submit Diagnosis'),
              onPressed: _submitDiagnosis,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Save Entry'),
              onPressed: _saveEntry,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.share),
              label: const Text('Share Diagnosis'),
              onPressed: _shareEntry,
            ),
          ],
        ),
      ),
    );
  }
}
