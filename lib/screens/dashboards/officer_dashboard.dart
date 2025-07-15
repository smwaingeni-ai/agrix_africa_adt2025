import 'package:flutter/material.dart';

class OfficerDashboard extends StatelessWidget {
  const OfficerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🧑‍🌾 AREX Officer Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.assignment),
              label: const Text('View Tasks & Assignments'),
              onPressed: () {
                Navigator.pushNamed(context, '/officer/tasks');
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.search),
              label: const Text('Conduct Field Assessments'),
              onPressed: () {
                Navigator.pushNamed(context, '/officer/assessments');
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.track_changes),
              label: const Text('Program Tracking'),
              onPressed: () {
                Navigator.pushNamed(context, '/program_tracking');
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.eco),
              label: const Text('Sustainability Logs'),
              onPressed: () {
                Navigator.pushNamed(context, '/sustainability_logs');
              },
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            const Text(
              '📋 Monitor, guide, and empower farmers for impact and resilience. Use this panel to manage tasks, training, and program outcomes.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
