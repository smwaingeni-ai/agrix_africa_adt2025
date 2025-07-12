import 'package:flutter/material.dart';
import '../../models/contracts/contract_offer.dart';
import '../../services/contracts/contract_service.dart';
import 'contract_detail_screen.dart'; // Optional if needed

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
      appBar: AppBar(title: const Text('Contract Offers')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _contracts.isEmpty
              ? const Center(child: Text('No contract offers found.'))
              : ListView.builder(
                  itemCount: _contracts.length,
                  itemBuilder: (context, index) {
                    final contract = _contracts[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(contract.title),
                        subtitle: Text('Amount: \$${contract.amount.toStringAsFixed(2)}'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // Optionally navigate to detail screen
                          // Navigator.push(context, MaterialPageRoute(
                          //   builder: (_) => ContractDetailScreen(contract: contract),
                          // ));
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
