import 'package:flutter/material.dart';
import 'routes.dart'; // Make sure this file is correctly set up
import 'screens/core/language_country_setup.dart'; // Startup screen

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
      // Starts with the language and region setup screen
      home: const LanguageCountrySetupScreen(), // 🌍 Initial screen
      routes: appRoutes, // ✅ From routes.dart
    );
  }
}
