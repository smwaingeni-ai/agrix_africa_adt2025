import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/farmer_profile.dart';
import '../services/profile_service.dart';

class FarmerProfileScreen extends StatefulWidget {
  const FarmerProfileScreen({super.key});

  @override
  State<FarmerProfileScreen> createState() => _FarmerProfileScreenState();
}

class _FarmerProfileScreenState extends State<FarmerProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  String fullName = '';
  String contactNumber = '';
  String country = 'Zambia';
  String province = '';
  String district = '';
  String ward = '';
  String village = '';
  String cell = '';
  String farmType = 'Crop';
  bool subsidised = false;
  String language = 'English';
  double farmSize = 0.0;

  List<String> countries = ['Zambia', 'Zimbabwe', 'Kenya'];
  List<String> farmTypes = ['Crop', 'Livestock', 'Mixed'];
  List<String> languages = ['English', 'Shona', 'Swahili'];

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final profile = FarmerProfile(
        farmerId: _uuid.v4(),
        fullName: fullName,
        country: country,
        province: province,
        district: district,
        ward: ward,
        village: village,
        cell: cell,
        farmSize: farmSize,
        farmType: farmType,
        subsidised: subsidised,
        contactNumber: contactNumber,
        language: language,
        createdAt: DateTime.now(),
        qrImagePath: null,
      );

      await ProfileService.saveProfile(profile);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile saved successfully!')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Farmer Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => fullName = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contact Number'),
                onSaved: (value) => contactNumber = value ?? '',
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Country'),
                value: country,
                items: countries.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (value) => setState(() => country = value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Province'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => province = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'District'),
                onSaved: (value) => district = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Ward'),
                onSaved: (value) => ward = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Village'),
                onSaved: (value) => village = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cell'),
                onSaved: (value) => cell = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Farm Size (acres)'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => farmSize = double.tryParse(value!) ?? 0.0,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Farm Type'),
                value: farmType,
                items: farmTypes.map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(),
                onChanged: (value) => setState(() => farmType = value!),
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Language'),
                value: language,
                items: languages.map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
                onChanged: (value) => setState(() => language = value!),
              ),
              SwitchListTile(
                title: const Text('Subsidised by Government?'),
                value: subsidised,
                onChanged: (value) => setState(() => subsidised = value),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
