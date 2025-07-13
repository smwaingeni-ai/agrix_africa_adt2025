import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class CropsScreen extends StatefulWidget {
  const CropsScreen({super.key});

  @override
  State<CropsScreen> createState() => _CropsScreenState();
}

class _CropsScreenState extends State<CropsScreen> {
  File? _image;
  String? _description;
  final TextEditingController _noteController = TextEditingController();

  final Map<String, String?> _answers = {};
  final List<String> _questions = [
    '1. Are there visible spots on the leaves?',
    '2. Do the stems show any signs of rotting?',
    '3. Are the plants wilting or yellowing?',
    '4. Are pests or insects visible?',
    '5. Has there been stunted growth recently?',
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
        _description = "🚨 Crop symptoms suggest fungal infection or nutrient stress (Simulated)";
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
    final diagnosis = issues >= 3
        ? '❗ Likely crop stress or disease. Recommend treatment with organic pesticide and balanced fertilization.'
        : '✅ Crops appear healthy. Maintain regular checks and irrigation.';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Crop Diagnosis'),
        content: Text(diagnosis),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  Future<void> _saveEntry() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/crops_log.json');

    final entry = {
      'timestamp': DateTime.now().toIso8601String(),
      'description': _description ?? '',
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
      const SnackBar(content: Text('✅ Crop diagnosis saved.')),
    );
  }

  void _shareEntry() {
    if (_description != null) {
      Share.share('📋 Crop Diagnosis Result:\n$_description\n\n📝 Note: ${_noteController.text}');
    }
  }

  Widget _buildQuestion(String question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crop Diagnosis')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.photo),
              label: const Text('Upload Crop Image'),
              onPressed: _pickImage,
            ),
            const SizedBox(height: 10),
            if (_image != null) Image.file(_image!, height: 180),
            if (_description != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(_description!, style: const TextStyle(fontSize: 16)),
              ),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: 'Add Notes'),
            ),
            const SizedBox(height: 16),
            ..._questions.map(_buildQuestion),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.check),
              label: const Text('Submit Diagnosis'),
              onPressed: _submitDiagnosis,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Save Result'),
              onPressed: _saveEntry,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.share),
              label: const Text('Share'),
              onPressed: _shareEntry,
            ),
          ],
        ),
      ),
    );
  }
}
