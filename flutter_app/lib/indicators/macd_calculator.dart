/// MACD (Moving Average Convergence Divergence) Calculator
/// MACD is a trend-following momentum indicator

class MACDCalculator {
  /// Calculate MACD components
  /// prices: List of closing prices
  /// fastPeriod: typically 12
  /// slowPeriod: typically 26
  /// signalPeriod: typically 9
  static MACDResult calculate(
    List<double> prices, {
    int fastPeriod = 12,
    int slowPeriod = 26,
    int signalPeriod = 9,
  }) {
    if (prices.length < slowPeriod + signalPeriod) {
      throw ArgumentError('Not enough data points');
    }

    // Calculate EMAs
    final fastEMA = _calculateEMA(prices, fastPeriod);
    final slowEMA = _calculateEMA(prices, slowPeriod);

    // Calculate MACD line
    final macdLine = fastEMA - slowEMA;

    // Calculate Signal line (EMA of MACD line)
    List<double> macdValues = [macdLine];
    final signalLine = _calculateEMA(macdValues, signalPeriod);

    // Calculate Histogram
    final histogram = macdLine - signalLine;

    return MACDResult(
      macdLine: macdLine,
      signalLine: signalLine,
      histogram: histogram,
    );
  }

  /// Calculate Exponential Moving Average (EMA)
  static double _calculateEMA(List<double> prices, int period) {
    if (prices.length < period) {
      throw ArgumentError('Not enough data for EMA calculation');
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

  /// Get MACD signal
  static MACDSignal getSignal(MACDResult macd) {
    if (macd.histogram > 0 && macd.macdLine > macd.signalLine) {
      return MACDSignal.BULLISH;
    } else if (macd.histogram < 0 && macd.macdLine < macd.signalLine) {
      return MACDSignal.BEARISH;
    } else {
      return MACDSignal.NEUTRAL;
    }
  }

  /// Check for crossover
  static bool isBullishCrossover(MACDResult current, MACDResult previous) {
    return previous.macdLine < previous.signalLine &&
        current.macdLine > current.signalLine;
  }

  static bool isBearishCrossover(MACDResult current, MACDResult previous) {
    return previous.macdLine > previous.signalLine &&
        current.macdLine < current.signalLine;
  }

  /// Get interpretation
  static String getInterpretation(MACDResult macd) {
    if (macd.histogram > 0) {
      if (macd.histogram > 5) {
        return 'Strong bullish momentum';
      }
      return 'Bullish momentum';
    } else if (macd.histogram < 0) {
      if (macd.histogram < -5) {
        return 'Strong bearish momentum';
      }
      return 'Bearish momentum';
    } else {
      return 'Neutral momentum';
    }
  }
}

/// MACD Result
class MACDResult {
  final double macdLine;
  final double signalLine;
  final double histogram;

  MACDResult({
    required this.macdLine,
    required this.signalLine,
    required this.histogram,
  });
}

enum MACDSignal {
  BULLISH,
  BEARISH,
  NEUTRAL,
}
