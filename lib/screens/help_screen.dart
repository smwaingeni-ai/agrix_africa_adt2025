import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqItems = [
      {
        'question': '📋 How do I register as a farmer?',
        'answer':
            'Go to the Home screen and tap on "Create Farmer Profile". Fill in your details including photo and location. A QR code will be generated for identification and log tracking.'
      },
      {
        'question': '🌿 How do I get crop or soil advice?',
        'answer':
            'Tap on "Get Advice" from the Home screen. You can upload a photo or answer questions for crops, soil, or livestock to receive tailored guidance.'
      },
      {
        'question': '💰 How can I apply for a loan?',
        'answer':
            'Select "Loan" from the Home screen. Choose your profile and submit an application based on your farm data. Scores are auto-generated.'
      },
      {
        'question': '🛒 What is the Agri Market?',
        'answer':
            'The Agri Market lets you buy, sell, or lease crops, land, livestock, and services. You can also invest in other farmers or invite partners to Market Day.'
      },
      {
        'question': '📱 How do I contact farmers or officers?',
        'answer':
            'Use "AgriGPT Chat" to connect with officers or farmers. Or navigate to the Officer Tasks section if you are an AREX Officer.'
      },
      {
        'question': '📶 Can I use the app offline?',
        'answer':
            'Yes. Most features work offline, including scanning, logging, registering, and QR access. Sync your data once you’re back online.'
      },
      {
        'question': '🔐 Is my data secure?',
        'answer':
            'Yes. Profiles can be locked with PIN or fingerprint. Your data is stored locally unless synced to government or cloud services.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & FAQs'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: faqItems.length,
          separatorBuilder: (_, __) => const Divider(height: 32),
          itemBuilder: (context, index) {
            final faq = faqItems[index];
            return Card(
              elevation: 2,
              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(
                  faq['question']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      faq['answer']!,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
