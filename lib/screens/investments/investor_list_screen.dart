import 'package:flutter/material.dart';
import 'package:agrix_africa_adt2025/models/investor_profile.dart';
import 'package:agrix_africa_adt2025/services/investor_service.dart';

class InvestorListScreen extends StatefulWidget {
  const InvestorListScreen({super.key});

  @override
  State<InvestorListScreen> createState() => _InvestorListScreenState();
}

class _InvestorListScreenState extends State<InvestorListScreen> {
  List<InvestorProfile> _investors = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadInvestors();
  }

  Future<void> _loadInvestors() async {
    try {
      final data = await InvestorService().loadEncrypted();
      setState(() {
        _investors = data;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _investors = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Failed to load investor profiles')),
      );
    }
  }

  Widget _buildCard(InvestorProfile investor) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: const Icon(Icons.account_balance_wallet_rounded,
            color: Colors.green, size: 32),
        title: Text(
          investor.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🌍 Location: ${investor.location}'),
            Text('💼 Interests: ${investor.interests.join(', ')}'),
            Text('⏳ Horizon: ${investor.preferredHorizons.map((e) => e.name).join(', ')}'),
            Text('📊 Status: ${investor.status.name}'),
          ],
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          tooltip: 'Contact Options',
          onSelected: (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$value: ${investor.name}')),
            );
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'Call', child: Text('Call')),
            const PopupMenuItem(value: 'WhatsApp', child: Text('Message on WhatsApp')),
            const PopupMenuItem(value: 'Email', child: Text('Email')),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investor Directory'),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _investors.isEmpty
              ? const Center(child: Text('🚫 No investors found.'))
              : RefreshIndicator(
                  onRefresh: _loadInvestors,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: _investors.length,
                    itemBuilder: (context, index) =>
                        _buildCard(_investors[index]),
                  ),
                ),
    );
  }
}
