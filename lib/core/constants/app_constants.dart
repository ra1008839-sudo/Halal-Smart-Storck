class AppConstants {
  // App Information
  static const String appName = 'Halal Smart Stock';
  static const String appVersion = '1.0.0';
  static const String appBuild = '1';
  
  // Animation Durations
  static const Duration animationDurationFast = Duration(milliseconds: 200);
  static const Duration animationDurationNormal = Duration(milliseconds: 300);
  static const Duration animationDurationSlow = Duration(milliseconds: 500);
  static const Duration splashDuration = Duration(seconds: 2);
  
  // Spacing
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;
  
  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  
  // Icon Sizes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeXLarge = 48.0;
  
  // Font Sizes
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 14.0;
  static const double fontSizeLarge = 16.0;
  static const double fontSizeXLarge = 18.0;
  static const double fontSizeHeading = 24.0;
  
  // Market Status
  static const String marketOpen = 'OPEN';
  static const String marketClosed = 'CLOSED';
  static const String marketPreOpen = 'PRE_OPEN';
  static const String marketPostClose = 'POST_CLOSE';
  
  // Order Types
  static const String orderTypeMarket = 'MARKET';
  static const String orderTypeLimit = 'LIMIT';
  static const String orderTypeStopLoss = 'STOP_LOSS';
  
  // Order Status
  static const String orderStatusPending = 'PENDING';
  static const String orderStatusExecuted = 'EXECUTED';
  static const String orderStatusCancelled = 'CANCELLED';
  static const String orderStatusRejected = 'REJECTED';
  
  // Transaction Types
  static const String transactionBuy = 'BUY';
  static const String transactionSell = 'SELL';
  
  // Time Formats
  static const String timeFormat24Hour = 'HH:mm';
  static const String dateFormatShort = 'dd MMM yyyy';
  static const String dateFormatLong = 'dd MMMM yyyy';
  static const String dateTimeFormat = 'dd MMM yyyy, HH:mm';
  
  // Number Formats
  static const String currencySymbol = '₹';
  static const int decimalPlaces = 2;
  static const int percentageDecimalPlaces = 2;
  
  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 32;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 20;
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Chart
  static const int defaultCandleCount = 100;
  static const int maxCandleCount = 500;
  
  // Halal Stock Categories
  static const List<String> halalCategories = [
    'Technology',
    'Healthcare',
    'Consumer Goods',
    'Industrial',
    'Utilities',
    'Materials',
    'Telecom',
    'Energy',
  ];
  
  // Bottom Navigation Tabs
  static const List<String> bottomNavTabs = [
    'Stocks',
    'F&O',
    'Mutual Funds',
    'UPI',
    'Loans',
  ];
  
  // Error Messages
  static const String errorGeneric = 'Something went wrong. Please try again.';
  static const String errorNetwork = 'Network error. Please check your internet connection.';
  static const String errorTimeout = 'Request timeout. Please try again.';
  static const String errorUnauthorized = 'Unauthorized. Please login again.';
  static const String errorNotFound = 'Resource not found.';
  
  // Success Messages
  static const String successLogin = 'Login successful!';
  static const String successLogout = 'Logout successful!';
  static const String successOrderPlaced = 'Order placed successfully!';
  static const String successOrderCancelled = 'Order cancelled successfully!';
}
