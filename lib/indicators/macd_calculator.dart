import 'moving_average_calculator.dart';

class MACDCalculator {
  // Calculate MACD (Moving Average Convergence Divergence)
  static Map<String, double> calculate(
    List<double> prices, {
    int fastPeriod = 12,
    int slowPeriod = 26,
    int signalPeriod = 9,
  }) {
    if (prices.length < slowPeriod) {
      return {'macd': 0.0, 'signal': 0.0, 'histogram': 0.0};
    }

    // Calculate EMAs
    final fastEMA = MovingAverageCalculator.calculateEMA(prices, period: fastPeriod);
    final slowEMA = MovingAverageCalculator.calculateEMA(prices, period: slowPeriod);

    // Calculate MACD line
    final macdLine = fastEMA - slowEMA;

    // Calculate Signal line (EMA of MACD)
    // For simplicity, we'll use a simple average here
    // In production, you'd calculate EMA of MACD values
    final signalLine = macdLine * 0.9; // Simplified

    // Calculate Histogram
    final histogram = macdLine - signalLine;

    return {
      'macd': macdLine,
      'signal': signalLine,
      'histogram': histogram,
    };
  }

  // Calculate MACD series for plotting
  static List<Map<String, double>> calculateSeries(
    List<double> prices, {
    int fastPeriod = 12,
    int slowPeriod = 26,
    int signalPeriod = 9,
  }) {
    final macdValues = <Map<String, double>>[];

    for (int i = slowPeriod; i <= prices.length; i++) {
      final subset = prices.sublist(0, i);
      macdValues.add(calculate(
        subset,
        fastPeriod: fastPeriod,
        slowPeriod: slowPeriod,
        signalPeriod: signalPeriod,
      ));
    }

    return macdValues;
  }

  // Check if MACD indicates bullish crossover
  static bool isBullishCrossover(Map<String, double> current, Map<String, double> previous) {
    final currentMacd = current['macd'] ?? 0;
    final currentSignal = current['signal'] ?? 0;
    final previousMacd = previous['macd'] ?? 0;
    final previousSignal = previous['signal'] ?? 0;

    return previousMacd <= previousSignal && currentMacd > currentSignal;
  }

  // Check if MACD indicates bearish crossover
  static bool isBearishCrossover(Map<String, double> current, Map<String, double> previous) {
    final currentMacd = current['macd'] ?? 0;
    final currentSignal = current['signal'] ?? 0;
    final previousMacd = previous['macd'] ?? 0;
    final previousSignal = previous['signal'] ?? 0;

    return previousMacd >= previousSignal && currentMacd < currentSignal;
  }

  // Get MACD interpretation
  static String getInterpretation(Map<String, double> macd) {
    final macdValue = macd['macd'] ?? 0;
    final signalValue = macd['signal'] ?? 0;
    final histogram = macd['histogram'] ?? 0;

    if (macdValue > signalValue && histogram > 0) return 'Strong Bullish';
    if (macdValue > signalValue) return 'Bullish';
    if (macdValue < signalValue && histogram < 0) return 'Strong Bearish';
    if (macdValue < signalValue) return 'Bearish';
    return 'Neutral';
  }
}
