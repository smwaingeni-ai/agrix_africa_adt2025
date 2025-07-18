import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:agrix_africa_adt2025/models/farmer_profile.dart';
import 'package:agrix_africa_adt2025/services/farmer_service.dart';

class FarmerProfileScreen extends StatelessWidget {
  const FarmerProfileScreen({super.key});

  void _launchWhatsApp(String phone) async {
    final Uri whatsappUrl = Uri.parse('https://wa.me/$phone');
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FarmerProfile?>(
      future: ProfileService.loadActiveProfile(),
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
              IconButton(
                icon: const Icon(FontAwesomeIcons.whatsapp),
                onPressed: () => _launchWhatsApp(profile.contact),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: profile.photoPath != null
                      ? FileImage(File(profile.photoPath!))
                      : null,
                  child: profile.photoPath == null ? const Icon(Icons.person, size: 50) : null,
                ),
                const SizedBox(height: 16),
                Text("Name: ${profile.name}", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text("ID: ${profile.idNumber}"),
                const SizedBox(height: 8),
                Text("Phone: ${profile.contact}"),
                const SizedBox(height: 8),
                Text("Farm Location: ${profile.farmLocation}"),
                const SizedBox(height: 8),
                Text("Farm Size: ${profile.farmSize} hectares"),
                const SizedBox(height: 8),
                Text("Farm Type: ${profile.farmType}"),
              ],
            ),
          ),
        );
      },
    );
  }
}
