import 'package:flutter/material.dart';

import 'models/contracts/contract_offer.dart';
import 'models/market/market_item.dart';

import 'screens/core/landing_screen.dart';
import 'screens/core/landing_page.dart';
import 'screens/core/language_country_setup.dart';
import 'screens/core/sync_screen.dart';
import 'screens/core/notifications_screen.dart';
import 'screens/core/transaction_screen.dart';

import 'screens/auth/register_user_screen.dart';
import 'screens/profile/farmer_profile_screen.dart';

import 'screens/loans/loan_application.dart';

import 'screens/contracts/contract_offer_form.dart';
import 'screens/contracts/contract_list_screen.dart';
import 'screens/contracts/contract_detail_screen.dart';

import 'screens/market/market_screen.dart';
import 'screens/market/market_item_form.dart';
import 'screens/market/market_detail_screen.dart';
import 'screens/market/market_invite_screen.dart';

import 'screens/investments/investment_offer_screen.dart';
import 'screens/investments/investment_offers_screen.dart';
import 'screens/investments/investor_list_screen.dart';
import 'screens/investments/investor_registration_screen.dart';

import 'screens/officers/officer_tasks_screen.dart';
import 'screens/officers/field_assessment_screen.dart';

import 'screens/diagnostics/crops_screen.dart';
import 'screens/diagnostics/soil_screen.dart';
import 'screens/diagnostics/livestock_screen.dart';

import 'screens/ai_advice/agrigpt_screen.dart';

import 'screens/logs/logbook_screen.dart';
import 'screens/logs/program_tracking_screen.dart';
import 'screens/logs/sustainability_log_screen.dart';
import 'screens/logs/training_log_screen.dart';

import 'screens/chat_help/chat_screen.dart';
import 'screens/chat_help/help_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const LandingPage(),
  '/home': (context) => const LandingScreen(),
  '/setup': (context) => const LanguageCountrySetup(),
  '/sync': (context) => const SyncScreen(),
  '/notifications': (context) => const NotificationsScreen(),
  '/transactions': (context) => const TransactionScreen(),

  '/register': (context) => const RegisterUserScreen(),
  '/profile': (context) => const FarmerProfileScreen(),

  '/loan': (context) => const LoanApplicationScreen(),

  '/contracts/new': (context) => const ContractOfferFormScreen(),
  '/contracts/list': (context) => const ContractListScreen(),
  '/contracts/detail': (context) {
    final contract = ModalRoute.of(context)!.settings.arguments as ContractOffer;
    return ContractDetailScreen(contract: contract);
  },

  '/market': (context) => const MarketScreen(),
  '/market/new': (context) => const MarketItemFormScreen(),
  '/market/detail': (context) {
    final item = ModalRoute.of(context)!.settings.arguments as MarketItem;
    return MarketDetailScreen(item: item);
  },
  '/market/invite': (context) => const MarketInviteScreen(),

  '/investments/new': (context) => const InvestmentOfferScreen(),
  '/investments/list': (context) => const InvestmentOffersScreen(),
  '/investors': (context) => const InvestorListScreen(),
  '/investors/new': (context) => const InvestorRegistrationScreen(),

  '/officer/tasks': (context) => const OfficerTasksScreen(),
  '/officer/assessments': (context) => const FieldAssessmentScreen(),

  '/diagnostics/crops': (context) => const CropsScreen(),
  '/diagnostics/soil': (context) => const SoilScreen(),
  '/diagnostics/livestock': (context) => const LivestockScreen(),

  '/agrigpt': (context) => const AgriGPTScreen(),

  '/logs/farmer': (context) => const LogbookScreen(),
  '/logs/programs': (context) => const ProgramTrackingScreen(),
  '/logs/sustainability': (context) => const SustainabilityLogScreen(),
  '/logs/training': (context) => const TrainingLogScreen(),

  '/chat': (context) => const ChatScreen(),
  '/help': (context) => const HelpScreen(),
};
