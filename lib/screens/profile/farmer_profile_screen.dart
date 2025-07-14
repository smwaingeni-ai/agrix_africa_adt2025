import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:agrix_africa_adt2025/models/farmer_profile.dart';
import 'package:agrix_africa_adt2025/services/profile_service.dart';

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
  String? qrImagePath;
  Uint8List? webImageBytes;

  List<String> countries = ['Zambia', 'Zimbabwe', 'Kenya'];
  List<String> farmTypes = ['Crop', 'Livestock', 'Mixed'];
  List<String> languages = ['English', 'Shona', 'Swahili'];

  Future<void> _pickImage() async {
    try {
      if (kIsWeb) {
        final result = await FilePicker.platform.pickFiles(type: FileType.image, withData: true);
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

  Future<void> _generateAndSaveQR(String farmerId, String name, String nationalId) async {
    final qrData = json.encode({'id': farmerId, 'name': name, 'nationalId': nationalId});
    final painter = QrPainter(
      data: qrData,
      version: QrVersions.auto,
      gapless: true,
      color: const Color(0xFF000000),
      emptyColor: const Color(0xFFFFFFFF),
    );

    final dir = await getApplicationDocumentsDirectory();
    final qrPath = '${dir.path}/$farmerId-qr.png';

    final picData = await painter.toImageData(300, format: ImageByteFormat.png);
    final buffer = picData!.buffer.asUint8List();
    await File(qrPath).writeAsBytes(buffer);

    setState(() {
      qrImagePath = qrPath;
    });
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final farmerId = _uuid.v4();
      await _generateAndSaveQR(farmerId, fullName, idNumber);

      final profile = FarmerProfile(
        farmerId: farmerId,
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
        photoPath: photoPath,
        qrImagePath: qrImagePath,
      );

      await ProfileService.saveProfile(profile);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Profile saved with QR Code')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Farmer Profile Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                onSaved: (val) => fullName = val!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'ID Number'),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                onSaved: (val) => idNumber = val!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contact Number'),
                onSaved: (val) => contactNumber = val ?? '',
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Country'),
                value: country,
                items: countries.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (val) => setState(() => country = val!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Province'),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                onSaved: (val) => province = val!,
              ),
              TextFormField(decoration: const InputDecoration(labelText: 'District'), onSaved: (v) => district = v ?? ''),
              TextFormField(decoration: const InputDecoration(labelText: 'Ward'), onSaved: (v) => ward = v ?? ''),
              TextFormField(decoration: const InputDecoration(labelText: 'Village'), onSaved: (v) => village = v ?? ''),
              TextFormField(decoration: const InputDecoration(labelText: 'Cell'), onSaved: (v) => cell = v ?? ''),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Farm Size (acres)'),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                onSaved: (val) => farmSize = double.tryParse(val!) ?? 0.0,
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Farm Type'),
                value: farmType,
                items: farmTypes.map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(),
                onChanged: (val) => setState(() => farmType = val!),
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Language'),
                value: language,
                items: languages.map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
                onChanged: (val) => setState(() => language = val!),
              ),
              SwitchListTile(
                title: const Text('Subsidised by Government?'),
                value: subsidised,
                onChanged: (val) => setState(() => subsidised = val),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text("Capture or Upload Photo"),
                onPressed: _pickImage,
              ),
              if (photoPath != null || webImageBytes != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: kIsWeb
                      ? Image.memory(webImageBytes!, height: 120)
                      : Image.file(File(photoPath!), height: 120),
                ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save Profile'),
              ),
              if (qrImagePath != null)
                Column(
                  children: [
                    const SizedBox(height: 16),
                    const Text('QR Code:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Image.file(File(qrImagePath!), height: 120),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
