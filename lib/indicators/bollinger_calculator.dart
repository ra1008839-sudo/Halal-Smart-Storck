import 'dart:math';
import 'moving_average_calculator.dart';

class BollingerCalculator {
  // Calculate Bollinger Bands
  static Map<String, double> calculate(
    List<double> prices, {
    int period = 20,
    double standardDeviations = 2.0,
  }) {
    if (prices.length < period) {
      final price = prices.isNotEmpty ? prices.last : 0.0;
      return {
        'upper': price,
        'middle': price,
        'lower': price,
      };
    }

    // Calculate middle band (SMA)
    final middle = MovingAverageCalculator.calculateSMA(prices, period: period);

    // Calculate standard deviation
    final recentPrices = prices.sublist(prices.length - period);
    final variance = recentPrices.fold<double>(0.0, (sum, price) {
      return sum + pow(price - middle, 2);
    }) / period;
    final stdDev = sqrt(variance);

    // Calculate upper and lower bands
    final upper = middle + (standardDeviations * stdDev);
    final lower = middle - (standardDeviations * stdDev);

    return {
      'upper': upper,
      'middle': middle,
      'lower': lower,
      'bandwidth': upper - lower,
    };
  }

  // Calculate Bollinger Bands series
  static List<Map<String, double>> calculateSeries(
    List<double> prices, {
    int period = 20,
    double standardDeviations = 2.0,
  }) {
    final bands = <Map<String, double>>[];

    for (int i = period; i <= prices.length; i++) {
      final subset = prices.sublist(0, i);
      bands.add(calculate(
        subset,
        period: period,
        standardDeviations: standardDeviations,
      ));
    }

    return bands;
  }

  // Check if price is near upper band
  static bool isNearUpperBand(double price, Map<String, double> bands, {double threshold = 0.95}) {
    final upper = bands['upper'] ?? 0;
    final middle = bands['middle'] ?? 0;
    final range = upper - middle;
    return price >= middle + (range * threshold);
  }

  // Check if price is near lower band
  static bool isNearLowerBand(double price, Map<String, double> bands, {double threshold = 0.95}) {
    final lower = bands['lower'] ?? 0;
    final middle = bands['middle'] ?? 0;
    final range = middle - lower;
    return price <= middle - (range * threshold);
  }

  // Calculate %B (Bollinger %B indicator)
  static double calculatePercentB(double price, Map<String, double> bands) {
    final upper = bands['upper'] ?? 0;
    final lower = bands['lower'] ?? 0;
    final bandwidth = upper - lower;

    if (bandwidth == 0) return 0.5;

    return (price - lower) / bandwidth;
  }

  // Get Bollinger Bands interpretation
  static String getInterpretation(double price, Map<String, double> bands) {
    final upper = bands['upper'] ?? 0;
    final middle = bands['middle'] ?? 0;
    final lower = bands['lower'] ?? 0;

    if (price > upper) return 'Overbought - Above Upper Band';
    if (price < lower) return 'Oversold - Below Lower Band';
    if (price > middle) return 'Above Middle - Bullish';
    if (price < middle) return 'Below Middle - Bearish';
    return 'Neutral';
  }
}
