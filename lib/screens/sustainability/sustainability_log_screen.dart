import 'package:flutter/material.dart';
import 'package:agrix_africa_adt2025/models/sustainability/sustainability_log.dart';
import 'package:agrix_africa_adt2025/services/sustainability/sustainability_service.dart';

class SustainabilityLogScreen extends StatefulWidget {
  const SustainabilityLogScreen({super.key});

  @override
  State<SustainabilityLogScreen> createState() => _SustainabilityLogScreenState();
}

class _SustainabilityLogScreenState extends State<SustainabilityLogScreen> {
  final _formKey = GlobalKey<FormState>();
  final _activityController = TextEditingController();
  final _impactController = TextEditingController();
  final _regionController = TextEditingController();

  List<SustainabilityLog> _logs = [];

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  Future<void> _loadLogs() async {
    final logs = await SustainabilityService().loadLogs();
    setState(() => _logs = logs);
  }

  Future<void> _saveLog() async {
    if (!_formKey.currentState!.validate()) return;

    final log = SustainabilityLog(
      activity: _activityController.text.trim(),
      impact: _impactController.text.trim(),
      region: _regionController.text.trim(),
      date: DateTime.now(),
    );

    await SustainabilityService().saveLog(log);

    _activityController.clear();
    _impactController.clear();
    _regionController.clear();
    _loadLogs();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Sustainability log saved')),
    );
  }

  @override
  void dispose() {
    _activityController.dispose();
    _impactController.dispose();
    _regionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🌿 Sustainability Logs')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Log a New Activity',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: _activityController,
                    decoration: const InputDecoration(labelText: 'Activity', border: OutlineInputBorder()),
                    validator: (val) => val == null || val.trim().isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: _impactController,
                    decoration: const InputDecoration(labelText: 'Impact', border: OutlineInputBorder()),
                    validator: (val) => val == null || val.trim().isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: _regionController,
                    decoration: const InputDecoration(labelText: 'Region / Officer', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 16),

                  ElevatedButton.icon(
                    onPressed: _saveLog,
                    icon: const Icon(Icons.save),
                    label: const Text('Save Log'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Divider(),
            const Text(
              '📘 Sustainability Log History',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: _logs.isEmpty
                  ? const Center(child: Text('📭 No logs yet.'))
                  : ListView.builder(
                      itemCount: _logs.length,
                      itemBuilder: (context, index) {
                        final log = _logs[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: const Icon(Icons.eco, color: Colors.green),
                            title: Text(log.activity),
                            subtitle: Text("🌍 ${log.region}\n📝 ${log.impact}"),
                            trailing: Text(
                              "${log.date.day}/${log.date.month}/${log.date.year}",
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
