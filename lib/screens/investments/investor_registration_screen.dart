import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:agrix_africa_adt2025/models/investor_profile.dart';
import 'package:agrix_africa_adt2025/services/investor_service.dart';

class InvestorRegistrationScreen extends StatefulWidget {
  @override
  _InvestorRegistrationScreenState createState() => _InvestorRegistrationScreenState();
}

class _InvestorRegistrationScreenState extends State<InvestorRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String phoneNumber = '';
  String country = '';
  String contact = '';
  List<String> selectedHorizons = [];
  List<String> selectedInterests = [];
  String status = 'Open';

  final List<String> horizons = ['Short-Term', 'Medium-Term', 'Long-Term'];
  final List<String> interests = ['Crops', 'Livestock', 'Soil', 'Technology'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register as Investor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
                onSaved: (value) => email = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
                onSaved: (value) => phoneNumber = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Country'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
                onSaved: (value) => country = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preferred Contact Method (e.g. WhatsApp)'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
                onSaved: (value) => contact = value!,
              ),
              SizedBox(height: 16),
              Text("Investment Horizon"),
              Wrap(
                spacing: 8,
                children: horizons.map((h) {
                  return ChoiceChip(
                    label: Text(h),
                    selected: selectedHorizons.contains(h),
                    onSelected: (selected) {
                      setState(() {
                        selected
                            ? selectedHorizons.add(h)
                            : selectedHorizons.remove(h);
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Text("Investment Interest"),
              Wrap(
                spacing: 8,
                children: interests.map((i) {
                  return FilterChip(
                    label: Text(i),
                    selected: selectedInterests.contains(i),
                    onSelected: (selected) {
                      setState(() {
                        selected
                            ? selectedInterests.add(i)
                            : selectedInterests.remove(i);
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Investment Status'),
                value: status,
                onChanged: (value) => setState(() => status = value!),
                items: ['Open', 'Indifferent', 'Not Open']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Register'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final newInvestor = InvestorProfile(
                      id: Uuid().v4(),
                      name: name,
                      email: email,
                      contactNumber: phoneNumber,
                      contact: contact,
                      location: country,
                      preferredHorizons: selectedHorizons,
                      interests: selectedInterests,
                      status: status,
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
