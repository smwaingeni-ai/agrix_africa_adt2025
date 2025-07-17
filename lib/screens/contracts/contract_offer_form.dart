import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../models/contracts/contract_offer.dart';
import '../../services/contracts/contract_service.dart';

class ContractOfferForm extends StatefulWidget {
  const ContractOfferForm({super.key});

  @override
  State<ContractOfferForm> createState() => _ContractOfferFormState();
}

class _ContractOfferFormState extends State<ContractOfferForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _paymentTermsController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _partiesController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _cropTypeController = TextEditingController();
  final TextEditingController _termsController = TextEditingController();

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

  void _submit() async {
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
            .trim()
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
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
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value!.isEmpty ? 'Title is required' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) =>
                    value!.isEmpty ? 'Description is required' : null,
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
                validator: (value) =>
                    value!.isEmpty ? 'Contact is required' : null,
              ),
              TextFormField(
                controller: _partiesController,
                decoration: const InputDecoration(
                    labelText: 'Parties (comma-separated)'),
                validator: (value) =>
                    value!.isEmpty ? 'At least one party is required' : null,
              ),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _cropTypeController,
                decoration:
                    const InputDecoration(labelText: 'Crop/Livestock Type'),
              ),
              TextFormField(
                controller: _termsController,
                decoration: const InputDecoration(labelText: 'Contract Terms'),
              ),
              SwitchListTile(
                title: const Text('Is Active?'),
                value: _isActive,
                onChanged: (val) => setState(() => _isActive = val),
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
