import 'package:flutter/material.dart';
import 'package:agrix_africa_adt2025/models/contracts/contract_offer.dart';
import 'package:agrix_africa_adt2025/services/contracts/contract_service.dart';
import 'package:agrix_africa_adt2025/screens/contracts/contract_detail_screen.dart';
import 'package:agrix_africa_adt2025/screens/contracts/contract_applications_list.dart';

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
    final contracts = await ContractService().loadOffers(); // ✅ Correct method
    setState(() {
      _contracts = contracts;
      _loading = false;
    });
  }

  void _viewDetails(ContractOffer offer) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ContractDetailScreen(contract: offer)),
    );
  }

  void _viewApplicants(ContractOffer offer) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ContractApplicationsListScreen(offer: offer)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📄 Contract Farming Offers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reload Contracts',
            onPressed: _loadContracts,
          ),
        ],
      ),
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
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'details') _viewDetails(contract);
                            if (value == 'applicants') _viewApplicants(contract);
                          },
                          itemBuilder: (_) => const [
                            PopupMenuItem(value: 'details', child: Text('View Details')),
                            PopupMenuItem(value: 'applicants', child: Text('View Applicants')),
                          ],
                        ),
                        onTap: () => _viewDetails(contract),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/contracts/new'),
        tooltip: 'Add Contract Offer',
        child: const Icon(Icons.add),
      ),
    );
  }
}
