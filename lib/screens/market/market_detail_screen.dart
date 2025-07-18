import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:agrix_africa_adt2025/models/market/market_item.dart';

class MarketDetailScreen extends StatelessWidget {
  final MarketItem item;

  const MarketDetailScreen({required this.item, Key? key}) : super(key: key);

  void _launchPhone(String phone) async {
    final uri = Uri.parse("tel:$phone");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchSMS(String phone) async {
    final uri = Uri.parse("sms:$phone");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchWhatsApp(String phone) async {
    final cleanPhone = phone.replaceAll(RegExp(r'\s+'), '');
    final uri = Uri.parse("https://wa.me/$cleanPhone");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('⚠️ Could not launch WhatsApp for $cleanPhone');
    }
  }

  void _share(BuildContext context, MarketItem item) {
    final msg = "Check out this listing on AgriX:\n"
        "${item.title}\n${item.description}\n"
        "📍 Location: ${item.location}\n💰 Price: \$${(item.price ?? 0.0).toStringAsFixed(2)}";
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("📤 Shared: $msg")), // Placeholder for share_plus
    );
  }

  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildFlag(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(value ? Icons.check_circle : Icons.cancel,
              color: value ? Colors.green : Colors.red),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool imageExists = item.imagePath.isNotEmpty && File(item.imagePath).existsSync();
    final bool investmentFlag = item.isInvestorOpen ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listing Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _share(context, item),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            if (imageExists)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(item.imagePath),
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 12),
            Text(item.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(item.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            _buildDetail("Category", item.category),
            _buildDetail("Type", item.type),
            _buildDetail("Location", item.location),
            _buildDetail("Price", "\$${(item.price ?? 0.0).toStringAsFixed(2)}"),
            _buildDetail("Payment", item.paymentOption),
            _buildFlag("Loan Accepted", item.isLoanAccepted),
            _buildFlag("Open for Investment", investmentFlag),
            if (investmentFlag)
              _buildDetail("Investment Term", item.investmentTerm ?? "-"),
            const Divider(height: 30),
            const Text("Contact Seller", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.phone),
                  label: const Text("Call"),
                  onPressed: () => _launchPhone(item.contact),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.sms),
                  label: const Text("SMS"),
                  onPressed: () => _launchSMS(item.contact),
                ),
                ElevatedButton.icon(
                  icon: const Icon(FontAwesomeIcons.whatsapp),
                  label: const Text("WhatsApp"),
                  onPressed: () => _launchWhatsApp(item.contact),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.monetization_on),
              label: const Text("Apply for Loan or Investment"),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("🚧 Loan/Investment feature coming soon")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
