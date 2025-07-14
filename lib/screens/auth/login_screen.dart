import 'package:flutter/material.dart';
import 'package:agrix_africa_adt2025/data/dummy_users.dart';
import 'package:agrix_africa_adt2025/models/user_model.dart';
import 'package:agrix_africa_adt2025/screens/core/landing_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String selectedRole = 'Farmer';
  String name = '';
  String passcode = '';

  final List<String> roles = [
    'Farmer',
    'AREX Officer',
    'Government Official',
    'Admin',
    'Trader',
    'Investor',
  ];

  void _validateLogin() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final user = dummyUsers.firstWhere(
        (u) =>
            u.name.toLowerCase() == name.trim().toLowerCase() &&
            u.passcode == passcode &&
            u.role == selectedRole,
        orElse: () => UserModel(id: '', name: '', role: '', passcode: ''),
      );

      if (user.id.isNotEmpty) {
        _navigateToRoleScreen(user);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Invalid credentials')),
        );
      }
    }
  }

  void _navigateToRoleScreen(UserModel user) {
    switch (user.role) {
      case 'Farmer':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => LandingPage(loggedInUser: user),
          ),
        );
        break;
      case 'AREX Officer':
        Navigator.pushReplacementNamed(context, '/officer_dashboard', arguments: user);
        break;
      case 'Government Official':
        Navigator.pushReplacementNamed(context, '/official_dashboard', arguments: user);
        break;
      case 'Admin':
        Navigator.pushReplacementNamed(context, '/admin_panel', arguments: user);
        break;
      case 'Trader':
        Navigator.pushReplacementNamed(context, '/trader_dashboard', arguments: user);
        break;
      case 'Investor':
        Navigator.pushReplacementNamed(context, '/investor_dashboard', arguments: user);
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unknown user role.')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AgriX Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                '🔐 Login to AgriX',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Select Role'),
                value: selectedRole,
                items: roles
                    .map((role) => DropdownMenuItem(value: role, child: Text(role)))
                    .toList(),
                onChanged: (value) => setState(() => selectedRole = value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => name = value!.trim(),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Passcode'),
                obscureText: true,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => passcode = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text('Login'),
                onPressed: _validateLogin,
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Create New Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
