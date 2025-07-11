import 'package:flutter/material.dart';
import 'routes.dart'; // ✅ Your central route definitions

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
      // ✅ Starts with LoginScreen via '/' route
      initialRoute: '/',
      // ✅ Centralized route mapping from routes.dart
      routes: appRoutes,
    );
  }
}
