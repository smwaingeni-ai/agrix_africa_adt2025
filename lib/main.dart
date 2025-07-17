import 'package:flutter/material.dart';
import 'routes.dart';
import 'models/farmer_profile.dart';
import 'models/user_model.dart';
import 'services/profile_service.dart';
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
      home: const StartupDecider(), // Initial screen is decided dynamically
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
    final profile = await ProfileService.loadActiveProfile();

    setState(() {
      _initialScreen = profile != null
          ? LandingPage(loggedInUser: UserModel.fromFarmer(profile))
          : const LanguageCountrySetup();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _initialScreen ??
        const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
  }
}
