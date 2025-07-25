import 'package:flutter/material.dart';

// Core Screens
import 'screens/core/landing_page.dart';
import 'screens/core/sync_screen.dart';
import 'screens/core/notifications_screen.dart';

// Auth
import 'screens/auth/register_user_screen.dart';

// Logs
import 'screens/logs/logbook_screen.dart';
import 'screens/logs/program_tracking_screen.dart';
import 'screens/logs/sustainability_log_screen.dart';
import 'screens/logs/training_log_screen.dart';

// Investments
import 'screens/investments/investment_offer_screen.dart';
import 'screens/investments/investment_offers_screen.dart';
import 'screens/investments/investor_registration_screen.dart';
import 'screens/investments/investor_list_screen.dart';

// Contracts
import 'screens/contracts/contract_offer_form.dart';
import 'screens/contracts/contract_list_screen.dart';
import 'screens/contracts/contract_detail_screen.dart';

// Market
import 'screens/market/market_screen.dart';
import 'screens/market/market_item_form.dart';
import 'screens/market/market_detail_screen.dart';
import 'screens/market/market_invite_screen.dart';

// Diagnostics
import 'screens/diagnostics/crops_screen.dart';
import 'screens/diagnostics/soil_screen.dart';
import 'screens/diagnostics/livestock_screen.dart';

// AI & Chat
import 'screens/ai_advice/agrigpt_screen.dart';
import 'screens/chat_help/chat_screen.dart';
import 'screens/chat_help/help_screen.dart';

// Loans
import 'screens/loans/loan_screen.dart';

// Profile
import 'screens/profile/farmer_profile_screen.dart';
import 'screens/profile/credit_score_screen.dart';

// Officers
import 'screens/officers/officer_tasks_screen.dart';
import 'screens/officers/field_assessment_screen.dart';

// Models (for argument passing)
import 'models/contracts/contract_offer.dart';
import 'models/market/market_item.dart';
import 'models/user_model.dart'; // ✅ Keep this only here

final Map<String, WidgetBuilder> appRoutes = {
  // Core
  '/sync': (context) => const SyncScreen(),
  '/notifications': (context) => const NotificationsScreen(),

  // Auth
  '/register': (context) => const RegisterUserScreen(),

  // Logs
  '/logbook': (context) => const LogbookScreen(),
  '/logs/programs': (context) => const ProgramTrackingScreen(),
  '/logs/sustainability': (context) => const SustainabilityLogScreen(),
  '/logs/training': (context) => const TrainingLogScreen(),

  // Investments
  '/investments/offer': (context) => const InvestmentOfferForm(),
  '/investments/offers': (context) => const InvestmentOffersScreen(),
  '/investors/register': (context) => InvestorRegistrationScreen(),
  '/investors/list': (context) => const InvestorListScreen(),

  // Contracts
  '/contracts/offer': (context) => const ContractOfferForm(),
  '/contracts/list': (context) => const ContractListScreen(),

  // Market
  '/market': (context) => const MarketScreen(),
  '/market/new': (context) => const MarketItemForm(),
  '/market/invite': (context) => const MarketInviteScreen(),

  // Diagnostics
  '/diagnostics/crops': (context) => const CropsScreen(),
  '/diagnostics/soil': (context) => const SoilScreen(),
  '/diagnostics/livestock': (context) => const LivestockScreen(),

  // AI & Chat
  '/agrigpt': (context) => const AgriGPTScreen(),
  '/chat': (context) => const ChatScreen(),
  '/help': (context) => const HelpScreen(),

  // Profile
  '/profile': (context) => const FarmerProfileScreen(),
  '/score': (context) => const CreditScoreScreen(),

  // Loans
  '/loan': (context) => const LoanScreen(),

  // Officers
  '/officer/tasks': (context) => const OfficerTasksScreen(),
  '/officer/assessments': (context) => const FieldAssessmentScreen(),
};

/// Handle routes requiring arguments
Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/contracts/detail':
      final args = settings.arguments;
      if (args is ContractOffer) {
        return MaterialPageRoute(
          builder: (context) => ContractDetailScreen(contract: args),
        );
      }
      return _errorRoute('Invalid contract data');

    case '/market/detail':
      final args = settings.arguments;
      if (args is MarketItem) {
        return MaterialPageRoute(
          builder: (context) => MarketDetailScreen(item: args),
        );
      }
      return _errorRoute('Invalid market item');

    case '/landing':
      final args = settings.arguments;
      if (args is UserModel) {
        return MaterialPageRoute(
          builder: (context) => LandingPage(loggedInUser: args),
        );
      }
      return _errorRoute('Invalid user data for Landing Page');

    default:
      return _errorRoute('Page not found');
  }
}

Route<dynamic> _errorRoute(String message) {
  return MaterialPageRoute(
    builder: (context) => Scaffold(
      body: Center(child: Text(message)),
    ),
  );
}
