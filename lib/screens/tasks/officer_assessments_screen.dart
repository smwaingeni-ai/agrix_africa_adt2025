import 'package:flutter/material.dart';
import 'package:agrix_africa_adt2025/models/tasks/officer_assessment.dart';
import 'package:agrix_africa_adt2025/services/tasks/assessment_service.dart';

class OfficerAssessmentsScreen extends StatefulWidget {
  const OfficerAssessmentsScreen({super.key});

  @override
  State<OfficerAssessmentsScreen> createState() => _OfficerAssessmentsScreenState();
}

class _OfficerAssessmentsScreenState extends State<OfficerAssessmentsScreen> {
  final List<OfficerAssessment> _assessments = [];
  final _formKey = GlobalKey<FormState>();

  String _activity = '';
  String _impact = '';
  String _recommendation = '';

  @override
  void initState() {
    super.initState();
    _loadAssessments();
  }

  Future<void> _loadAssessments() async {
    final data = await AssessmentService().loadAssessments();
    setState(() => _assessments.addAll(data));
  }

  void _submitAssessment() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newAssessment = OfficerAssessment(
        activity: _activity.trim(),
        impact: _impact.trim(),
        recommendation: _recommendation.trim(),
        date: DateTime.now(),
      );

      await AssessmentService().saveAssessment(newAssessment);

      setState(() {
        _assessments.insert(0, newAssessment);
        _activity = '';
        _impact = '';
        _recommendation = '';
      });

      _formKey.currentState!.reset();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Assessment submitted')),
      );
    }
  }

  Widget _buildAssessmentCard(OfficerAssessment a) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: ListTile(
        title: Text(a.activity, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
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
                    decoration: const InputDecoration(
                      labelText: 'Activity Observed',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (val) => _activity = val ?? '',
                    validator: (val) => (val == null || val.trim().isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Observed Impact',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (val) => _impact = val ?? '',
                    validator: (val) => (val == null || val.trim().isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Recommendation',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (val) => _recommendation = val ?? '',
                    validator: (val) => (val == null || val.trim().isEmpty) ? 'Required' : null,
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
