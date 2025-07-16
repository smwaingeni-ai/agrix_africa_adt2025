import 'package:flutter/material.dart';

// 🔹 Models
import 'models/user_model.dart';
import 'models/market_item.dart';

// 🔹 Authentication
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_user_screen.dart';

// 🔹 Core Screens
import 'screens/core/landing_page.dart';
import 'screens/core/language_country_setup.dart';
import 'screens/core/sync_screen.dart';
import 'screens/core/notifications_screen.dart';
import 'screens/core/transaction_screen.dart';

// 🔹 Profile
import 'screens/profile/farmer_profile_screen.dart';
import 'screens/profile/credit_score_screen.dart';

// 🔹 AI Advice
import 'screens/ai_advice/advice_screen.dart';
import 'screens/ai_advice/agrigpt_screen.dart';
import 'screens/ai_advice/tips_screen.dart';

// 🔹 Diagnostics
import 'screens/diagnostics/crops_screen.dart';
import 'screens/diagnostics/soil_screen.dart';
import 'screens/diagnostics/livestock_screen.dart';

// 🔹 Market
import 'screens/market/market_screen.dart';
import 'screens/market/market_detail_screen.dart';
import 'screens/market/market_item_form.dart';
import 'screens/market/market_invite_screen.dart';

// 🔹 Loans
import 'screens/loans/loan_screen.dart';
import 'screens/loans/loan_application.dart';

// 🔹 Officers
import 'screens/officers/arex_officer_dashboard.dart';
import 'screens/officers/officer_tasks_screen.dart';
import 'screens/officers/field_assessment_screen.dart';

// 🔹 Logs
import 'screens/logs/logbook_screen.dart';
import 'screens/logs/upload_screen.dart';

// 🔹 Chat & Help
import 'screens/chat_help/chat_screen.dart';
import 'screens/chat_help/help_screen.dart';

// 🔹 Dashboards
import 'screens/dashboards/officer_dashboard.dart';
import 'screens/dashboards/official_dashboard.dart';
import 'screens/dashboards/admin_panel.dart';
import 'screens/dashboards/trader_dashboard.dart';
import 'screens/dashboards/investor_dashboard.dart';

// 🔹 Contracts & Investments
import 'screens/contracts/contract_list_screen.dart';
import 'screens/contracts/contract_offer_form.dart';
import 'screens/investments/investment_offers_screen.dart';
import 'screens/investments/investor_list_screen.dart';
import 'screens/investments/investor_registration_screen.dart';

// 🔹 Special Logs
import 'screens/programs/program_tracking_screen.dart';
import 'screens/sustainability/sustainability_log_screen.dart';
import 'screens/training/training_log_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  // 🔐 Authentication
  '/': (context) => const LoginScreen(),
  '/register': (context) => const RegisterUserScreen(),

  // 🔧 Core Navigation
  '/landing': (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    return LandingPage(
      loggedInUser: args is UserModel ? args : UserModel.empty(),
    );
  },
  '/language-setup': (context) => const LanguageCountrySetup(),
  '/sync': (context) => const SyncScreen(),
  '/notifications': (context) => const NotificationsScreen(),
  '/transactions': (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    return TransactionScreen(result: args is String ? args : null);
  },

  // 👤 Profile
  '/profile': (context) => const FarmerProfileScreen(),
  '/credit-score': (context) => const CreditScoreScreen(),

  // 🤖 AI Advice
  '/advice': (context) => const AdviceScreen(),
  '/agrigpt': (context) => const AgriGPTScreen(),
  '/tips': (context) => const TipsScreen(),

  // 🧪 Diagnostics
  '/crops': (context) => const CropsScreen(),
  '/soil': (context) => const SoilScreen(),
  '/livestock': (context) => const LivestockScreen(),

  // 🛒 Market
  '/market': (context) => const MarketScreen(),
  '/market/detail': (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    return MarketDetailScreen(
      item: args is MarketItem ? args : MarketItem.empty(),
    );
  },
  '/market/form': (context) => const MarketItemForm(),
  '/market/invite': (context) => const MarketInviteScreen(),

  // 💰 Loans
  '/loan': (context) => const LoanScreen(),
  '/loan-application': (context) => const LoanApplicationScreen(),

  // 👨‍🌾 Officers
  '/arex-officer-dashboard': (context) => const ArexOfficerDashboard(),
  '/officer-tasks': (context) => const OfficerTasksScreen(),
  '/field-assessment': (context) => const FieldAssessmentScreen(),

  // 📓 Logs
  '/logbook': (context) => const LogbookScreen(),
  '/upload': (context) => const UploadScreen(),

  // 💬 Chat & Help
  '/chat': (context) => const ChatScreen(),
  '/help': (context) => const HelpScreen(),

  // 📊 Dashboards
  '/officer-dashboard': (context) => const OfficerDashboard(),
  '/official-dashboard': (context) => const OfficialDashboard(),
  '/admin-panel': (context) => const AdminPanel(),
  '/trader-dashboard': (context) => const TraderDashboard(),
  '/investor-dashboard': (context) => const InvestorDashboard(),

  // 📃 Contracts & 💼 Investments
  '/contracts/list': (context) => const ContractListScreen(),
  '/contracts/new': (context) => const ContractOfferFormScreen(),
  '/investments': (context) => const InvestmentOffersScreen(),
  '/investors': (context) => const InvestorListScreen(),
  '/investor/register': (context) => const InvestorRegistrationScreen(),

  // 🌱 Special Logs
  '/training-log': (context) => const TrainingLogScreen(),
  '/program-tracking': (context) => const ProgramTrackingScreen(),
  '/sustainability-log': (context) => const SustainabilityLogScreen(),

  // 🧭 Optional Aliases
  '/officer/tasks': (context) => const OfficerTasksScreen(),
  '/officer/assessments': (context) => const FieldAssessmentScreen(),
  '/program_tracking': (context) => const ProgramTrackingScreen(),
  '/sustainability_logs': (context) => const SustainabilityLogScreen(),
};
