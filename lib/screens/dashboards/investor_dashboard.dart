import 'package:flutter/material.dart';

class InvestorDashboard extends StatelessWidget {
  const InvestorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💼 Investor Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.list_alt),
              label: const Text('View Investment Offers'),
              onPressed: () {
                Navigator.pushNamed(context, '/investments');
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Submit New Offer'),
              onPressed: () {
                Navigator.pushNamed(context, '/investment_offer_form');
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.people_outline),
              label: const Text('Investor Directory'),
              onPressed: () {
                Navigator.pushNamed(context, '/investor_list');
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.person_add_alt_1),
              label: const Text('Register as Investor'),
              onPressed: () {
                Navigator.pushNamed(context, '/investor_register');
              },
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            const Text(
              '💡 Use this dashboard to explore opportunities, contribute capital, and collaborate with farmers and ministries for sustainable growth.',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
