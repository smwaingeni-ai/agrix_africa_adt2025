import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:agrix_africa_adt2025/models/contracts/contract_offer.dart';
import 'package:agrix_africa_adt2025/services/contracts/contract_service.dart';

class ContractOfferForm extends StatefulWidget {
  const ContractOfferForm({super.key});

  @override
  State<ContractOfferForm> createState() => _ContractOfferFormState();
}

class _ContractOfferFormState extends State<ContractOfferForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _durationController = TextEditingController();
  final _paymentTermsController = TextEditingController();
  final _contactController = TextEditingController();
  final _partiesController = TextEditingController();
  final _amountController = TextEditingController();
  final _cropTypeController = TextEditingController();
  final _termsController = TextEditingController();

  bool _isActive = true;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _durationController.dispose();
    _paymentTermsController.dispose();
    _contactController.dispose();
    _partiesController.dispose();
    _amountController.dispose();
    _cropTypeController.dispose();
    _termsController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final offer = ContractOffer(
        id: const Uuid().v4(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        location: _locationController.text.trim(),
        duration: _durationController.text.trim(),
        paymentTerms: _paymentTermsController.text.trim(),
        contact: _contactController.text.trim(),
        parties: _partiesController.text
            .split(',')
            .map((p) => p.trim())
            .where((p) => p.isNotEmpty)
            .toList(),
        amount: double.tryParse(_amountController.text.trim()) ?? 0.0,
        cropOrLivestockType: _cropTypeController.text.trim(),
        terms: _termsController.text.trim(),
        isActive: _isActive,
        postedAt: DateTime.now(),
      );

      await ContractService.addContractOffer(offer);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contract offer saved successfully')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Contract Offer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value == null || value.isEmpty ? 'Title is required' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => value == null || value.isEmpty ? 'Description is required' : null,
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(labelText: 'Duration'),
              ),
              TextFormField(
                controller: _paymentTermsController,
                decoration: const InputDecoration(labelText: 'Payment Terms'),
              ),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(labelText: 'Contact'),
                validator: (value) => value == null || value.isEmpty ? 'Contact is required' : null,
              ),
              TextFormField(
                controller: _partiesController,
                decoration: const InputDecoration(labelText: 'Parties (comma-separated)'),
                validator: (value) => value == null || value.isEmpty ? 'At least one party is required' : null,
              ),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _cropTypeController,
                decoration: const InputDecoration(labelText: 'Crop/Livestock Type'),
              ),
              TextFormField(
                controller: _termsController,
                decoration: const InputDecoration(labelText: 'Contract Terms'),
              ),
              SwitchListTile(
                title: const Text('Is Active?'),
                value: _isActive,
                onChanged: (value) => setState(() => _isActive = value),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Save Contract'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
