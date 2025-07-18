import 'package:flutter/material.dart';
import 'package:agrix_africa_adt2025/models/investments/investor_profile.dart';
import 'package:agrix_africa_adt2025/services/investor_service.dart';
import 'package:url_launcher/url_launcher.dart';

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
      final data = await InvestorService().loadInvestors();
      setState(() {
        _investors = data;
        _loading = false;
      });
    } catch (e) {
      debugPrint('❌ Error loading investors: $e');
      setState(() {
        _investors = [];
        _loading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Failed to load investor profiles')),
        );
      }
    }
  }

  Future<void> _launchContact(String method, String contact) async {
    String url = '';
    switch (method) {
      case 'Call':
        url = 'tel:$contact';
        break;
      case 'Message':
        url = 'sms:$contact';
        break;
      case 'Email':
        url = 'mailto:$contact';
        break;
    }
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      debugPrint('❌ Cannot launch $url');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Could not launch contact method')),
        );
      }
    }
  }

  Widget _buildInvestorCard(InvestorProfile investor) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: Colors.teal.shade100,
          child: Text(
            investor.name.isNotEmpty ? investor.name[0].toUpperCase() : '?',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          investor.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (investor.location.isNotEmpty)
              Text('🌍 Location: ${investor.location}'),
            if (investor.interests.isNotEmpty)
              Text('💼 Interests: ${investor.interests.join(', ')}'),
            if (investor.preferredHorizons.isNotEmpty)
              Text('⏳ Horizons: ${investor.preferredHorizons.map((e) => e.name).join(', ')}'),
            Text('📊 Status: ${investor.status.name}'),
          ],
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          tooltip: 'Contact Options',
          onSelected: (value) => _launchContact(value, investor.contact),
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'Call', child: Text('Call')),
            PopupMenuItem(value: 'Message', child: Text('Message')),
            PopupMenuItem(value: 'Email', child: Text('Email')),
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
                        _buildInvestorCard(_investors[index]),
                  ),
                ),
    );
  }
}
