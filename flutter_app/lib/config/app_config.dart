/// App Configuration
class AppConfig {
  static const String appName = 'Halal Smart Stock';
  static const String appVersion = '1.0.0';
  static const String companyName = 'Halal Stock Trading';
  
  // API Configuration
  static const String baseUrl = 'https://api.halalsmartstock.com';
  static const String socketUrl = 'wss://ws.halalsmartstock.com';
  
  // WebSocket Configuration
  static const int websocketReconnectDelay = 3000; // 3 seconds
  static const int priceUpdateInterval = 3000; // 3 seconds
  
  // Trading Configuration
  static const double maxLossPercentage = 2.0; // Max 2% loss per trade
  static const double minTrailingStopLoss = 0.5; // 0.5%
  static const double maxTrailingStopLoss = 10.0; // 10%
  static const int maxPositions = 10;
  
  // Cache Configuration
  static const int cacheExpiryHours = 24;
  static const int newsFreshHours = 18;
  
  // FII/DII Configuration
  static const int fiiDiiTimerSeconds = 45;
  
  // News Refresh Configuration
  static const int newsRefreshHourStart = 9;
  static const int newsRefreshHourEnd = 10;
  
  // App Performance
  static const int targetFPS = 60;
  static const int maxLaunchTimeMS = 2000; // <2 seconds
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String stocksCollection = 'stocks';
  static const String ordersCollection = 'orders';
  static const String portfolioCollection = 'portfolio';
  static const String watchlistCollection = 'watchlist';
  static const String alertsCollection = 'alerts';
  
  // Feature Flags
  static const bool enableBiometric = true;
  static const bool enableVoiceCommands = true;
  static const bool enableAIFeatures = true;
  static const bool enableAlgoTrading = true;
}
