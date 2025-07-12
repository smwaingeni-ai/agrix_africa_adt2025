import 'package:flutter/material.dart';
import '../../models/contracts/contract_offer.dart';
import '../../services/contracts/contract_application_service.dart';

class ContractApplyScreen extends StatefulWidget {
  final ContractOffer offer;

  const ContractApplyScreen({super.key, required this.offer});

  @override
  State<ContractApplyScreen> createState() => _ContractApplyScreenState();
}

class _ContractApplyScreenState extends State<ContractApplyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _farmerNameController = TextEditingController();
  final _farmLocationController = TextEditingController();
  final _contactInfoController = TextEditingController();
  final _notesController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submitApplication() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    await ContractApplicationService().saveApplication(
      offerId: widget.offer.id,
      farmerName: _farmerNameController.text.trim(),
      farmLocation: _farmLocationController.text.trim(),
      contactInfo: _contactInfoController.text.trim(),
      notes: _notesController.text.trim(),
    );

    setState(() => _isSubmitting = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Application submitted successfully!")),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _farmerNameController.dispose();
    _farmLocationController.dispose();
    _contactInfoController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final offer = widget.offer;

    return Scaffold(
      appBar: AppBar(
        title: Text('Apply to "${offer.title}"'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _farmerNameController,
                decoration: const InputDecoration(labelText: 'Farmer Name'),
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
              ),
              TextFormField(
                controller: _farmLocationController,
                decoration: const InputDecoration(labelText: 'Farm Location'),
                validator: (value) => value!.isEmpty ? 'Enter farm location' : null,
              ),
              TextFormField(
                controller: _contactInfoController,
                decoration: const InputDecoration(labelText: 'Contact Info (Phone/Email)'),
                validator: (value) => value!.isEmpty ? 'Provide a way to contact you' : null,
              ),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Additional Notes (Optional)'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: Text(_isSubmitting ? 'Submitting...' : 'Submit Application'),
                onPressed: _isSubmitting ? null : _submitApplication,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
