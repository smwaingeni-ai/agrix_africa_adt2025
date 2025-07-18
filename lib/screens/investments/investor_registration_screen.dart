import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:agrix_africa_adt2025/models/investments/investor_profile.dart';
import 'package:agrix_africa_adt2025/services/investments/investor_service.dart';
import 'package:agrix_africa_adt2025/models/investments/investment_horizon.dart';

class InvestorRegistrationScreen extends StatefulWidget {
  // ✅ No const constructor
  @override
  _InvestorRegistrationScreenState createState() => _InvestorRegistrationScreenState();
}

class _InvestorRegistrationScreenState extends State<InvestorRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _contactController = TextEditingController();

  List<String> _selectedHorizons = [];
  List<String> _selectedInterests = [];
  String _selectedStatus = 'Open';

  final List<String> _horizons = ['Short Term', 'Mid Term', 'Long Term'];
  final List<String> _interests = ['Crops', 'Livestock', 'Soil', 'Technology'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register as Investor')), // ✅ Removed const
      body: Padding(
        padding: EdgeInsets.all(16.0), // ✅ Removed const
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Country'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _contactController,
                decoration: InputDecoration(labelText: 'Preferred Contact Method (e.g. WhatsApp)'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16),
              Text("Investment Horizon"),
              Wrap(
                spacing: 8,
                children: _horizons.map((h) {
                  return ChoiceChip(
                    label: Text(h),
                    selected: _selectedHorizons.contains(h),
                    onSelected: (selected) {
                      setState(() {
                        selected
                            ? _selectedHorizons.add(h)
                            : _selectedHorizons.remove(h);
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Text("Investment Interest"),
              Wrap(
                spacing: 8,
                children: _interests.map((i) {
                  return FilterChip(
                    label: Text(i),
                    selected: _selectedInterests.contains(i),
                    onSelected: (selected) {
                      setState(() {
                        selected
                            ? _selectedInterests.add(i)
                            : _selectedInterests.remove(i);
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Investment Status'),
                value: _selectedStatus,
                onChanged: (value) => setState(() => _selectedStatus = value!),
                items: ['Open', 'Indifferent', 'Not Open']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(FontAwesomeIcons.whatsapp),
                label: Text('Register'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newInvestor = InvestorProfile(
                      id: Uuid().v4(),
                      name: _nameController.text,
                      email: _emailController.text,
                      contactNumber: _phoneController.text,
                      contact: _contactController.text,
                      location: _locationController.text,
                      preferredHorizons: _selectedHorizons
                          .map((e) => InvestmentHorizonExtension.fromLabel(e))
                          .toList(),
                      interests: _selectedInterests,
                      status: InvestorStatusExtension.fromString(_selectedStatus),
                      registeredAt: DateTime.now(),
                    );

                    InvestorService().saveInvestor(newInvestor);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Investor Registered!')),
                    );
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
