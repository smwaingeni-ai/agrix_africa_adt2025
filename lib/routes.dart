import 'package:flutter/material.dart';

// Models
import 'models/contracts/contract_offer.dart';
import 'models/market/market_item.dart';
import 'models/investments/investor_profile.dart'; // ✅ Correct

// Core Screens
import 'screens/core/landing_screen.dart';
import 'screens/core/landing_page.dart';
import 'screens/core/language_country_setup.dart';
import 'screens/core/sync_screen.dart';
import 'screens/core/notifications_screen.dart';
import 'screens/core/transaction_screen.dart';

// Auth & Profile
import 'screens/auth/register_user_screen.dart';
import 'screens/profile/farmer_profile_screen.dart';

// Loans
import 'screens/loans/loan_application.dart';

// Contracts
import 'screens/contracts/contract_offer_form.dart';
import 'screens/contracts/contract_list_screen.dart';
import 'screens/contracts/contract_detail_screen.dart';

// Market
import 'screens/market/market_screen.dart';
import 'screens/market/market_item_form.dart';
import 'screens/market/market_detail_screen.dart';
import 'screens/market/market_invite_screen.dart';

// Investments
import 'screens/investments/investment_offer_form.dart'; // ✅ Corrected import
import 'screens/investments/investment_offers_screen.dart';
import 'screens/investments/investor_list_screen.dart';
import 'screens/investments/investor_registration_screen.dart';

// Officer Screens
import 'screens/officers/officer_tasks_screen.dart';
import 'screens/officers/field_assessment_screen.dart';

// Diagnostics
import 'screens/diagnostics/crops_screen.dart';
import 'screens/diagnostics/soil_screen.dart';
import 'screens/diagnostics/livestock_screen.dart';

// AI Advice
import 'screens/ai_advice/agrigpt_screen.dart';

// Logging
import 'screens/logs/logbook_screen.dart';
import 'screens/logs/program_tracking_screen.dart';
import 'screens/logs/sustainability_log_screen.dart';
import 'screens/logs/training_log_screen.dart';

// Chat & Help
import 'screens/chat_help/chat_screen.dart';
import 'screens/chat_help/help_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  // Core
  '/': (context) => const LandingPage(),
  '/home': (context) => const LandingScreen(),
  '/setup': (context) => const LanguageCountrySetup(),
  '/sync': (context) => const SyncScreen(),
  '/notifications': (context) => const NotificationsScreen(),
  '/transactions': (context) => const TransactionScreen(),

  // Auth & Profile
  '/register': (context) => const RegisterUserScreen(),
  '/profile': (context) => const FarmerProfileScreen(),

  // Loans
  '/loan': (context) => const LoanApplicationScreen(),

  // Contracts
  '/contracts/new': (context) => const ContractOfferFormScreen(),
  '/contracts/list': (context) => const ContractListScreen(),
  '/contracts/detail': (context) {
    final contract = ModalRoute.of(context)!.settings.arguments as ContractOffer;
    return ContractDetailScreen(contract: contract);
  },

  // Market
  '/market': (context) => const MarketScreen(),
  '/market/new': (context) => const MarketItemFormScreen(),
  '/market/detail': (context) {
    final item = ModalRoute.of(context)!.settings.arguments as MarketItem;
    return MarketDetailScreen(item: item);
  },
  '/market/invite': (context) => const MarketInviteScreen(),

  // Investments
  '/investments/new': (context) => const InvestmentOfferForm(), // ✅ Correct screen name
  '/investments/list': (context) => const InvestmentOffersScreen(),
  '/investors': (context) => const InvestorListScreen(),
  '/investors/new': (context) => const InvestorRegistrationScreen(),

  // Officers
  '/officer/tasks': (context) => const OfficerTasksScreen(),
  '/officer/assessments': (context) => const FieldAssessmentScreen(),

  // Diagnostics
  '/diagnostics/crops': (context) => const CropsScreen(),
  '/diagnostics/soil': (context) => const SoilScreen(),
  '/diagnostics/livestock': (context) => const LivestockScreen(),

  // AI Advice
  '/agrigpt': (context) => const AgriGPTScreen(),

  // Logs
  '/logs/farmer': (context) => const LogbookScreen(),
  '/logs/programs': (context) => const ProgramTrackingScreen(),
  '/logs/sustainability': (context) => const SustainabilityLogScreen(),
  '/logs/training': (context) => const TrainingLogScreen(),

  // Communication
  '/chat': (context) => const ChatScreen(),
  '/help': (context) => const HelpScreen(),
};
