import 'package:flutter/material.dart';
import '../../models/investment_offer.dart';
import '../../services/market_service.dart';

class InvestmentOfferScreen extends StatefulWidget {
  final String listingId;

  const InvestmentOfferScreen({super.key, required this.listingId});

  @override
  State<InvestmentOfferScreen> createState() => _InvestmentOfferScreenState();
}

class _InvestmentOfferScreenState extends State<InvestmentOfferScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _investorIdController = TextEditingController();
  String _currency = 'USD';
  int _durationMonths = 12;
  bool _submitting = false;

  Future<void> _submitOffer() async {
    if (!_formKey.currentState!.validate()) return;

    final offer = InvestmentOffer(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      listingId: widget.listingId,
      investorId: _investorIdController.text.trim(),
      amount: double.parse(_amountController.text.trim()),
      currency: _currency,
      durationMonths: _durationMonths,
      message: _messageController.text.trim(),
      offerDate: DateTime.now(),
      isAccepted: false,
    );

    setState(() => _submitting = true);
    await MarketService().addOffer(offer);
    setState(() => _submitting = false);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Investment offer submitted!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Investment Offer')),
      body: _submitting
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Text('📌 Listing ID: ${widget.listingId}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _investorIdController,
                      decoration: const InputDecoration(
                        labelText: 'Your Investor ID',
                        prefixIcon: Icon(Icons.perm_identity),
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) =>
                          val == null || val.trim().isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _amountController,
                      decoration: const InputDecoration(
                        labelText: 'Investment Amount',
                        prefixIcon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      validator: (val) => val == null || val.trim().isEmpty
                          ? 'Required'
                          : double.tryParse(val.trim()) == null
                              ? 'Enter valid number'
                              : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _currency,
                      items: ['USD', 'EUR', 'ZMW', 'KES', 'NGN']
                          .map((cur) =>
                              DropdownMenuItem(value: cur, child: Text(cur)))
                          .toList(),
                      decoration: const InputDecoration(
                        labelText: 'Currency',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (val) => setState(() {
                        _currency = val!;
                      }),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<int>(
                      value: _durationMonths,
                      decoration: const InputDecoration(
                        labelText: 'Duration (in months)',
                        border: OutlineInputBorder(),
                      ),
                      items: [6, 12, 24, 36, 60]
                          .map((m) =>
                              DropdownMenuItem(value: m, child: Text('$m')))
                          .toList(),
                      onChanged: (val) => setState(() {
                        _durationMonths = val!;
                      }),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        labelText: 'Message (optional)',
                        prefixIcon: Icon(Icons.message),
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.send),
                      label: const Text('Submit Offer'),
                      onPressed: _submitOffer,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
