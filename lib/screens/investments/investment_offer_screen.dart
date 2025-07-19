import 'package:flutter/material.dart';
import 'package:agrix_africa_adt2025/models/investments/investment_horizon.dart';
import 'package:agrix_africa_adt2025/models/investments/investment_offer.dart';
import 'package:agrix_africa_adt2025/services/market/market_service.dart';

class InvestmentOfferForm extends StatefulWidget {
  const InvestmentOfferForm({super.key});

  @override
  State<InvestmentOfferForm> createState() => _InvestmentOfferFormState();
}

class _InvestmentOfferFormState extends State<InvestmentOfferForm> {
  final _formKey = GlobalKey<FormState>();

  String _investorId = '';
  String _investorName = '';
  String _contact = '';
  double _amount = 0.0;
  double _interestRate = 0.0;
  InvestmentHorizon? _selectedHorizon;

  Future<void> _submitOffer() async {
    if (_formKey.currentState!.validate() && _selectedHorizon != null) {
      _formKey.currentState!.save();

      final now = DateTime.now();
      final offer = InvestmentOffer(
        id: now.millisecondsSinceEpoch.toString(),
        listingId: 'listing_${now.millisecondsSinceEpoch}',
        investorId: _investorId,
        investorName: _investorName,
        amount: _amount,
        term: _selectedHorizon!.code,
        interestRate: _interestRate,
        isAccepted: false,
        contact: _contact,
        timestamp: now,
      );

      await MarketService.addOffer(offer);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Investment offer submitted!")),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('💰 Investment Offer')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Investor ID'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Enter investor ID' : null,
              onSaved: (value) => _investorId = value!.trim(),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Investor Name'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Enter name' : null,
              onSaved: (value) => _investorName = value!.trim(),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Contact'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Enter contact' : null,
              onSaved: (value) => _contact = value!.trim(),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Amount (USD)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                final parsed = double.tryParse(value ?? '');
                return (parsed == null || parsed <= 0)
                    ? 'Enter valid amount'
                    : null;
              },
              onSaved: (value) => _amount = double.parse(value!),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Interest Rate (%)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                final parsed = double.tryParse(value ?? '');
                return (parsed == null || parsed < 0)
                    ? 'Enter valid interest rate'
                    : null;
              },
              onSaved: (value) => _interestRate = double.parse(value!),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<InvestmentHorizon>(
              decoration: const InputDecoration(labelText: 'Investment Term'),
              value: _selectedHorizon,
              items: InvestmentHorizon.values
                  .map((horizon) => DropdownMenuItem(
                        value: horizon,
                        child: Text(horizon.label),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedHorizon = value!;
                });
              },
              validator: (value) =>
                  value == null ? 'Select an investment term' : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('Submit Offer'),
              onPressed: _submitOffer,
            ),
          ]),
        ),
      ),
    );
  }
}
