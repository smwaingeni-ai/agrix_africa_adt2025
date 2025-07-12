import 'package:flutter/material.dart';

class TrainingLogScreen extends StatefulWidget {
  const TrainingLogScreen({super.key});

  @override
  State<TrainingLogScreen> createState() => _TrainingLogScreenState();
}

class _TrainingLogScreenState extends State<TrainingLogScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _topic = TextEditingController();
  final _audience = TextEditingController();
  final _outcome = TextEditingController();

  void _logTraining() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Training session logged')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📚 Training Log'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Event Title'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _topic,
                decoration: const InputDecoration(labelText: 'Topic'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _audience,
                decoration: const InputDecoration(labelText: 'Audience'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _outcome,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Outcome Summary'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save Training Log'),
                onPressed: _logTraining,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
