import 'package:flutter/material.dart';

class ProgramTrackingScreen extends StatefulWidget {
  const ProgramTrackingScreen({super.key});

  @override
  State<ProgramTrackingScreen> createState() => _ProgramTrackingScreenState();
}

class _ProgramTrackingScreenState extends State<ProgramTrackingScreen> {
  final TextEditingController _programController = TextEditingController();
  final TextEditingController _farmerController = TextEditingController();
  final TextEditingController _resourceController = TextEditingController();
  final TextEditingController _impactController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _trackProgram() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Program successfully tracked')),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _programController.dispose();
    _farmerController.dispose();
    _resourceController.dispose();
    _impactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📊 Program Tracking')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Track Agricultural Program Impact',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _programController,
                decoration: const InputDecoration(
                  labelText: 'Program Name',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Enter program name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _farmerController,
                decoration: const InputDecoration(
                  labelText: 'Farmer / Community',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Enter recipient details' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _resourceController,
                decoration: const InputDecoration(
                  labelText: 'Resource Distributed',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Specify the resource' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _impactController,
                decoration: const InputDecoration(
                  labelText: 'Impact / Remarks',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (val) => val == null || val.isEmpty ? 'Describe the impact or remarks' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.track_changes),
                label: const Text('Track Program'),
                onPressed: _trackProgram,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
