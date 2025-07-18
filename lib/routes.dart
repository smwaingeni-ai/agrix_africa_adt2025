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

// AI Advice & Chat
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

// Models
import 'models/contracts/contract_offer.dart';
import 'models/market/market_item.dart';
import 'models/dummy_user.dart';

final DummyUser dummyUser = DummyUser();

final Map<String, WidgetBuilder> appRoutes = {
  // Core
  '/': (context) => LandingPage(loggedInUser: dummyUser),
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
  '/investors/register': (context) => const InvestorRegistrationScreen(),
  '/investors/list': (context) => const InvestorListScreen(),

  // Contracts
  '/contracts/offer': (context) => const ContractOfferForm(),
  '/contracts/list': (context) => const ContractListScreen(),
  '/contracts/detail': (context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is ContractOffer) {
      return ContractDetailScreen(contract: args);
    }
    return const Scaffold(body: Center(child: Text('Invalid contract data')));
  },

  // Market
  '/market': (context) => const MarketScreen(),
  '/market/new': (context) => const MarketItemForm(),
  '/market/detail': (context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is MarketItem) {
      return MarketDetailScreen(item: args);
    }
    return const Scaffold(body: Center(child: Text('Invalid market item')));
  },
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
