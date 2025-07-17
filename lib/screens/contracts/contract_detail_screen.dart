import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:agrix_africa_adt2025/models/contracts/contract_offer.dart';

class ContractDetailScreen extends StatelessWidget {
  final ContractOffer contract;

  const ContractDetailScreen({super.key, required this.contract});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.simpleCurrency();

    return Scaffold(
      appBar: AppBar(
        title: Text(contract.title),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: 'Export to PDF (Coming Soon)',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("🚧 PDF export feature is under development."),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildDetailTile("📄 Contract Title", contract.title),
            _buildDetailTile("📝 Description", contract.description),
            _buildDetailTile("🤝 Parties Involved", contract.parties),
            _buildDetailTile("💵 Amount", currencyFormatter.format(contract.amount)),
            _buildDetailTile("⏳ Duration", contract.duration),
            _buildDetailTile("🌱 Crop/Livestock Type", contract.cropOrLivestockType),
            _buildDetailTile("📍 Location", contract.location),
            _buildDetailTile("📑 Terms & Conditions", contract.terms),
            _buildDetailTile("📞 Contact Info", contract.contact),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.share),
              label: const Text("Share Contract"),
              onPressed: () {
                // You can later integrate url_launcher or share_plus here.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("🚀 Sharing functionality coming soon."),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.isNotEmpty ? value : "N/A",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const Divider(height: 24),
        ],
      ),
    );
  }
}
