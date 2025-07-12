// ✅ trader_dashboard.dart
// Path: lib/screens/dashboards/trader_dashboard.dart
import 'package:flutter/material.dart';

class TraderDashboard extends StatelessWidget {
  const TraderDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trader Dashboard'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Trader Dashboard!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
