import 'package:flutter/material.dart';
import 'package:agrix_africa_adt2025/models/contracts/contract_offer.dart';
import 'package:agrix_africa_adt2025/services/contracts/contract_service.dart';

class ContractOfferFormScreen extends StatefulWidget {
  const ContractOfferFormScreen({super.key});

  @override
  State<ContractOfferFormScreen> createState() => _ContractOfferFormScreenState();
}

class _ContractOfferFormScreenState extends State<ContractOfferFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _contract = ContractOffer.empty();
  bool _submitting = false;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => _submitting = true);
    try {
      await ContractService().saveContract(_contract);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contract offer posted successfully!')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting contract: $e')),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Contract Offer')),
      body: _submitting
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    _buildTextField(
                      label: 'Contract Title',
                      onSaved: (val) => _contract.title = val ?? '',
                    ),
                    _buildTextField(
                      label: 'Parties Involved',
                      onSaved: (val) => _contract.parties = val ?? '',
                    ),
                    _buildTextField(
                      label: 'Amount (USD)',
                      keyboardType: TextInputType.number,
                      onSaved: (val) => _contract.amount = double.tryParse(val ?? '0') ?? 0.0,
                    ),
                    _buildTextField(
                      label: 'Duration (e.g. 12 months)',
                      onSaved: (val) => _contract.duration = val ?? '',
                      required: false,
                    ),
                    _buildTextField(
                      label: 'Crop or Livestock Type',
                      onSaved: (val) => _contract.cropOrLivestockType = val ?? '',
                    ),
                    _buildTextField(
                      label: 'Location',
                      onSaved: (val) => _contract.location = val ?? '',
                    ),
                    _buildTextField(
                      label: 'Contract Terms / Description',
                      onSaved: (val) => _contract.terms = val ?? '',
                      maxLines: 4,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitting ? null : _submitForm,
                      child: const Text('Submit Contract'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTextField({
    required String label,
    TextInputType keyboardType = TextInputType.text,
    required void Function(String?) onSaved,
    bool required = true,
    int maxLines = 1,
  }) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      maxLines: maxLines,
      onSaved: onSaved,
      validator: (val) {
        if (!required) return null;
        return (val == null || val.isEmpty) ? 'Required' : null;
      },
    );
  }
}
