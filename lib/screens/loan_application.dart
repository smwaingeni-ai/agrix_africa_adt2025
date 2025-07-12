import 'package:flutter/material.dart';
import '../models/farmer_profile.dart';
import '../services/farmer_service.dart';

class LoanApplicationScreen extends StatefulWidget {
  const LoanApplicationScreen({super.key});

  @override
  State<LoanApplicationScreen> createState() => _LoanApplicationScreenState();
}

class _LoanApplicationScreenState extends State<LoanApplicationScreen> {
  FarmerProfile? _selectedFarmer;
  final TextEditingController _amountController = TextEditingController();
  final Map<String, FarmerProfile> _farmerMap = {};

  @override
  void initState() {
    super.initState();
    FarmerService.loadFarmers().then((farmers) {
      setState(() {
        for (var farmer in farmers) {
          _farmerMap[farmer.id] = farmer;
        }
      });
    });
  }

  double _scoreFarmer(FarmerProfile f) {
    double score = (f.farmSizeHectares ?? 0.0) * (f.govtAffiliated ? 1.5 : 1.0);
    return score.clamp(0, 100);
  }

  void _submitLoanApplication() {
    final amount = double.tryParse(_amountController.text);
    if (_selectedFarmer == null || amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('⚠️ Please select a farmer and enter a valid amount.')),
      );
      return;
    }

    final score = _scoreFarmer(_selectedFarmer!);
    final approved = score > 30;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Loan Application Result'),
        content: Text(
          approved
              ? '✅ Loan Approved!\nScore: ${score.toStringAsFixed(1)}'
              : '❌ Loan Not Approved.\nScore: ${score.toStringAsFixed(1)}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apply for Loan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<FarmerProfile>(
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Select Farmer'),
              items: _farmerMap.values.map((farmer) {
                return DropdownMenuItem(
                  value: farmer,
                  child: Text('${farmer.name} (${farmer.govtAffiliated ? 'Govt' : 'Private'})'),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedFarmer = value),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Loan Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _submitLoanApplication,
              icon: const Icon(Icons.check),
              label: const Text('Submit Loan'),
            ),
          ],
        ),
      ),
    );
  }
}
