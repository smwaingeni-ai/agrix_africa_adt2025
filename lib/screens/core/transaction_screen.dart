import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  final List<Map<String, dynamic>> _transactions = const [
    {
      "date": "2025-07-01",
      "farmer": "Alice Mwale",
      "type": "Subsidy",
      "amount": 200.0,
      "status": "Approved",
    },
    {
      "date": "2025-07-05",
      "farmer": "Banda Phiri",
      "type": "Loan Application",
      "amount": 500.0,
      "status": "Pending",
    },
    {
      "date": "2025-07-10",
      "farmer": "Chipo Nkomo",
      "type": "Input Purchase",
      "amount": 150.0,
      "status": "Completed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💳 Transactions Log'),
        centerTitle: true,
      ),
      body: _transactions.isEmpty
          ? const Center(child: Text('No transactions recorded yet.'))
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: _transactions.length,
              separatorBuilder: (_, __) => const Divider(thickness: 0.8),
              itemBuilder: (context, index) {
                final txn = _transactions[index];
                return ListTile(
                  leading: const Icon(Icons.receipt_long, color: Colors.green),
                  title: Text('${txn["type"]} • ${txn["farmer"]}'),
                  subtitle: Text(
                      'Date: ${txn["date"]}\nAmount: \$${txn["amount"]} • Status: ${txn["status"]}'),
                  isThreeLine: true,
                  trailing: Icon(
                    txn["status"] == "Approved" || txn["status"] == "Completed"
                        ? Icons.check_circle
                        : Icons.pending,
                    color: txn["status"] == "Approved" || txn["status"] == "Completed"
                        ? Colors.green
                        : Colors.orangeAccent,
                  ),
                );
              },
            ),
    );
  }
}
