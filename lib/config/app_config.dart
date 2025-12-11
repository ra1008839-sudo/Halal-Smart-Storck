class AppConfig {
  // App Info
  static const String appName = 'Halal Smart Stock';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Trade Smarter, Stay Halal';
  
  // API Configuration
  static const String baseUrl = 'https://api.halalsmartstock.com';
  static const String wsUrl = 'wss://ws.halalsmartstock.com';
  
  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Cache
  static const Duration cacheExpiry = Duration(minutes: 5);
  
  // Trading
  static const double minOrderValue = 1.0;
  static const double maxOrderValue = 1000000.0;
  static const int maxWatchlistItems = 50;
  
  // Algo Bot Configuration
  static const double maxRiskPerTrade = 0.02; // 2% max loss per trade
  static const double minTrailingStopLoss = 0.005; // 0.5%
  static const double maxTrailingStopLoss = 0.10; // 10%
  
  // Chart Configuration
  static const int defaultCandleCount = 100;
  static const List<String> timeframes = ['1m', '5m', '15m', '1h', '1d'];
  
  // RSI Settings
  static const int rsiPeriod = 14;
  static const double rsiOverbought = 70.0;
  static const double rsiOversold = 30.0;
  
  // MACD Settings
  static const int macdFastPeriod = 12;
  static const int macdSlowPeriod = 26;
  static const int macdSignalPeriod = 9;
  
  // Storage Keys
  static const String keyTheme = 'theme_mode';
  static const String keyUserId = 'user_id';
  static const String keyAuthToken = 'auth_token';
  static const String keyWatchlist = 'watchlist';
  static const String keyPortfolio = 'portfolio';
}
