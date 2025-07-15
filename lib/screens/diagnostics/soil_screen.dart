import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class SoilScreen extends StatefulWidget {
  const SoilScreen({super.key});

  @override
  State<SoilScreen> createState() => _SoilScreenState();
}

class _SoilScreenState extends State<SoilScreen> {
  File? _image;
  String? _description;
  final TextEditingController _noteController = TextEditingController();

  final Map<String, String?> _answers = {};
  final List<String> _questions = [
    '1. Is the soil dry or cracking?',
    '2. Is there water logging or poor drainage?',
    '3. Are there visible signs of erosion?',
    '4. Is the soil color unusually pale or grayish?',
    '5. Have crops previously failed in this soil?',
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
        _description =
            "🧪 Based on image: Soil likely shows signs of nutrient deficiency (simulated)";
      });
    }
  }

  void _submitDiagnosis() {
    final allAnswered =
        _answers.length == _questions.length && !_answers.containsValue(null);
    if (!allAnswered) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('⚠️ Please answer all questions before submitting.')),
      );
      return;
    }

    final issues = _answers.values.where((a) => a == 'Yes').length;
    final result = issues >= 3
        ? '⚠️ Questionnaire: Soil health issues detected. Improve drainage, add compost, test pH.'
        : '✅ Questionnaire: Soil appears suitable for planting. Conduct a lab test to confirm.';

    setState(() => _description = result);
  }

  Future<void> _saveEntry() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/soil_log.json');

    final entry = {
      'timestamp': DateTime.now().toIso8601String(),
      'description': _description,
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
      const SnackBar(content: Text('✅ Entry saved to soil_log.json')),
    );
  }

  void _shareEntry() {
    if (_description != null) {
      Share.share(
          '🧾 Soil Diagnosis Result:\n$_description\n\nNote: ${_noteController.text}');
    }
  }

  Widget _buildQuestion(String question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question, style: const TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Radio<String>(
              value: 'Yes',
              groupValue: _answers[question],
              onChanged: (val) => setState(() => _answers[question] = val),
            ),
            const Text('Yes'),
            Radio<String>(
              value: 'No',
              groupValue: _answers[question],
              onChanged: (val) => setState(() => _answers[question] = val),
            ),
            const Text('No'),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Soil Diagnosis')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.photo),
              label: const Text('Upload Soil Image'),
              onPressed: _pickImage,
            ),
            const SizedBox(height: 10),
            if (_image != null) Image.file(_image!, height: 180),
            const Divider(),
            const Text('🧾 Answer Questionnaire',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ..._questions.map(_buildQuestion).toList(),
            ElevatedButton.icon(
              icon: const Icon(Icons.check_circle),
              label: const Text('Run Diagnosis'),
              onPressed: _submitDiagnosis,
            ),
            const Divider(),
            if (_description != null) ...[
              Text(_description!, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 12),
              TextField(
                controller: _noteController,
                decoration:
                    const InputDecoration(labelText: 'Add Notes (Optional)'),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save Result'),
                onPressed: _saveEntry,
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.share),
                label: const Text('Share'),
                onPressed: _shareEntry,
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.support_agent),
                label: const Text('Escalate to AgriX'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('📨 Sent to AgriX support')),
                  );
                },
              ),
            ]
          ],
        ),
      ),
    );
  }
}
