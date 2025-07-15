import 'package:flutter/material.dart';

class OfficerTask {
  final String title;
  final String description;
  String status;

  OfficerTask({
    required this.title,
    required this.description,
    this.status = 'Pending',
  });
}

class OfficerTasksScreen extends StatefulWidget {
  const OfficerTasksScreen({super.key});

  @override
  State<OfficerTasksScreen> createState() => _OfficerTasksScreenState();
}

class _OfficerTasksScreenState extends State<OfficerTasksScreen> {
  final List<OfficerTask> _tasks = [
    OfficerTask(
      title: '🧪 Inspect Field in Region A',
      description: 'Check maize crop progress and pest control.',
      status: 'Pending',
    ),
    OfficerTask(
      title: '🐄 Monitor Livestock Health',
      description: 'Review cattle health reports from Farm B.',
      status: 'In Progress',
    ),
    OfficerTask(
      title: '📦 Verify Input Distribution',
      description: 'Ensure fertilizer delivery was completed.',
      status: 'Completed',
    ),
  ];

  void _markTaskAsCompleted(int index) {
    setState(() {
      _tasks[index].status = 'Completed';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '✅ Task "${_tasks[index].title}" marked as completed.',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'In Progress':
        return Colors.orange;
      case 'Pending':
      default:
        return Colors.redAccent;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Completed':
        return Icons.check_circle;
      case 'In Progress':
        return Icons.timelapse;
      case 'Pending':
      default:
        return Icons.pending_actions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AREX Officer: Task Log'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          final status = task.status;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 2,
            child: ListTile(
              leading: Icon(_getStatusIcon(status), color: _getStatusColor(status)),
              title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(task.description),
              trailing: Text(
                status,
                style: TextStyle(
                  color: _getStatusColor(status),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: status != 'Completed' ? () => _markTaskAsCompleted(index) : null,
            ),
          );
        },
      ),
    );
  }
}
