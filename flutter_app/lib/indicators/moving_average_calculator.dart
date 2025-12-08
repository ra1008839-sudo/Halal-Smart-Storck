/// Moving Average Calculator
/// Provides different types of moving averages for technical analysis

class MovingAverageCalculator {
  /// Calculate Simple Moving Average (SMA)
  static double calculateSMA(List<double> prices, int period) {
    if (prices.length < period) {
      throw ArgumentError('Not enough data points for SMA');
    }
    
    double sum = 0;
    for (int i = prices.length - period; i < prices.length; i++) {
      sum += prices[i];
    }
    
    return sum / period;
  }
  
  /// Calculate Exponential Moving Average (EMA)
  static double calculateEMA(List<double> prices, int period) {
    if (prices.length < period) {
      throw ArgumentError('Not enough data points for EMA');
    }
    
    // Calculate initial SMA
    double sum = 0;
    for (int i = 0; i < period; i++) {
      sum += prices[i];
    }
    double ema = sum / period;
    
    // Calculate multiplier
    double multiplier = 2 / (period + 1);
    
    // Calculate EMA for remaining prices
    for (int i = period; i < prices.length; i++) {
      ema = (prices[i] - ema) * multiplier + ema;
    }
    
    return ema;
  }
  
  /// Calculate Weighted Moving Average (WMA)
  static double calculateWMA(List<double> prices, int period) {
    if (prices.length < period) {
      throw ArgumentError('Not enough data points for WMA');
    }
    
    double weightedSum = 0;
    double weightSum = 0;
    
    for (int i = 0; i < period; i++) {
      int weight = i + 1;
      weightedSum += prices[prices.length - period + i] * weight;
      weightSum += weight;
    }
    
    return weightedSum / weightSum;
  }
  
  /// Get all common moving averages
  static Map<String, double> getAllMovingAverages(List<double> prices) {
    return {
      'SMA_20': calculateSMA(prices, 20),
      'SMA_50': calculateSMA(prices, 50),
      'SMA_100': prices.length >= 100 ? calculateSMA(prices, 100) : 0,
      'SMA_200': prices.length >= 200 ? calculateSMA(prices, 200) : 0,
      'EMA_12': calculateEMA(prices, 12),
      'EMA_26': calculateEMA(prices, 26),
      'EMA_50': calculateEMA(prices, 50),
      'WMA_20': calculateWMA(prices, 20),
    };
  }
  
  /// Check if golden cross occurred (50-day SMA crosses above 200-day SMA)
  static bool isGoldenCross(List<double> prices) {
    if (prices.length < 201) return false;
    
    final currentSMA50 = calculateSMA(prices, 50);
    final currentSMA200 = calculateSMA(prices, 200);
    
    // Get previous values
    final prevPrices = prices.sublist(0, prices.length - 1);
    final prevSMA50 = calculateSMA(prevPrices, 50);
    final prevSMA200 = calculateSMA(prevPrices, 200);
    
    return prevSMA50 < prevSMA200 && currentSMA50 > currentSMA200;
  }
  
  /// Check if death cross occurred (50-day SMA crosses below 200-day SMA)
  static bool isDeathCross(List<double> prices) {
    if (prices.length < 201) return false;
    
    final currentSMA50 = calculateSMA(prices, 50);
    final currentSMA200 = calculateSMA(prices, 200);
    
    // Get previous values
    final prevPrices = prices.sublist(0, prices.length - 1);
    final prevSMA50 = calculateSMA(prevPrices, 50);
    final prevSMA200 = calculateSMA(prevPrices, 200);
    
    return prevSMA50 > prevSMA200 && currentSMA50 < currentSMA200;
  }
}
