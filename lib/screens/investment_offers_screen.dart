import 'package:flutter/material.dart';
import '../models/investment_offer.dart';
import '../services/market_service.dart';

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
      final data = await MarketService().loadOffers();
      setState(() {
        _offers = data;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _offers = [];
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error loading investment offers')),
      );
    }
  }

  Widget _buildOfferCard(InvestmentOffer offer) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: const Icon(Icons.monetization_on, size: 36, color: Colors.green),
        title: Text(
          offer.investorName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('📌 Listing ID: ${offer.listingId}'),
              Text('💵 Amount: ${offer.amount}'),
              Text('⏳ Term: ${offer.term}'),
              Text('📊 Status: ${offer.status}'),
              const SizedBox(height: 6),
              Text('📝 ${offer.message}'),
            ],
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.phone_forwarded, color: Colors.blue),
          tooltip: 'Contact Investor',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('📞 Contact feature coming soon')),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investment Offers'),
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
