import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/user_model.dart';
import '../../models/farmer_profile.dart';
import '../../services/profile_service.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({super.key});

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final _formKey = GlobalKey<FormState>();
  String role = 'Farmer';
  String name = '';
  String passcode = '';
  String phone = '';
  String region = '';
  String farmType = '';
  bool _submitted = false;
  FarmerProfile? _profile;

  final List<String> roles = ['Farmer', 'Officer', 'Official', 'Admin'];

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final userId = DateTime.now().millisecondsSinceEpoch.toString();

      final user = UserModel(
        id: userId,
        role: role,
        name: name,
        passcode: passcode,
      );

      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/registered_users.json');

      List<dynamic> users = [];
      if (await file.exists()) {
        final contents = await file.readAsString();
        if (contents.isNotEmpty) {
          users = jsonDecode(contents);
        }
      }

      users.add(user.toJson());
      await file.writeAsString(jsonEncode(users));

      if (role == 'Farmer') {
        _profile = FarmerProfile(
          id: userId,
          name: name,
          phone: phone,
          region: region,
          farmType: farmType,
          govtAffiliated: true,
          farmSizeHectares: 1.0,
          qrImagePath: '',
        );
        await ProfileService.saveActiveProfile(_profile!);
      }

      setState(() => _submitted = true);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ User registered successfully')),
      );
    }
  }

  Widget _buildQRCode() {
    final encoded = jsonEncode(_profile?.toJson() ?? {});
    return QrImageView(
      data: encoded,
      version: QrVersions.auto,
      size: 200.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register New User')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _submitted && role == 'Farmer'
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('QR Code Generated:', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  _buildQRCode(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back to Home'),
                  ),
                ],
              )
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Role'),
                      value: role,
                      items: roles.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                      onChanged: (val) => setState(() => role = val!),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Username / Full Name'),
                      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                      onSaved: (val) => name = val!,
                    ),
                    if (role == 'Farmer')
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Phone Number'),
                        keyboardType: TextInputType.phone,
                        validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                        onSaved: (val) => phone = val!,
                      ),
                    if (role == 'Farmer')
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Region'),
                        validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                        onSaved: (val) => region = val!,
                      ),
                    if (role == 'Farmer')
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Farm Type (e.g. Crops, Livestock)'),
                        onSaved: (val) => farmType = val ?? '',
                      ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Passcode'),
                      obscureText: true,
                      validator: (val) => val == null || val.length < 4 ? 'Min 4 digits' : null,
                      onSaved: (val) => passcode = val!,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _registerUser,
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
