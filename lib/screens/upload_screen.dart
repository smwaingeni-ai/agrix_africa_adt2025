import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'transaction_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? _image;
  String? _result;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    await Tflite.loadModel(
      model: 'assets/tflite/crop_disease_model.tflite',
      labels: 'assets/tflite/labels.txt',
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);

    if (picked != null) {
      setState(() {
        _image = File(picked.path);
        _loading = true;
        _result = null;
      });
      await _classifyImage(_image!);
    }
  }

  Future<void> _classifyImage(File image) async {
    final output = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 3,
      threshold: 0.3,
    );

    setState(() {
      _loading = false;
      if (output != null && output.isNotEmpty) {
        final label = output[0]['label'];
        final confidence = (output[0]['confidence'] * 100).toStringAsFixed(1);
        _result = '🌿 Diagnosis: $label\n📊 Confidence: $confidence%';
        _navigateToTransactionScreen();
      } else {
        _result = '⚠️ No disease or issue detected.';
      }
    });
  }

  Future<void> _saveResult() async {
    if (_result == null) return;

    final timestamp = DateTime.now().toIso8601String();
    final entry = {
      'timestamp': timestamp,
      'result': _result,
      'cost': '5 ZMW',
    };

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/logbook.json');

    List<dynamic> logs = [];
    if (await file.exists()) {
      final content = await file.readAsString();
      logs = json.decode(content);
    }

    logs.add(entry);
    await file.writeAsString(json.encode(logs));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Result saved to Logbook')),
    );
  }

  void _shareResult() {
    if (_result != null) {
      Share.share('📄 AgriX Diagnostic Result:\n\n$_result');
    }
  }

  void _navigateToTransactionScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TransactionScreen(
          result: _result!,
          timestamp: DateTime.now().toIso8601String(),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.save),
          label: const Text('Save Result'),
          onPressed: _saveResult,
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          icon: const Icon(Icons.share),
          label: const Text('Share Result'),
          onPressed: _shareResult,
        ),
      ],
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📸 Scan & Diagnose')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.photo_library),
                label: const Text('Pick from Gallery'),
                onPressed: kIsWeb ? null : () => _pickImage(ImageSource.gallery),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text('Take a Photo'),
                onPressed: kIsWeb ? null : () => _pickImage(ImageSource.camera),
              ),
              const SizedBox(height: 20),
              if (_image != null && !kIsWeb) ...[
                Image.file(_image!, height: 200),
                const SizedBox(height: 20),
              ],
              if (_loading)
                const CircularProgressIndicator()
              else if (_result != null)
                Text(_result!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              if (!_loading && _result != null) _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
