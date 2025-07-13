import 'package:flutter/material.dart';

class SyncScreen extends StatelessWidget {
  const SyncScreen({super.key});

  void _simulateSync(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Data synchronized successfully'),
        duration: Duration(seconds: 2),
      ),
    );
    // 🔄 In future: Add real sync logic here (e.g., HTTP upload or cloud sync)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Synchronization')),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.sync),
          label: const Text('Sync Now'),
          onPressed: () => _simulateSync(context),
        ),
      ),
    );
  }
}
