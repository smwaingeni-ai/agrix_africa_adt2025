import 'package:flutter/material.dart';

class OfficerAssessmentsScreen extends StatefulWidget {
  const OfficerAssessmentsScreen({super.key});

  @override
  State<OfficerAssessmentsScreen> createState() => _OfficerAssessmentsScreenState();
}

class _OfficerAssessmentsScreenState extends State<OfficerAssessmentsScreen> {
  final List<Assessment> _assessments = [];
  final _formKey = GlobalKey<FormState>();

  String _activity = '';
  String _impact = '';
  String _recommendation = '';

  void _submitAssessment() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newAssessment = Assessment(
        activity: _activity,
        impact: _impact,
        recommendation: _recommendation,
        date: DateTime.now(),
      );

      setState(() {
        _assessments.insert(0, newAssessment); // insert newest at top
        _activity = '';
        _impact = '';
        _recommendation = '';
      });

      _formKey.currentState!.reset();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Assessment submitted')),
      );
    }
  }

  Widget _buildAssessmentCard(Assessment a) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: ListTile(
        title: Text(a.activity, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📍 Impact: ${a.impact}"),
            Text("📝 Recommendation: ${a.recommendation}"),
            Text("📅 Date: ${a.date.toLocal().toString().split(' ')[0]}"),
          ],
        ),
        leading: const Icon(Icons.fact_check, color: Colors.green),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🧑‍🌾 Officer Assessments'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              '📋 Submit Sustainability/Impact Assessment',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Activity Observed'),
                    onSaved: (val) => _activity = val ?? '',
                    validator: (val) => (val == null || val.isEmpty) ? 'Required' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Observed Impact'),
                    onSaved: (val) => _impact = val ?? '',
                    validator: (val) => (val == null || val.isEmpty) ? 'Required' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Recommendation'),
                    onSaved: (val) => _recommendation = val ?? '',
                    validator: (val) => (val == null || val.isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text('Submit Assessment'),
                    onPressed: _submitAssessment,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 1),
            const Text(
              '🗂️ Submitted Assessments',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _assessments.isEmpty
                  ? const Center(child: Text('📭 No assessments yet.'))
                  : ListView.builder(
                      itemCount: _assessments.length,
                      itemBuilder: (context, index) => _buildAssessmentCard(_assessments[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class Assessment {
  final String activity;
  final String impact;
  final String recommendation;
  final DateTime date;

  Assessment({
    required this.activity,
    required this.impact,
    required this.recommendation,
    required this.date,
  });
}
