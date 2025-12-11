class ApiConfig {
  // Base URLs
  static const String baseUrl = 'https://api.halalsmartstock.com/v1';
  static const String wsBaseUrl = 'wss://ws.halalsmartstock.com';
  
  // Authentication Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  
  // Stock Endpoints
  static const String stocks = '/stocks';
  static const String stockDetail = '/stocks/{symbol}';
  static const String stockQuote = '/stocks/{symbol}/quote';
  static const String stockHistory = '/stocks/{symbol}/history';
  static const String stockCandles = '/stocks/{symbol}/candles';
  
  // Market Data Endpoints
  static const String marketIndices = '/market/indices';
  static const String topGainers = '/market/gainers';
  static const String topLosers = '/market/losers';
  static const String mostActive = '/market/active';
  
  // Watchlist Endpoints
  static const String watchlist = '/watchlist';
  static const String addToWatchlist = '/watchlist/add';
  static const String removeFromWatchlist = '/watchlist/remove';
  
  // Portfolio Endpoints
  static const String portfolio = '/portfolio';
  static const String portfolioSummary = '/portfolio/summary';
  static const String portfolioHoldings = '/portfolio/holdings';
  
  // Order Endpoints
  static const String orders = '/orders';
  static const String placeOrder = '/orders/place';
  static const String cancelOrder = '/orders/{orderId}/cancel';
  static const String orderHistory = '/orders/history';
  
  // F&O Endpoints
  static const String fnoList = '/fno/list';
  static const String optionChain = '/fno/option-chain';
  
  // Mutual Funds Endpoints
  static const String mutualFunds = '/mf/list';
  static const String mfDetails = '/mf/{schemeCode}';
  
  // UPI Endpoints
  static const String upiBalance = '/upi/balance';
  static const String upiTransactions = '/upi/transactions';
  static const String upiTransfer = '/upi/transfer';
  
  // Loan Endpoints
  static const String loanOffers = '/loans/offers';
  static const String loanApply = '/loans/apply';
  static const String loanStatus = '/loans/status';
  
  // WebSocket Endpoints
  static const String wsMarketData = '/ws/market';
  static const String wsOrderUpdates = '/ws/orders';
  
  // Helper method to build URL with path parameters
  static String buildUrl(String endpoint, Map<String, String> params) {
    String url = endpoint;
    params.forEach((key, value) {
      url = url.replaceAll('{$key}', value);
    });
    return url;
  }
}
