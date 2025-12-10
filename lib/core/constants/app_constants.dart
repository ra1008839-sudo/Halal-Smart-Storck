class AppConstants {
  // App Info
  static const String appName = 'Halal Smart Stock';
  static const String appVersion = '1.0.0';
  
  // API Endpoints
  static const String baseUrl = 'https://api.halalsmartstock.com';
  static const String wsUrl = 'wss://ws.halalsmartstock.com';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String stocksCollection = 'stocks';
  static const String ordersCollection = 'orders';
  static const String portfolioCollection = 'portfolio';
  static const String watchlistCollection = 'watchlist';
  static const String transactionsCollection = 'transactions';
  
  // Storage Keys
  static const String userKey = 'user_data';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
  static const String pinKey = 'user_pin';
  static const String biometricKey = 'biometric_enabled';
  
  // Chart Timeframes
  static const List<String> timeframes = [
    '1m', '3m', '5m', '15m', '30m', '1h', 
    '1D', '5D', '1M', '3M', '6M', '1Y', '5Y'
  ];
  
  // Order Types
  static const List<String> orderTypes = [
    'Market',
    'Limit',
    'Stop Loss',
    'Stop Loss Limit'
  ];
  
  // Transaction Types
  static const String buy = 'BUY';
  static const String sell = 'SELL';
  
  // Risk Management
  static const double maxLossPercentage = 2.0;
  static const double minTrailingStopLoss = 0.5;
  static const double maxTrailingStopLoss = 10.0;
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Sound Files
  static const String buySoundPath = 'assets/sounds/buy.mp3';
  static const String sellSoundPath = 'assets/sounds/sell.mp3';
  static const String notificationSoundPath = 'assets/sounds/notification.mp3';
  
  // Quick Amount Options (for adding money)
  static const List<int> quickAmounts = [
    100, 500, 1000, 2000, 5000, 10000
  ];
  
  // Indian Indices
  static const Map<String, String> indices = {
    'NIFTY': 'NIFTY 50',
    'SENSEX': 'SENSEX',
    'BANKNIFTY': 'BANK NIFTY',
    'NIFTYJR': 'NIFTY NEXT 50',
  };
  
  // Halal Status
  static const String halalVerified = 'HALAL_VERIFIED';
  static const String halalCompliant = 'HALAL_COMPLIANT';
  static const String nonHalal = 'NON_HALAL';
  static const String underReview = 'UNDER_REVIEW';
  
  // FII/DII Timer
  static const int fiiDiiTimerSeconds = 45;
  
  // API Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration wsTimeout = Duration(seconds: 60);
  
  // Regex Patterns
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phonePattern = r'^[6-9]\d{9}$';
  static const String pinPattern = r'^\d{4,6}$';
  
  // Error Messages
  static const String networkError = 'Network error. Please check your connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String authError = 'Authentication failed. Please login again.';
  static const String invalidInput = 'Invalid input. Please check your data.';
}
