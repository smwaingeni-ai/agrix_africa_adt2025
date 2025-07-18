import 'package:flutter/material.dart';
import 'package:agrix_africa_adt2025/models/farmer_profile.dart';
import 'package:agrix_africa_adt2025/models/farmer_profile.dart';

class CreditScoreScreen extends StatefulWidget {
  const CreditScoreScreen({super.key});

  @override
  State<CreditScoreScreen> createState() => _CreditScoreScreenState();
}

class _CreditScoreScreenState extends State<CreditScoreScreen> {
  List<FarmerProfile> _farmers = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadFarmers();
  }

  Future<void> _loadFarmers() async {
    final farmers = await FarmerProfileService.loadProfiles();
    farmers.sort((a, b) => _calculateScore(b).compareTo(_calculateScore(a)));
    setState(() {
      _farmers = farmers;
      _loading = false;
    });
  }

  double _calculateScore(FarmerProfile farmer) {
    final size = double.tryParse(farmer.farmSize) ?? 0.0;
    final bonus = farmer.subsidised ? 1.5 : 1.0;
    return (size * bonus).clamp(0, 100);
  }

  Widget _buildScoreCard(FarmerProfile farmer) {
    final score = _calculateScore(farmer);
    final approved = score >= 30;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: approved ? Colors.green : Colors.redAccent,
          child: Text(
            score.toInt().toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(farmer.name),
        subtitle: Text(
          'Score: ${score.toStringAsFixed(1)} • '
          'Farm Size: ${farmer.farmSize} ha • '
          'Subsidised: ${farmer.subsidised ? 'Yes' : 'No'}',
        ),
        trailing: Icon(
          approved ? Icons.check_circle : Icons.cancel,
          color: approved ? Colors.green : Colors.redAccent,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Credit Scoring')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _farmers.isEmpty
              ? const Center(child: Text('📭 No farmers found'))
              : RefreshIndicator(
                  onRefresh: _loadFarmers,
                  child: ListView.builder(
                    itemCount: _farmers.length,
                    itemBuilder: (context, index) =>
                        _buildScoreCard(_farmers[index]),
                  ),
                ),
    );
  }
}
