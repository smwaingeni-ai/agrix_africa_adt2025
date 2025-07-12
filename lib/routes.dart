import 'package:flutter/material.dart';

// 🔹 Core Screens
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_user_screen.dart';
import 'screens/landing_page.dart';
import 'screens/advice_screen.dart';
import 'screens/logbook_screen.dart';
import 'screens/market_screen.dart';
import 'screens/loan_screen.dart';
import 'screens/farmer_profile_screen.dart';
import 'screens/credit_score_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/crops_screen.dart';
import 'screens/agrigpt_screen.dart';
import 'screens/sync_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/tips_screen.dart';
import 'screens/help_screen.dart';

// 🔹 Dashboards
import 'screens/dashboards/officer_dashboard.dart';
import 'screens/dashboards/official_dashboard.dart';
import 'screens/dashboards/admin_panel.dart';
import 'screens/dashboards/trader_dashboard.dart';
import 'screens/dashboards/investor_dashboard.dart';

// 🔹 Contracts & Investments
import 'screens/contracts/contract_list_screen.dart';
import 'screens/contracts/contract_offer_form.dart';
import 'screens/investments/investment_offer_screen.dart';
import 'screens/investments/investor_list_screen.dart';
import 'screens/investments/investor_registration_screen.dart';

// 🔹 AREX Officer Tools
import 'screens/arex_officer_dashboard.dart';
import 'screens/tasks/task_entry_screen.dart';
import 'screens/assessments/field_assessment_screen.dart';
import 'screens/training/training_log_screen.dart';
import 'screens/programs/program_tracking_screen.dart';
import 'screens/sustainability/sustainability_log_screen.dart';

/// ✅ Centralized App Route Map
final Map<String, WidgetBuilder> appRoutes = {
  // 🔸 Authentication & Home
  '/': (context) => const LoginScreen(),
  '/register': (context) => const RegisterUserScreen(),

  '/landing': (context) {
    final user = ModalRoute.of(context)!.settings.arguments as UserModel;
    return LandingPage(loggedInUser: user);
  },

  // 🔸 Dashboards
  '/officer_dashboard': (context) => const OfficerDashboard(),
  '/official_dashboard': (context) => const OfficialDashboard(),
  '/admin_panel': (context) => const AdminPanel(),
  '/trader_dashboard': (context) => const TraderDashboard(),
  '/investor_dashboard': (context) => const InvestorDashboard(),

  // 🔸 Core Features
  '/advice': (context) => const AdviceScreen(),
  '/logbook': (context) => const LogbookScreen(),
  '/market': (context) => const MarketScreen(),
  '/loan': (context) => const LoanScreen(),
  '/profile': (context) => const FarmerProfileScreen(),
  '/creditScore': (context) => const CreditScoreScreen(),
  '/chat': (context) => const ChatScreen(),
  '/crops': (context) => const CropsScreen(),
  '/agrigpt': (context) => const AgriGPTScreen(),
  '/sync': (context) => const SyncScreen(),
  '/notifications': (context) => const NotificationsScreen(),
  '/tips': (context) => const TipsScreen(),
  '/help': (context) => const HelpScreen(),

  // 🔸 Contracts & Investments
  '/contracts/list': (context) => const ContractListScreen(),
  '/contracts/new': (context) => const ContractOfferFormScreen(),
  '/investments': (context) => const InvestmentOffersScreen(),
  '/investors': (context) => const InvestorListScreen(),
  '/investor/register': (context) => const InvestorRegistrationScreen(),

  // 🔸 AREX Officer Tools
  '/arex_officer_dashboard': (context) => const ArexOfficerDashboard(),
  '/task_entry': (context) => const TaskEntryScreen(),
  '/fieldAssessment': (context) => const FieldAssessmentScreen(),
  '/training_log': (context) => const TrainingLogScreen(),
  '/program_tracking': (context) => const ProgramTrackingScreen(),
  '/sustainability_log': (context) => const SustainabilityLogScreen(),
};
