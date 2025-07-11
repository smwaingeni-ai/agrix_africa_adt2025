import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/farmer_profile.dart';
import '../services/profile_service.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  FarmerProfile? _profile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final loadedProfile = await ProfileService.loadProfile();
    setState(() {
      _profile = loadedProfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    final buttons = [
      {'label': 'Get Advice', 'route': '/advice'},
      {'label': 'Logbook', 'route': '/logbook'},
      {'label': 'Market', 'route': '/market'},
      {'label': 'Loan', 'route': '/loan'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('AgriX Beta – ADT 2025')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.lightGreen.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '✅ AgriX Landing Page Loaded Successfully!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Farmer Profile Summary
            if (_profile != null) ...[
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 2,
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.green),
                  title: Text(_profile!.fullName),
                  subtitle: Text(
                      '${_profile!.country}, ${_profile!.province}\nFarm Type: ${_profile!.farmType} • Subsidised: ${_profile!.subsidised ? 'Yes' : 'No'}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile')
                          .then((_) => _loadProfile());
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (_profile!.farmerId.isNotEmpty)
                QrImageView(
                  data: _profile!.farmerId,
                  version: QrVersions.auto,
                  size: 120,
                  backgroundColor: Colors.white,
                ),
              const SizedBox(height: 10),
            ] else
              ElevatedButton.icon(
                icon: const Icon(Icons.person_add),
                label: const Text('Create Farmer Profile'),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile')
                      .then((_) => _loadProfile());
                },
              ),

            const SizedBox(height: 20),
            const Text(
              'Welcome to AgriX 🌾\nYour AI-powered farming assistant.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: buttons.map((btn) {
                  return ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_forward_ios),
                    label: Text(btn['label']!),
                    onPressed: () {
                      Navigator.pushNamed(context, btn['route']!);
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
