import 'package:flutter/material.dart';

/// App Routes Configuration
class AppRoutes {
  // Authentication Routes
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerification = '/otp-verification';
  static const String pinSetup = '/pin-setup';
  static const String biometricSetup = '/biometric-setup';
  
  // Main App Routes
  static const String home = '/home';
  static const String stocks = '/stocks';
  static const String stockDetail = '/stock-detail';
  static const String stockChart = '/stock-chart';
  
  // Trading Routes
  static const String buyStock = '/buy-stock';
  static const String sellStock = '/sell-stock';
  static const String orderConfirmation = '/order-confirmation';
  static const String orderHistory = '/order-history';
  
  // Portfolio Routes
  static const String portfolio = '/portfolio';
  static const String holdings = '/holdings';
  static const String positions = '/positions';
  
  // Watchlist Routes
  static const String watchlist = '/watchlist';
  static const String createWatchlist = '/create-watchlist';
  
  // F&O Routes
  static const String futuresAndOptions = '/fno';
  static const String optionChain = '/option-chain';
  
  // Mutual Funds Routes
  static const String mutualFunds = '/mutual-funds';
  static const String mutualFundDetail = '/mutual-fund-detail';
  
  // UPI Routes
  static const String upi = '/upi';
  static const String addMoney = '/add-money';
  static const String paymentHistory = '/payment-history';
  static const String upiSettings = '/upi-settings';
  
  // Loans Routes
  static const String loans = '/loans';
  static const String loanApplication = '/loan-application';
  
  // Alerts Routes
  static const String alerts = '/alerts';
  static const String createAlert = '/create-alert';
  
  // Profile & Settings Routes
  static const String profile = '/profile';
  static const String accountDetails = '/account-details';
  static const String tradingDetails = '/trading-details';
  static const String bankDetails = '/bank-details';
  static const String nominees = '/nominees';
  static const String settings = '/settings';
  static const String changePassword = '/change-password';
  
  // News Routes
  static const String news = '/news';
  static const String newsDetail = '/news-detail';
  
  // Algo Trading Routes
  static const String algoTrading = '/algo-trading';
  static const String algoSettings = '/algo-settings';
  static const String algoBacktest = '/algo-backtest';
  
  // AI Features Routes
  static const String aiAnalysis = '/ai-analysis';
  static const String aiPrediction = '/ai-prediction';
  
  // Help & Support Routes
  static const String help = '/help';
  static const String support = '/support';
  static const String faq = '/faq';
  
  // Other Routes
  static const String search = '/search';
  static const String notifications = '/notifications';
  static const String referAndEarn = '/refer-and-earn';
  static const String reports = '/reports';
  static const String about = '/about';
  
  /// Get Route Generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(), // SplashScreen()
          settings: settings,
        );
      
      case login:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(), // LoginScreen()
          settings: settings,
        );
      
      case home:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(), // HomeScreen()
          settings: settings,
        );
      
      case stockDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => const Placeholder(), // StockDetailScreen(stockId: args?['stockId'])
          settings: settings,
        );
      
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
  
  /// Navigate to route
  static Future<T?> navigateTo<T>(BuildContext context, String route, {Object? arguments}) {
    return Navigator.pushNamed<T>(context, route, arguments: arguments);
  }
  
  /// Navigate and replace
  static Future<T?> navigateAndReplace<T>(BuildContext context, String route, {Object? arguments}) {
    return Navigator.pushReplacementNamed<T>(context, route, arguments: arguments);
  }
  
  /// Navigate and remove all previous routes
  static Future<T?> navigateAndRemoveUntil<T>(BuildContext context, String route, {Object? arguments}) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      context,
      route,
      (route) => false,
      arguments: arguments,
    );
  }
  
  /// Go back
  static void goBack(BuildContext context, {Object? result}) {
    Navigator.pop(context, result);
  }
}
