import 'package:flutter/material.dart';
import 'screens/core/home_screen.dart';
import 'screens/core/landing_page.dart';
import 'screens/core/language_country_setup.dart';
import 'screens/core/sync_screen.dart';
import 'screens/core/notifications_screen.dart';
import 'screens/core/transaction_screen.dart';

import 'screens/profile/register_user_screen.dart';
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
import 'screens/officers/officer_assessments_screen.dart';

import 'screens/diagnostics/crops_screen.dart';
import 'screens/diagnostics/soil_screen.dart';
import 'screens/diagnostics/livestock_screen.dart';

import 'screens/ai_advice/agrigpt_screen.dart';

import 'screens/logs/farmer_logbook_screen.dart';
import 'screens/logs/program_tracking_screen.dart';
import 'screens/logs/sustainability_log_screen.dart';
import 'screens/logs/training_log_screen.dart';

import 'screens/chat_help/chat_screen.dart';
import 'screens/chat_help/help_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => LandingPage(),
  '/home': (context) => HomeScreen(),
  '/setup': (context) => LanguageCountrySetup(),
  '/sync': (context) => SyncScreen(),
  '/notifications': (context) => NotificationsScreen(),
  '/transactions': (context) => TransactionScreen(),

  '/register': (context) => RegisterUserScreen(),
  '/profile': (context) => FarmerProfileScreen(),

  '/loan': (context) => LoanApplicationScreen(),

  '/contracts/new': (context) => ContractOfferFormScreen(),
  '/contracts/list': (context) => ContractListScreen(),
  '/contracts/detail': (context) => ContractDetailScreen(),

  '/market': (context) => MarketScreen(),
  '/market/new': (context) => MarketItemFormScreen(),
  '/market/detail': (context) => MarketDetailScreen(),
  '/market/invite': (context) => MarketInviteScreen(),

  '/investments/new': (context) => InvestmentOfferScreen(),
  '/investments/list': (context) => InvestmentOffersScreen(),
  '/investors': (context) => InvestorListScreen(),
  '/investors/new': (context) => InvestorRegistrationScreen(),

  '/officer/tasks': (context) => OfficerTasksScreen(),
  '/officer/assessments': (context) => OfficerAssessmentsScreen(),

  '/diagnostics/crops': (context) => CropsScreen(),
  '/diagnostics/soil': (context) => SoilScreen(),
  '/diagnostics/livestock': (context) => LivestockScreen(),

  '/agrigpt': (context) => AgriGPTScreen(),

  '/logs/farmer': (context) => FarmerLogbookScreen(),
  '/logs/programs': (context) => ProgramTrackingScreen(),
  '/logs/sustainability': (context) => SustainabilityLogScreen(),
  '/logs/training': (context) => TrainingLogScreen(),

  '/chat': (context) => ChatScreen(),
  '/help': (context) => HelpScreen(),
};
