import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
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
  String idNumber = '';
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
  String? photoPath;
  Uint8List? webImageBytes; // ✅ for preview in web

  List<String> countries = ['Zambia', 'Zimbabwe', 'Kenya'];
  List<String> farmTypes = ['Crop', 'Livestock', 'Mixed'];
  List<String> languages = ['English', 'Shona', 'Swahili'];

  Future<void> _pickImage() async {
    try {
      if (kIsWeb) {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          withData: true,
        );
        if (result != null && result.files.single.bytes != null) {
          final fileName = result.files.single.name;
          final bytes = result.files.single.bytes!;

          final dir = await getApplicationDocumentsDirectory();
          final filePath = path.join(dir.path, fileName);
          final file = File(filePath);
          await file.writeAsBytes(bytes);
          setState(() {
            photoPath = file.path;
            webImageBytes = bytes;
          });
        }
      } else {
        final picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          setState(() {
            photoPath = image.path;
            webImageBytes = null;
          });
        }
      }
    } catch (e) {
      print('Image selection failed: $e');
    }
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final profile = FarmerProfile(
        farmerId: _uuid.v4(),
        fullName: fullName,
        idNumber: idNumber,
        contactNumber: contactNumber,
        country: country,
        province: province,
        district: district,
        ward: ward,
        village: village,
        cell: cell,
        farmSize: farmSize,
        farmType: farmType,
        subsidised: subsidised,
        language: language,
        createdAt: DateTime.now(),
        qrImagePath: null,
        photoPath: photoPath, // ✅ ensures it's saved
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
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => fullName = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'ID Number'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => idNumber = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contact Number'),
                onSaved: (value) => contactNumber = value ?? '',
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Country'),
                value: country,
                items: countries
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) => setState(() => country = value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Province'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => province = value!,
              ),
              TextFormField(
                  decoration: const InputDecoration(labelText: 'District'),
                  onSaved: (v) => district = v ?? ''),
              TextFormField(
                  decoration: const InputDecoration(labelText: 'Ward'),
                  onSaved: (v) => ward = v ?? ''),
              TextFormField(
                  decoration: const InputDecoration(labelText: 'Village'),
                  onSaved: (v) => village = v ?? ''),
              TextFormField(
                  decoration: const InputDecoration(labelText: 'Cell'),
                  onSaved: (v) => cell = v ?? ''),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Farm Size (acres)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => farmSize = double.tryParse(value!) ?? 0.0,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Farm Type'),
                value: farmType,
                items: farmTypes
                    .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                    .toList(),
                onChanged: (value) => setState(() => farmType = value!),
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Language'),
                value: language,
                items: languages
                    .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                    .toList(),
                onChanged: (value) => setState(() => language = value!),
              ),
              SwitchListTile(
                title: const Text('Subsidised by Government?'),
                value: subsidised,
                onChanged: (value) => setState(() => subsidised = value),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.camera_alt),
                label: const Text("Capture or Upload Farmer Photo"),
              ),
              if (photoPath != null || webImageBytes != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: kIsWeb
                      ? Image.memory(webImageBytes!, height: 120)
                      : Image.file(File(photoPath!), height: 120),
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
