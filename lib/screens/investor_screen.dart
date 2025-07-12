import 'package:flutter/material.dart';
import '../models/investor_profile.dart';
import '../services/investor_service.dart';

class InvestorScreen extends StatefulWidget {
  const InvestorScreen({super.key});

  @override
  State<InvestorScreen> createState() => _InvestorScreenState();
}

class _InvestorScreenState extends State<InvestorScreen> {
  final _formKey = GlobalKey<FormState>();
  late InvestorProfile _investor;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _investor = InvestorProfile.empty(); // requires .empty() factory in your model
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => _submitting = true);
    await InvestorService.saveInvestorProfile(_investor); // expects static method
    setState(() => _submitting = false);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Investor profile submitted successfully!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register as Investor')),
      body: _submitting
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (val) => _investor.name = val ?? '',
                      validator: (val) =>
                          val == null || val.trim().isEmpty ? 'Full name is required' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (val) => _investor.email = val ?? '',
                      validator: (val) =>
                          val == null || !val.contains('@') ? 'Enter a valid email' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      onSaved: (val) => _investor.phone = val ?? '',
                      validator: (val) =>
                          val == null || val.trim().isEmpty ? 'Phone number required' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Areas of Interest (e.g., Crops, Livestock)',
                        prefixIcon: Icon(Icons.interests),
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (val) => _investor.interestAreas = val ?? '',
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.save),
                      label: const Text('Submit Investor Profile'),
                      onPressed: _submitForm,
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
