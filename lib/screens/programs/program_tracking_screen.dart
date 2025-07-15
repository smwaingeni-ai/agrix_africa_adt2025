import 'package:flutter/material.dart';
import 'package:agrix_africa_adt2025/models/programs/program_log.dart';
import 'package:agrix_africa_adt2025/services/programs/program_service.dart';

class ProgramTrackingScreen extends StatefulWidget {
  const ProgramTrackingScreen({super.key});

  @override
  State<ProgramTrackingScreen> createState() => _ProgramTrackingScreenState();
}

class _ProgramTrackingScreenState extends State<ProgramTrackingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _programController = TextEditingController();
  final TextEditingController _farmerController = TextEditingController();
  final TextEditingController _resourceController = TextEditingController();
  final TextEditingController _impactController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _officerController = TextEditingController();

  bool _submitting = false;

  Future<void> _trackProgram() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _submitting = true);

      final log = ProgramLog(
        programName: _programController.text.trim(),
        farmer: _farmerController.text.trim(),
        resource: _resourceController.text.trim(),
        impact: _impactController.text.trim(),
        region: _regionController.text.trim(),
        officer: _officerController.text.trim(),
        date: DateTime.now(),
      );

      await ProgramService().saveProgramLog(log);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Program successfully tracked')),
        );
        Navigator.pop(context);
      }

      setState(() => _submitting = false);
    }
  }

  @override
  void dispose() {
    _programController.dispose();
    _farmerController.dispose();
    _resourceController.dispose();
    _impactController.dispose();
    _regionController.dispose();
    _officerController.dispose();
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
                validator: (val) => val == null || val.trim().isEmpty ? 'Enter program name' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _farmerController,
                decoration: const InputDecoration(
                  labelText: 'Farmer / Community',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Enter recipient details' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _resourceController,
                decoration: const InputDecoration(
                  labelText: 'Resource Distributed',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Specify the resource' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _impactController,
                decoration: const InputDecoration(
                  labelText: 'Impact / Remarks',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (val) => val == null || val.trim().isEmpty ? 'Describe the impact or remarks' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _regionController,
                decoration: const InputDecoration(
                  labelText: 'Region/Province',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _officerController,
                decoration: const InputDecoration(
                  labelText: 'Officer Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton.icon(
                icon: _submitting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.track_changes),
                label: const Text('Track Program'),
                onPressed: _submitting ? null : _trackProgram,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
