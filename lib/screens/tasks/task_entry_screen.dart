import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:agrix_africa_adt2025/models/tasks/task.dart';
import 'package:agrix_africa_adt2025/services/tasks/task_service.dart';

class TaskEntryScreen extends StatefulWidget {
  const TaskEntryScreen({super.key});

  @override
  State<TaskEntryScreen> createState() => _TaskEntryScreenState();
}

class _TaskEntryScreenState extends State<TaskEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _taskTitle = TextEditingController();
  final _description = TextEditingController();
  String _status = 'Pending';

  @override
  void dispose() {
    _taskTitle.dispose();
    _description.dispose();
    super.dispose();
  }

  void _saveTask() async {
    if (_formKey.currentState!.validate()) {
      final task = Task(
        id: const Uuid().v4(),
        title: _taskTitle.text.trim(),
        description: _description.text.trim(),
        status: _status,
        createdAt: DateTime.now(),
      );
      await TaskService().saveTask(task);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Task saved successfully')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📝 Add Officer Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _taskTitle,
                decoration: const InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _description,
                decoration: const InputDecoration(
                  labelText: 'Task Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _status,
                items: ['Pending', 'In Progress', 'Completed']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => setState(() => _status = val!),
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save Task'),
                onPressed: _saveTask,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
