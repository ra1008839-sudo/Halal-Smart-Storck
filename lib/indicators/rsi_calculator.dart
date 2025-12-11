class RSICalculator {
  // Calculate RSI (Relative Strength Index)
  static double calculate(List<double> prices, {int period = 14}) {
    if (prices.length < period + 1) {
      return 50.0; // Neutral RSI if not enough data
    }

    // Calculate price changes
    final changes = <double>[];
    for (int i = 1; i < prices.length; i++) {
      changes.add(prices[i] - prices[i - 1]);
    }

    // Calculate initial average gain and loss
    double avgGain = 0;
    double avgLoss = 0;

    for (int i = 0; i < period; i++) {
      if (changes[i] > 0) {
        avgGain += changes[i];
      } else {
        avgLoss += changes[i].abs();
      }
    }

    avgGain /= period;
    avgLoss /= period;

    // Calculate RSI using smoothed averages
    for (int i = period; i < changes.length; i++) {
      final change = changes[i];
      if (change > 0) {
        avgGain = ((avgGain * (period - 1)) + change) / period;
        avgLoss = (avgLoss * (period - 1)) / period;
      } else {
        avgGain = (avgGain * (period - 1)) / period;
        avgLoss = ((avgLoss * (period - 1)) + change.abs()) / period;
      }
    }

    if (avgLoss == 0) return 100.0;

    final rs = avgGain / avgLoss;
    final rsi = 100 - (100 / (1 + rs));

    return rsi;
  }

  // Calculate RSI for multiple periods
  static List<double> calculateSeries(List<double> prices, {int period = 14}) {
    final rsiValues = <double>[];

    for (int i = period; i <= prices.length; i++) {
      final subset = prices.sublist(0, i);
      rsiValues.add(calculate(subset, period: period));
    }

    return rsiValues;
  }

  // Check if RSI indicates overbought
  static bool isOverbought(double rsi, {double threshold = 70.0}) {
    return rsi > threshold;
  }

  // Check if RSI indicates oversold
  static bool isOversold(double rsi, {double threshold = 30.0}) {
    return rsi < threshold;
  }

  // Get RSI interpretation
  static String getInterpretation(double rsi) {
    if (rsi > 70) return 'Overbought';
    if (rsi < 30) return 'Oversold';
    if (rsi > 50) return 'Bullish';
    if (rsi < 50) return 'Bearish';
    return 'Neutral';
  }
}
