import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = ['Soil', 'Crops', 'Livestock'];

    final Map<String, List<String>> tips = {
      'Soil': [
        '🪱 Rotate crops annually to improve soil nutrients.',
        '🧪 Test soil pH regularly to ensure optimal conditions.',
        '🌱 Use compost to boost soil fertility naturally.',
      ],
      'Crops': [
        '🌾 Water crops early in the morning or late evening to reduce evaporation.',
        '🛡️ Use disease-resistant crop varieties where available.',
        '👨‍🌾 Practice intercropping to reduce pest attacks.',
      ],
      'Livestock': [
        '🐄 Always provide clean drinking water to animals.',
        '💉 Vaccinate livestock regularly to prevent disease outbreaks.',
        '🌿 Ensure proper grazing rotation to prevent pasture degradation.',
      ],
    };

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('📘 AgriX Farming Tips'),
          centerTitle: true,
          bottom: TabBar(
            tabs: tabs.map((label) => Tab(text: label)).toList(),
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: tabs.map((category) {
            final items = tips[category] ?? [];

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final tip = items[index];

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.lightbulb, color: Colors.green),
                    title: Text(
                      tip,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
