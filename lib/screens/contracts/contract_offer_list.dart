import 'package:flutter/material.dart';
import '../../models/contracts/contract_offer.dart';
import '../../services/contracts/contract_service.dart';
import 'contract_detail_screen.dart';

class ContractOfferListScreen extends StatefulWidget {
  const ContractOfferListScreen({super.key});

  @override
  State<ContractOfferListScreen> createState() => _ContractOfferListScreenState();
}

class _ContractOfferListScreenState extends State<ContractOfferListScreen> {
  List<ContractOffer> _offers = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadOffers();
  }

  Future<void> _loadOffers() async {
    setState(() => _loading = true);
    try {
      final offers = await ContractService().loadContracts();
      setState(() {
        _offers = offers;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading contracts: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contract Farming Offers')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _offers.isEmpty
              ? const Center(child: Text("No contract offers available."))
              : ListView.builder(
                  itemCount: _offers.length,
                  itemBuilder: (context, index) {
                    final offer = _offers[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.handshake, color: Colors.green),
                        title: Text(offer.title),
                        subtitle: Text("${offer.cropOrLivestockType} • ${offer.location}"),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ContractDetailScreen(contract: offer),
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
