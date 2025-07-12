import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class FieldAssessmentScreen extends StatefulWidget {
  const FieldAssessmentScreen({super.key});

  @override
  State<FieldAssessmentScreen> createState() => _FieldAssessmentScreenState();
}

class _FieldAssessmentScreenState extends State<FieldAssessmentScreen> {
  final _crop = TextEditingController();
  final _observations = TextEditingController();
  final _recommendations = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  Future<void> _submitAssessment() async {
    if (!_formKey.currentState!.validate()) return;

    final assessment = {
      'id': _uuid.v4(),
      'timestamp': DateTime.now().toIso8601String(),
      'crop': _crop.text.trim(),
      'observations': _observations.text.trim(),
      'recommendations': _recommendations.text.trim(),
    };

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/field_assessments.json');

    List<dynamic> logs = [];
    if (await file.exists()) {
      final content = await file.readAsString();
      logs = json.decode(content);
    }

    logs.add(assessment);
    await file.writeAsString(json.encode(logs));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Field assessment saved successfully')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Field Assessment')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _crop,
                decoration: const InputDecoration(labelText: 'Crop Type'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _observations,
                decoration: const InputDecoration(labelText: 'Observations'),
                maxLines: 3,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _recommendations,
                decoration: const InputDecoration(labelText: 'Recommendations'),
                maxLines: 3,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Submit Assessment'),
                onPressed: _submitAssessment,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
