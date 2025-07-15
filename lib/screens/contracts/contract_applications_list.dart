import 'package:flutter/material.dart';
import 'package:agrix_africa_adt2025/models/contracts/contract_offer.dart';
import 'package:agrix_africa_adt2025/models/contracts/contract_application.dart';
import 'package:agrix_africa_adt2025/services/contracts/contract_application_service.dart';

class ContractApplicationsListScreen extends StatefulWidget {
  final ContractOffer offer;

  const ContractApplicationsListScreen({super.key, required this.offer});

  @override
  State<ContractApplicationsListScreen> createState() => _ContractApplicationsListScreenState();
}

class _ContractApplicationsListScreenState extends State<ContractApplicationsListScreen> {
  List<ContractApplication> _applications = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadApplications();
  }

  Future<void> _loadApplications() async {
    try {
      final apps = await ContractApplicationService().loadApplications(widget.offer.id);
      setState(() {
        _applications = apps;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Failed to load applications: $e')),
      );
    }
  }

  Widget _buildApplicationCard(ContractApplication app) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.account_circle, color: Colors.green, size: 36),
        title: Text(app.farmerName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('📍 Location: ${app.farmLocation}'),
              Text('📞 Contact: ${app.contactInfo}'),
              if (app.notes.isNotEmpty) Text('📝 Notes: ${app.notes}'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final offer = widget.offer;

    return Scaffold(
      appBar: AppBar(
        title: Text('📑 Applicants for "${offer.title}"'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _applications.isEmpty
              ? const Center(child: Text('No applications yet.'))
              : ListView.builder(
                  itemCount: _applications.length,
                  itemBuilder: (context, index) => _buildApplicationCard(_applications[index]),
                ),
    );
  }
}
