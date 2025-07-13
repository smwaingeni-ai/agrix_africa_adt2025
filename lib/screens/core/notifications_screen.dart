import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  final List<String> _notifications = const [
    '🌾 Crop advisory updated.',
    '🚨 Disease alert in your area.',
    '📦 New subsidy programs announced.',
    '📶 Your data sync was successful.',
    '🆕 Agri Market Day scheduled for next week.',
    '📊 Weather forecast model updated.',
    '👨‍🌾 New AREX training programs now available.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🔔 Notifications'),
        centerTitle: true,
      ),
      body: _notifications.isEmpty
          ? const Center(child: Text('No notifications at this time.'))
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _notifications.length,
              separatorBuilder: (_, __) => const Divider(thickness: 0.6),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.notifications_active_outlined, color: Colors.green),
                  title: Text(
                    _notifications[index],
                    style: const TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("📬 Opened: ${_notifications[index]}")),
                    );
                  },
                );
              },
            ),
    );
  }
}
