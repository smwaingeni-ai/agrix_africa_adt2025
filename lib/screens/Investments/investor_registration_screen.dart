import 'package:flutter/material.dart';
import '../../models/investor_profile.dart';
import '../../services/investor_service.dart';

class InvestorRegistrationScreen extends StatefulWidget {
  const InvestorRegistrationScreen({super.key});

  @override
  State<InvestorRegistrationScreen> createState() => _InvestorRegistrationScreenState();
}

class _InvestorRegistrationScreenState extends State<InvestorRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  final List<String> _selectedTerms = [];
  final List<String> _selectedInterests = [];
  String _investmentStatus = 'Indifferent';

  final List<String> _investmentTerms = ['Short-term (1–2 yrs)', 'Mid-term (3–5 yrs)', 'Long-term (6+ yrs)'];
  final List<String> _interestCategories = ['Crops', 'Livestock', 'Land', 'Equipment', 'Services'];
  final List<String> _statuses = ['Open', 'Indifferent', 'Not Open'];

  void _saveInvestor() async {
    if (_formKey.currentState?.validate() ?? false) {
      final newInvestor = InvestorProfile(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        contactInfo: _contactController.text,
        term: _selectedTerms.join(', '),
        interestArea: _selectedInterests.join(', '),
        status: _investmentStatus,
        country: 'N/A',
      );

      await InvestorService().addInvestor(newInvestor);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Investor Registered Successfully')),
        );
        Navigator.pop(context);
      }
    }
  }

  Widget _buildChipSelector({
    required String label,
    required List<String> options,
    required List<String> selectedList,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          children: options.map((item) {
            final isSelected = selectedList.contains(item);
            return FilterChip(
              label: Text(item),
              selected: isSelected,
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    selectedList.add(item);
                  } else {
                    selectedList.remove(item);
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register as Investor'),
        centerTitle: true,
      ),
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
                validator: (value) => value == null || value.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(
                  labelText: 'Contact Info (Phone or Email)',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),

              _buildChipSelector(
                label: 'Preferred Investment Duration',
                options: _investmentTerms,
                selectedList: _selectedTerms,
              ),
              _buildChipSelector(
                label: 'Areas of Interest',
                options: _interestCategories,
                selectedList: _selectedInterests,
              ),

              DropdownButtonFormField<String>(
                value: _investmentStatus,
                decoration: const InputDecoration(
                  labelText: 'Investment Status',
                  border: OutlineInputBorder(),
                ),
                items: _statuses
                    .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _investmentStatus = value!;
                  });
                },
              ),
              const SizedBox(height: 24),

              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Submit Investor Profile'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: _saveInvestor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
