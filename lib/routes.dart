import 'package:flutter/material.dart';
import 'screens/landing_page.dart';
import 'screens/advice_screen.dart';
import 'screens/logbook_screen.dart';
import 'screens/market_screen.dart';
import 'screens/loan_screen.dart';
import 'screens/farmer_profile_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const LandingPage(),
  '/advice': (context) => const AdviceScreen(),
  '/logbook': (context) => const LogbookScreen(),
  '/market': (context) => const MarketScreen(),
  '/loan': (context) => const LoanScreen(),
  '/profile': (context) => const FarmerProfileScreen(), // ✅ updating the farmer profile
};
