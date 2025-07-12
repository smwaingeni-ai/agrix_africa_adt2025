import 'package:flutter/material.dart';
import '../../models/contracts/contract_offer.dart';
import '../../models/contracts/contract_application.dart';
import '../../services/contracts/contract_application_service.dart';

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
    final apps = await ContractApplicationService().loadApplications(widget.offer.id);
    setState(() {
      _applications = apps;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final offer = widget.offer;

    return Scaffold(
      appBar: AppBar(
        title: Text('Applicants: ${offer.title}'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _applications.isEmpty
              ? const Center(child: Text('No applications yet.'))
              : ListView.builder(
                  itemCount: _applications.length,
                  itemBuilder: (context, index) {
                    final app = _applications[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.account_circle, color: Colors.green),
                        title: Text(app.farmerName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Location: ${app.farmLocation}'),
                            Text('Contact: ${app.contactInfo}'),
                            if (app.notes.isNotEmpty) Text('Notes: ${app.notes}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
