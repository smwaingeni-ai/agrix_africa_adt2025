import 'package:flutter/material.dart';
import 'routes.dart';

// Corrected imports based on updated paths
import 'models/farmer_profile.dart';
import 'services/profile/farmer_profile_service.dart';

// Initial Screens
import 'screens/core/language_country_setup.dart';
import 'screens/core/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgriX App 🌾',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const StartupDecider(),
      routes: appRoutes,
    );
  }
}

class StartupDecider extends StatefulWidget {
  const StartupDecider({super.key});

  @override
  State<StartupDecider> createState() => _StartupDeciderState();
}

class _StartupDeciderState extends State<StartupDecider> {
  Widget? _initialScreen;

  @override
  void initState() {
    super.initState();
    _checkProfileAndNavigate();
  }

  Future<void> _checkProfileAndNavigate() async {
    try {
      final FarmerProfile? profile =
          await FarmerProfileService.loadActiveProfile();

      setState(() {
        _initialScreen = (profile != null)
            ? LandingPage(loggedInUser: profile)
            : const LanguageCountrySetup();
      });
    } catch (e) {
      debugPrint('❌ Error loading profile: $e');
      setState(() {
        _initialScreen = const LanguageCountrySetup();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _initialScreen ??
        const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
  }
}
