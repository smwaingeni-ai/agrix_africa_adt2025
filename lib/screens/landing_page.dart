import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '../models/farmer_profile.dart';
import '../models/user_model.dart';
import '../services/profile_service.dart';

class LandingPage extends StatefulWidget {
  final UserModel loggedInUser;

  const LandingPage({super.key, required this.loggedInUser});

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

  Future<void> _deleteProfile() async {
    await ProfileService.deleteProfile();
    setState(() {
      _profile = null;
    });
  }

  void _shareProfile() {
    if (_profile != null) {
      final profileText = '''
👤 Name: ${_profile!.fullName}
📞 Contact: ${_profile!.contactNumber}
🌍 Country: ${_profile!.country}, Province: ${_profile!.province}
📐 Farm Size: ${_profile!.farmSize} acres
🌱 Type: ${_profile!.farmType}
🏛️ Subsidised: ${_profile!.subsidised ? "Yes" : "No"}
🆔 ID Number: ${_profile!.idNumber ?? "N/A"}
''';
      Share.share(profileText);
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttons = [
      {'label': 'Get Advice', 'route': '/advice'},
      {'label': 'Logbook', 'route': '/logbook'},
      {'label': 'Market', 'route': '/market'},
      {'label': 'Loan', 'route': '/loan'},
      {'label': 'AgriGPT', 'route': '/agrigpt'},     // 🧠 Text-style AI Q&A
      {'label': 'AgriGPT Chat', 'route': '/chat'},   // 💬 Chat-style assistant
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('AgriX Beta – ADT 2025'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔸 Logo and Motto
            Column(
              children: [
                Image.asset('assets/alogo.png', height: 100),
                const SizedBox(height: 8),
                const Text(
                  'AgriX – Smart Economies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 🔹 Welcome Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '👋 Welcome ${widget.loggedInUser.name} (${widget.loggedInUser.role})',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 16),

            // 🔹 Profile Summary
            if (_profile != null) ...[
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 2,
                child: Column(
                  children: [
                    if (_profile!.photoPath != null &&
                        File(_profile!.photoPath!).existsSync()) ...[
                      const SizedBox(height: 10),
                      const Text('📷 Farmer Photo',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(_profile!.photoPath!),
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.green),
                      title: Text(_profile!.fullName),
                      subtitle: Text(
                          '${_profile!.country}, ${_profile!.province}\nFarm Type: ${_profile!.farmType} • Subsidised: ${_profile!.subsidised ? 'Yes' : 'No'}'),
                    ),
                    if (_profile!.qrImagePath != null &&
                        File(_profile!.qrImagePath!).existsSync())
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Image.file(File(_profile!.qrImagePath!), height: 100),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.edit),
                            label: const Text("Edit"),
                            onPressed: () {
                              Navigator.pushNamed(context, '/profile')
                                  .then((_) => _loadProfile());
                            },
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.share),
                            label: const Text("Share"),
                            onPressed: _shareProfile,
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.delete),
                            label: const Text("Delete"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent),
                            onPressed: _deleteProfile,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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

            const SizedBox(height: 16),

            const Text(
              'Your AI-powered farming assistant.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

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
