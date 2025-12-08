import 'dart:math';

/// Bollinger Bands Calculator
/// Bollinger Bands consist of a middle band (SMA) and two outer bands (standard deviations away)

class BollingerCalculator {
  /// Calculate Bollinger Bands
  /// prices: List of closing prices
  /// period: typically 20
  /// stdDev: typically 2 (number of standard deviations)
  static BollingerBands calculate(
    List<double> prices, {
    int period = 20,
    double stdDev = 2.0,
  }) {
    if (prices.length < period) {
      throw ArgumentError('Not enough data points. Need at least $period prices');
    }

    // Calculate Simple Moving Average (Middle Band)
    double sum = 0;
    for (int i = prices.length - period; i < prices.length; i++) {
      sum += prices[i];
    }
    final middleBand = sum / period;

    // Calculate Standard Deviation
    double varianceSum = 0;
    for (int i = prices.length - period; i < prices.length; i++) {
      varianceSum += pow(prices[i] - middleBand, 2);
    }
    final standardDeviation = sqrt(varianceSum / period);

    // Calculate Upper and Lower Bands
    final upperBand = middleBand + (stdDev * standardDeviation);
    final lowerBand = middleBand - (stdDev * standardDeviation);

    // Calculate Bandwidth
    final bandwidth = ((upperBand - lowerBand) / middleBand) * 100;

    // Calculate %B (Position within bands)
    final currentPrice = prices.last;
    final percentB = (currentPrice - lowerBand) / (upperBand - lowerBand);

    return BollingerBands(
      upperBand: upperBand,
      middleBand: middleBand,
      lowerBand: lowerBand,
      bandwidth: bandwidth,
      percentB: percentB,
    );
  }

  /// Get signal based on price position
  static BollingerSignal getSignal(double currentPrice, BollingerBands bands) {
    if (currentPrice >= bands.upperBand) {
      return BollingerSignal.OVERBOUGHT;
    } else if (currentPrice <= bands.lowerBand) {
      return BollingerSignal.OVERSOLD;
    } else if (currentPrice > bands.middleBand) {
      return BollingerSignal.ABOVE_MIDDLE;
    } else if (currentPrice < bands.middleBand) {
      return BollingerSignal.BELOW_MIDDLE;
    } else {
      return BollingerSignal.AT_MIDDLE;
    }
  }

  /// Check for squeeze (low volatility)
  static bool isSqueeze(BollingerBands bands) {
    return bands.bandwidth < 10; // Arbitrary threshold
  }

  /// Check for expansion (high volatility)
  static bool isExpansion(BollingerBands bands) {
    return bands.bandwidth > 30; // Arbitrary threshold
  }

  /// Get interpretation
  static String getInterpretation(double currentPrice, BollingerBands bands) {
    final signal = getSignal(currentPrice, bands);
    
    switch (signal) {
      case BollingerSignal.OVERBOUGHT:
        return 'Price at upper band - Overbought, consider selling';
      case BollingerSignal.OVERSOLD:
        return 'Price at lower band - Oversold, consider buying';
      case BollingerSignal.ABOVE_MIDDLE:
        return 'Price above middle band - Bullish bias';
      case BollingerSignal.BELOW_MIDDLE:
        return 'Price below middle band - Bearish bias';
      case BollingerSignal.AT_MIDDLE:
        return 'Price at middle band - Neutral';
    }
  }

  /// Detect Bollinger Bounce
  static bool isBollingerBounce(List<double> recentPrices, BollingerBands bands) {
    if (recentPrices.length < 2) return false;
    
    final prevPrice = recentPrices[recentPrices.length - 2];
    final currPrice = recentPrices.last;
    
    // Bounce off lower band
    if (prevPrice <= bands.lowerBand && currPrice > bands.lowerBand) {
      return true;
    }
    
    // Bounce off upper band
    if (prevPrice >= bands.upperBand && currPrice < bands.upperBand) {
      return true;
    }
    
    return false;
  }
}

/// Bollinger Bands Result
class BollingerBands {
  final double upperBand;
  final double middleBand;
  final double lowerBand;
  final double bandwidth;
  final double percentB;

  BollingerBands({
    required this.upperBand,
    required this.middleBand,
    required this.lowerBand,
    required this.bandwidth,
    required this.percentB,
  });
}

enum BollingerSignal {
  OVERBOUGHT,
  OVERSOLD,
  ABOVE_MIDDLE,
  BELOW_MIDDLE,
  AT_MIDDLE,
}
