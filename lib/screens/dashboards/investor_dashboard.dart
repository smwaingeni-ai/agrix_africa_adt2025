import 'package:flutter/material.dart';

class InvestorDashboard extends StatelessWidget {
  const InvestorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Investor Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.list),
            label: const Text('View Investment Offers'),
            onPressed: () {
              Navigator.pushNamed(context, '/investments');
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Submit New Offer'),
            onPressed: () {
              Navigator.pushNamed(context, '/investment_offer_form');
            },
          ),
        ],
      ),
    );
  }
}
