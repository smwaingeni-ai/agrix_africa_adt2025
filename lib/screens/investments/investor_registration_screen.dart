import 'package:flutter/material.dart';
import 'package:agrix_africa_adt2025/models/investment_offer.dart';
import 'package:agrix_africa_adt2025/services/market_service.dart';

class InvestorRegistrationScreen extends StatefulWidget {
  const InvestorRegistrationScreen({super.key});

  @override
  State<InvestorRegistrationScreen> createState() => _InvestorRegistrationScreenState();
}

class _InvestorRegistrationScreenState extends State<InvestorRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();

  final List<InvestmentHorizon> _selectedHorizons = [];
  final List<String> _selectedInterests = [];
  InvestorStatus _status = InvestorStatus.indifferent;
  String _selectedCountry = 'Zambia';

  final List<String> _interestOptions = ['Crops', 'Livestock', 'Land', 'Equipment', 'Services'];
  final List<String> _countryOptions = ['Zambia', 'Zimbabwe', 'Kenya', 'Nigeria', 'Ghana'];

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final newInvestor = InvestorProfile(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        contactNumber: _contactController.text.trim(),
        location: _selectedCountry,
        preferredHorizons: _selectedHorizons,
        status: _status,
        interests: _selectedInterests,
        registeredAt: DateTime.now(),
      );

      await InvestorService().addInvestor(newInvestor);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Investor registered successfully')),
        );
        Navigator.pop(context);
      }
    }
  }

  Widget _buildHorizonChips() {
    return Wrap(
      spacing: 8,
      children: InvestmentHorizon.values.map((horizon) {
        final selected = _selectedHorizons.contains(horizon);
        final label = horizon.name.replaceAll('Term', '-term').replaceAllMapped(
              RegExp(r'([a-z])([A-Z])'),
              (m) => '${m[1]} ${m[2]}',
            );
        return FilterChip(
          label: Text(label),
          selected: selected,
          onSelected: (bool selected) {
            setState(() {
              selected
                  ? _selectedHorizons.add(horizon)
                  : _selectedHorizons.remove(horizon);
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildInterestChips() {
    return Wrap(
      spacing: 8,
      children: _interestOptions.map((interest) {
        final selected = _selectedInterests.contains(interest);
        return FilterChip(
          label: Text(interest),
          selected: selected,
          onSelected: (bool selected) {
            setState(() {
              selected
                  ? _selectedInterests.add(interest)
                  : _selectedInterests.remove(interest);
            });
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register as Investor')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Name is required' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || !val.contains('@') ? 'Enter a valid email' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _contactController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.trim().length < 8 ? 'Phone too short' : null,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _selectedCountry,
                items: _countryOptions
                    .map((country) => DropdownMenuItem(
                          value: country,
                          child: Text(country),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => _selectedCountry = val ?? 'Zambia'),
                decoration: const InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              const Text('Preferred Investment Term', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              _buildHorizonChips(),
              const SizedBox(height: 16),

              const Text('Interest Areas', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              _buildInterestChips(),
              const SizedBox(height: 16),

              DropdownButtonFormField<InvestorStatus>(
                value: _status,
                items: InvestorStatus.values.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status.name[0].toUpperCase() + status.name.substring(1)),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _status = value!),
                decoration: const InputDecoration(
                  labelText: 'Investment Status',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text('Submit'),
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
