import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/market_item.dart';

class MarketDetailScreen extends StatelessWidget {
  final MarketItem item;

  const MarketDetailScreen({super.key, required this.item});

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
    final uri = Uri.parse("https://wa.me/$phone");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _share(BuildContext context) {
    final msg = "Check out this listing on AgriX:\n"
        "${item.title}\n${item.description}\n"
        "Location: ${item.location}\nPrice: \$${item.price}";
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Shared: $msg")), // Replace with `share_plus` in prod
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listing Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _share(context),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            if (item.imagePath.isNotEmpty && File(item.imagePath).existsSync())
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(File(item.imagePath),
                    height: 200, fit: BoxFit.cover),
              ),
            const SizedBox(height: 12),
            Text(item.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(item.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            _buildDetail("Category", item.category),
            _buildDetail("Type", item.type),
            _buildDetail("Location", item.location),
            _buildDetail("Price", "\$${item.price.toStringAsFixed(2)}"),
            _buildDetail("Payment", item.paymentOption),
            _buildFlag("Loan Accepted", item.isLoanAccepted),
            _buildFlag("Open for Investment", item.isInvestorOpen),
            if (item.isInvestorOpen)
              _buildDetail("Investment Term", item.investmentTerm),
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
                  icon: const Icon(Icons.whatsapp),
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
                  const SnackBar(content: Text("Loan/Investment application coming soon.")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
