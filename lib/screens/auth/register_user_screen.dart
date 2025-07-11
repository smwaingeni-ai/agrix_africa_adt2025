import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/user_model.dart';

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

  final List<String> roles = ['Farmer', 'Officer', 'Official', 'Admin'];

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
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

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ User registered successfully')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register New User')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Role'),
                value: role,
                items: roles
                    .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                    .toList(),
                onChanged: (val) => setState(() => role = val!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
                onSaved: (val) => name = val!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Passcode'),
                obscureText: true,
                validator: (val) =>
                    val == null || val.length < 4 ? 'Min 4 digits' : null,
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

// 🔜 LATER IMPROVEMENTS:
// - Validate if username already exists
// - Encrypt passcode (basic hash)
// - Admin-only access to register users
// - Remote sync/storage
