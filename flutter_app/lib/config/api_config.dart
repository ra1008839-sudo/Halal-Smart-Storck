/// API Configuration and Endpoints
class APIConfig {
  // Base URLs
  static const String baseUrl = 'https://api.halalsmartstock.com/v1';
  static const String socketUrl = 'wss://ws.halalsmartstock.com';
  
  // NSE/BSE Data APIs
  static const String nseBaseUrl = 'https://www.nseindia.com/api';
  static const String bseBaseUrl = 'https://api.bseindia.com/BseIndiaAPI';
  
  // Authentication Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyOTP = '/auth/verify-otp';
  static const String refreshToken = '/auth/refresh';
  
  // Stock Data Endpoints
  static const String stocks = '/stocks';
  static const String stockDetail = '/stocks/:id';
  static const String stockQuote = '/stocks/:id/quote';
  static const String stockChart = '/stocks/:id/chart';
  static const String stockNews = '/stocks/:id/news';
  static const String searchStocks = '/stocks/search';
  static const String halalStocks = '/stocks/halal';
  
  // Market Data Endpoints
  static const String marketStatus = '/market/status';
  static const String topGainers = '/market/top-gainers';
  static const String topLosers = '/market/top-losers';
  static const String mostTraded = '/market/most-traded';
  static const String marketTrends = '/market/trends';
  
  // FII/DII Endpoints
  static const String fiiDiiData = '/market/fii-dii';
  static const String fiiDiiHistory = '/market/fii-dii/history';
  
  // Technical Indicators Endpoints
  static const String indicators = '/indicators/:symbol';
  static const String rsi = '/indicators/:symbol/rsi';
  static const String macd = '/indicators/:symbol/macd';
  static const String bollingerBands = '/indicators/:symbol/bollinger';
  
  // Trading Endpoints
  static const String placeOrder = '/trading/order';
  static const String cancelOrder = '/trading/order/:id/cancel';
  static const String modifyOrder = '/trading/order/:id/modify';
  static const String orderHistory = '/trading/orders';
  static const String orderStatus = '/trading/order/:id';
  
  // Portfolio Endpoints
  static const String portfolio = '/portfolio';
  static const String holdings = '/portfolio/holdings';
  static const String positions = '/portfolio/positions';
  static const String profitLoss = '/portfolio/pnl';
  
  // Watchlist Endpoints
  static const String watchlist = '/watchlist';
  static const String addToWatchlist = '/watchlist/add';
  static const String removeFromWatchlist = '/watchlist/:id/remove';
  
  // Alert Endpoints
  static const String alerts = '/alerts';
  static const String createAlert = '/alerts/create';
  static const String deleteAlert = '/alerts/:id';
  
  // Payment Endpoints
  static const String paymentInitiate = '/payment/initiate';
  static const String paymentVerify = '/payment/verify';
  static const String paymentHistory = '/payment/history';
  static const String addMoney = '/payment/add-money';
  static const String withdraw = '/payment/withdraw';
  
  // User Endpoints
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile/update';
  static const String bankDetails = '/user/bank-details';
  static const String nominees = '/user/nominees';
  
  // News Endpoints
  static const String newsFeed = '/news';
  static const String newsFiltered = '/news/filtered';
  static const String newsSentiment = '/news/:id/sentiment';
  
  // AI Endpoints
  static const String aiAnalysis = '/ai/analysis/:symbol';
  static const String aiPrediction = '/ai/prediction/:symbol';
  static const String aiRecommendation = '/ai/recommendation/:symbol';
  
  // Algo Trading Endpoints
  static const String algoStrategies = '/algo/strategies';
  static const String algoBacktest = '/algo/backtest';
  static const String algoStart = '/algo/start';
  static const String algoStop = '/algo/stop';
  static const String algoStatus = '/algo/status';
  
  // WebSocket Topics
  static const String wsStockPrices = 'stock-prices';
  static const String wsMarketDepth = 'market-depth';
  static const String wsOrderUpdates = 'order-updates';
  static const String wsTrades = 'trades';
  
  // API Headers
  static Map<String, String> getHeaders({String? token}) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
  
  // Build URL with path parameters
  static String buildUrl(String endpoint, Map<String, String>? pathParams) {
    String url = baseUrl + endpoint;
    if (pathParams != null) {
      pathParams.forEach((key, value) {
        url = url.replaceAll(':$key', value);
      });
    }
    return url;
  }
}
