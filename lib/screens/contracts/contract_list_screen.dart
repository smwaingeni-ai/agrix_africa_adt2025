import 'package:flutter/material.dart';
import 'package:agrix_africa_adt2025/models/contracts/contract_offer.dart';
import 'package:agrix_africa_adt2025/services/contracts/contract_service.dart';
import 'contract_detail_screen.dart';

class ContractListScreen extends StatefulWidget {
  const ContractListScreen({super.key});

  @override
  State<ContractListScreen> createState() => _ContractListScreenState();
}

class _ContractListScreenState extends State<ContractListScreen> {
  List<ContractOffer> _contracts = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadContracts();
  }

  Future<void> _loadContracts() async {
    final contracts = await ContractService().loadContracts();
    setState(() {
      _contracts = contracts;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contract Farming Offers')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _contracts.isEmpty
              ? const Center(child: Text('No contract offers available.'))
              : ListView.builder(
                  itemCount: _contracts.length,
                  itemBuilder: (context, index) {
                    final contract = _contracts[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.handshake, color: Colors.green),
                        title: Text(contract.title),
                        subtitle: Text(
                          '${contract.cropOrLivestockType} • ${contract.location} • \$${contract.amount.toStringAsFixed(2)}',
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ContractDetailScreen(contract: contract),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/contracts/new'),
        child: const Icon(Icons.add),
        tooltip: 'Add Contract Offer',
      ),
    );
  }
}
