import 'package:flutter/material.dart';
import 'package:agrix_africa_adt2025/models/investments/investment_offer.dart';
import 'package:agrix_africa_adt2025/services/market_service.dart';

class InvestmentOffersScreen extends StatefulWidget {
  const InvestmentOffersScreen({super.key});

  @override
  State<InvestmentOffersScreen> createState() => _InvestmentOffersScreenState();
}

class _InvestmentOffersScreenState extends State<InvestmentOffersScreen> {
  List<InvestmentOffer> _offers = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadOffers();
  }

  Future<void> _loadOffers() async {
    try {
      final data = await MarketService.loadOffers(); // static method in service
      setState(() {
        _offers = data;
        _loading = false;
      });
    } catch (e) {
      debugPrint("❌ Error loading offers: $e");
      setState(() {
        _offers = [];
        _loading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Error loading investment offers')),
        );
      }
    }
  }

  Widget _buildOfferCard(InvestmentOffer offer) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '👤 Investor: ${offer.investorName}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 6),
            Text('📞 Contact: ${offer.contact}'),
            Text('💰 Amount: \$${offer.amount.toStringAsFixed(2)}'),
            Text('📈 Rate: ${offer.interestRate}%'),
            Text('⏳ Term: ${offer.term}'),
            Text('📊 Status: ${offer.isAccepted ? "✅ Accepted" : "⏳ Pending"}'),
            Text('🕒 Date: ${offer.timestamp.toLocal().toString().split('.')[0]}'),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('📞 Contact feature coming soon')),
                  );
                },
                icon: const Icon(Icons.phone_forwarded),
                label: const Text("Contact"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💼 Investment Offers'),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _offers.isEmpty
              ? const Center(child: Text('🚫 No investment offers available'))
              : RefreshIndicator(
                  onRefresh: _loadOffers,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: _offers.length,
                    itemBuilder: (context, index) =>
                        _buildOfferCard(_offers[index]),
                  ),
                ),
    );
  }
}
