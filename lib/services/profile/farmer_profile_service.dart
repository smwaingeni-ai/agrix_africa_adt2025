import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:agrix_africa_adt2025/models/farmer_profile.dart';
import 'package:agrix_africa_adt2025/services/profile/farmer_profile_service.dart';

class FarmerProfileScreen extends StatelessWidget {
  const FarmerProfileScreen({super.key});

  void _launchWhatsApp(BuildContext context, String phone) async {
    final Uri whatsappUrl = Uri.parse('https://wa.me/$phone');
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch WhatsApp')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FarmerProfile?>(
      future: FarmerProfileService.loadActiveProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final profile = snapshot.data;

        if (profile == null) {
          return const Scaffold(
            body: Center(child: Text('No profile found.')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Farmer Profile'),
            actions: [
              if (profile.contactNumber.isNotEmpty)
                IconButton(
                  icon: const Icon(FontAwesomeIcons.whatsapp),
                  onPressed: () => _launchWhatsApp(context, profile.contactNumber),
                ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: (profile.photoPath != null && profile.photoPath!.isNotEmpty)
                      ? FileImage(File(profile.photoPath!))
                      : null,
                  child: (profile.photoPath == null || profile.photoPath!.isEmpty)
                      ? const Icon(Icons.person, size: 50)
                      : null,
                ),
                const SizedBox(height: 16),
                Text("Full Name: ${profile.fullName}", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text("ID: ${profile.id}"),
                const SizedBox(height: 8),
                Text("Phone: ${profile.contactNumber}"),
                const SizedBox(height: 8),
                Text("Farm Size: ${profile.farmSizeHectares?.toStringAsFixed(2) ?? 'N/A'} hectares"),
                const SizedBox(height: 8),
                Text("Govt Affiliated: ${profile.govtAffiliated ? 'Yes' : 'No'}"),
              ],
            ),
          ),
        );
      },
    );
  }
}
