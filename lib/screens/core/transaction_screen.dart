import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  final String? result;

  const TransactionScreen({super.key, this.result});

  static const List<Map<String, dynamic>> _transactions = [
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
      case 'Completed':
        return Colors.green;
      case 'Pending':
        return Colors.orangeAccent;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Approved':
      case 'Completed':
        return Icons.check_circle;
      case 'Pending':
        return Icons.pending_actions;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💳 Transactions Log'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (result != null) // 🟢 Show result if passed
            Padding(
              padding: const EdgeInsets.all(12),
              child: MaterialBanner(
                backgroundColor: Colors.lightGreen.shade50,
                content: Text(result!, style: const TextStyle(fontSize: 16)),
                actions: [
                  TextButton(
                    onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                    child: const Text('DISMISS'),
                  ),
                ],
              ),
            ),
          Expanded(
            child: _transactions.isEmpty
                ? const Center(
                    child: Text(
                      'No transactions recorded yet.',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: _transactions.length,
                    separatorBuilder: (_, __) => const Divider(thickness: 0.7),
                    itemBuilder: (context, index) {
                      final txn = _transactions[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.receipt_long, color: Colors.green.shade700),
                          title: Text('${txn["type"]} • ${txn["farmer"]}'),
                          subtitle: Text(
                            '📅 ${txn["date"]}\n💵 \$${txn["amount"].toStringAsFixed(2)} • 🟢 Status: ${txn["status"]}',
                          ),
                          isThreeLine: true,
                          trailing: Icon(
                            _getStatusIcon(txn["status"]),
                            color: _getStatusColor(txn["status"]),
                            size: 28,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
