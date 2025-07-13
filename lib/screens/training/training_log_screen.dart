import 'package:flutter/material.dart';
import '../../models/training/training_log.dart';
import '../../services/training/training_log_service.dart';

class TrainingLogScreen extends StatefulWidget {
  const TrainingLogScreen({super.key});

  @override
  State<TrainingLogScreen> createState() => _TrainingLogScreenState();
}

class _TrainingLogScreenState extends State<TrainingLogScreen> {
  final _formKey = GlobalKey<FormState>();
  final _topicController = TextEditingController();
  final _trainerController = TextEditingController();
  final _participantsController = TextEditingController();
  final _regionController = TextEditingController();
  final List<TrainingLog> _logs = [];

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  Future<void> _loadLogs() async {
    final logs = await TrainingLogService().loadLogs();
    setState(() => _logs.addAll(logs));
  }

  Future<void> _saveLog() async {
    if (!_formKey.currentState!.validate()) return;

    final log = TrainingLog(
      topic: _topicController.text.trim(),
      trainer: _trainerController.text.trim(),
      participants: int.tryParse(_participantsController.text) ?? 0,
      region: _regionController.text.trim(),
      date: DateTime.now(),
    );

    await TrainingLogService().saveLog(log);
    setState(() {
      _logs.insert(0, log);
      _topicController.clear();
      _trainerController.clear();
      _participantsController.clear();
      _regionController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Training log saved')),
    );
  }

  Widget _buildLogCard(TrainingLog log) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: ListTile(
        title: Text(log.topic, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("👨‍🏫 Trainer: ${log.trainer}"),
            Text("👥 Participants: ${log.participants}"),
            Text("🌍 Region: ${log.region}"),
            Text("📅 Date: ${log.date.toLocal().toString().split(' ')[0]}"),
          ],
        ),
        leading: const Icon(Icons.school, color: Colors.blue),
      ),
    );
  }

  @override
  void dispose() {
    _topicController.dispose();
    _trainerController.dispose();
    _participantsController.dispose();
    _regionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📚 Training Logs'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Export to CSV',
            onPressed: () {
              // Trigger export via backend or external share
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('📤 Export will be available via system backend')));
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            '📝 Log New Training',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _topicController,
                  decoration: const InputDecoration(labelText: 'Training Topic'),
                  validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _trainerController,
                  decoration: const InputDecoration(labelText: 'Trainer Name'),
                  validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _participantsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'No. of Participants'),
                  validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _regionController,
                  decoration: const InputDecoration(labelText: 'Region'),
                  validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Save Log'),
                  onPressed: _saveLog,
                ),
              ],
            ),
          ),
          const Divider(height: 32),
          const Text(
            '📖 Submitted Logs',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          ..._logs.map(_buildLogCard).toList(),
        ],
      ),
    );
  }
}
