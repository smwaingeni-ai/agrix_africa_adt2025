// ✅ investor_dashboard.dart
// Path: lib/screens/dashboards/investor_dashboard.dart
import 'package:flutter/material.dart';

class InvestorDashboard extends StatelessWidget {
  const InvestorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investor Dashboard'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Investor Dashboard!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
