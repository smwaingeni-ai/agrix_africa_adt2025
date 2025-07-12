import 'package:flutter/material.dart';

// 🔹 Screens
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_user_screen.dart';
import 'screens/landing_page.dart';
import 'screens/advice_screen.dart';
import 'screens/logbook_screen.dart';
import 'screens/market_screen.dart';
import 'screens/loan_screen.dart';
import 'screens/farmer_profile_screen.dart';

// 🔹 Dashboards
import 'screens/dashboards/officer_dashboard.dart';
import 'screens/dashboards/official_dashboard.dart';
import 'screens/dashboards/admin_panel.dart';
import 'screens/dashboards/trader_dashboard.dart';
import 'screens/dashboards/investor_dashboard.dart';

// 🔹 Models
import 'models/user_model.dart';

/// ✅ Centralized App Route Map
final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const LoginScreen(), // ✅ Entry point of the app

  '/landing': (context) {
    final user = ModalRoute.of(context)!.settings.arguments as UserModel;
    return LandingPage(loggedInUser: user);
  },

  '/register': (context) => const RegisterUserScreen(),
  '/officer_dashboard': (context) => const OfficerDashboard(),
  '/official_dashboard': (context) => const OfficialDashboard(),
  '/admin_panel': (context) => const AdminPanel(),
  '/trader_dashboard': (context) => const TraderDashboard(),
  '/investor_dashboard': (context) => const InvestorDashboard(),

  // 🔸 Features
  '/advice': (context) => const AdviceScreen(),
  '/logbook': (context) => const LogbookScreen(),
  '/market': (context) => const MarketScreen(),
  '/loan': (context) => const LoanScreen(),
  '/profile': (context) => const FarmerProfileScreen(),
};
