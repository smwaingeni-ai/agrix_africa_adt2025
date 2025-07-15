import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class AdviceScreen extends StatelessWidget {
  final String? diagnosisResult;

  const AdviceScreen({super.key, this.diagnosisResult});

  @override
  Widget build(BuildContext context) {
    // ✅ Resolve message from passed argument or route settings
    final String message = diagnosisResult ??
        (ModalRoute.of(context)?.settings.arguments as String?) ??
        '❗No diagnosis found.\nPlease upload an image to receive advice.';

    return Scaffold(
      appBar: AppBar(
        title: const Text('AgriX Advice'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ✅ Logo
              Image.asset('assets/alogo.png', height: 100),

              const SizedBox(height: 16),

              // ✅ Title
              const Text(
                'Diagnosis Result',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              // ✅ Diagnosis content
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 30),

              // ✅ Share button
              ElevatedButton.icon(
                onPressed: () => Share.share(message),
                icon: const Icon(Icons.share),
                label: const Text('Share Result'),
              ),

              const SizedBox(height: 10),

              // ✅ Back to landing page
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/landing'));
                },
                icon: const Icon(Icons.home),
                label: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
