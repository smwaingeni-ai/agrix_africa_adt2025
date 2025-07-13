import 'package:flutter/material.dart';

class ArexOfficerDashboard extends StatelessWidget {
  const ArexOfficerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardTiles = [
      {
        'icon': Icons.task,
        'label': 'Add Task',
        'route': '/task_entry',
      },
      {
        'icon': Icons.agriculture,
        'label': 'Field Assessment',
        'route': '/field_assessment',
      },
      {
        'icon': Icons.school,
        'label': 'Training Log',
        'route': '/training_log',
      },
      {
        'icon': Icons.assignment,
        'label': 'Program Tracking',
        'route': '/program_tracking',
      },
      {
        'icon': Icons.eco,
        'label': 'Sustainability Log',
        'route': '/sustainability_log',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('AREX Officer Dashboard'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: dashboardTiles.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final item = dashboardTiles[index];
          return ListTile(
            leading: Icon(item['icon'] as IconData, color: Colors.green),
            title: Text(item['label'] as String),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushNamed(context, item['route'] as String),
          );
        },
      ),
    );
  }
}
