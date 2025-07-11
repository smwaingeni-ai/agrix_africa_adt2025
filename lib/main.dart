import 'package:flutter/material.dart';
import 'routes.dart';

void main() {
  runApp(const AgriXApp());
}

class AgriXApp extends StatelessWidget {
  const AgriXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgriX Beta – ADT 2025',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      routes: appRoutes,
      initialRoute: '/',
    );
  }
}
