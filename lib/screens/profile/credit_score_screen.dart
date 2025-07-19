import 'package:flutter/material.dart';
import 'package:agrix_africa_adt2025/models/farmer_profile.dart';

class CreditScoreScreen extends StatelessWidget {
  final FarmerProfile farmer;

  const CreditScoreScreen({super.key, required this.farmer});

  int calculateScore(FarmerProfile farmer) {
    int score = 600;
    if (farmer.subsidised) score += 50;
    if (farmer.farmSize > 5) score += 30;
    if (farmer.region.toLowerCase().contains('irrigated')) score += 20;
    return score.clamp(300, 850); // score out of 850
  }

  @override
  Widget build(BuildContext context) {
    final score = calculateScore(farmer);

    return Scaffold(
      appBar: AppBar(title: const Text('Credit Score')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Your Estimated Credit Score',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                Text(
                  '$score / 850',
                  style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                const SizedBox(height: 20),
                const Text(
                  'This score is based on your farm size, subsidy status, and region.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
