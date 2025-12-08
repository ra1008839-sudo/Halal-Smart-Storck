/// RSI (Relative Strength Index) Calculator
/// RSI is a momentum indicator that measures the magnitude of recent price changes
/// to evaluate overbought or oversold conditions

class RSICalculator {
  /// Calculate RSI for given price data
  /// period: typically 14 (default)
  /// prices: List of closing prices (most recent last)
  /// Returns: RSI value between 0-100
  static double calculate(List<double> prices, {int period = 14}) {
    if (prices.length < period + 1) {
      throw ArgumentError('Not enough data points. Need at least ${period + 1} prices');
    }

    // Calculate price changes
    List<double> gains = [];
    List<double> losses = [];

    for (int i = 1; i < prices.length; i++) {
      double change = prices[i] - prices[i - 1];
      if (change > 0) {
        gains.add(change);
        losses.add(0);
      } else {
        gains.add(0);
        losses.add(change.abs());
      }
    }

    // Calculate initial average gain and loss
    double avgGain = gains.take(period).reduce((a, b) => a + b) / period;
    double avgLoss = losses.take(period).reduce((a, b) => a + b) / period;

    // Calculate subsequent averages using smoothing
    for (int i = period; i < gains.length; i++) {
      avgGain = (avgGain * (period - 1) + gains[i]) / period;
      avgLoss = (avgLoss * (period - 1) + losses[i]) / period;
    }

    // Calculate RS and RSI
    if (avgLoss == 0) {
      return 100.0; // Prevent division by zero
    }

    double rs = avgGain / avgLoss;
    double rsi = 100 - (100 / (1 + rs));

    return rsi;
  }

  /// Check if RSI indicates overbought condition (>70)
  static bool isOverbought(double rsi) {
    return rsi > 70;
  }

  /// Check if RSI indicates oversold condition (<30)
  static bool isOversold(double rsi) {
    return rsi < 30;
  }

  /// Get RSI signal
  static RSISignal getSignal(double rsi) {
    if (rsi > 70) {
      return RSISignal.OVERBOUGHT;
    } else if (rsi < 30) {
      return RSISignal.OVERSOLD;
    } else {
      return RSISignal.NEUTRAL;
    }
  }

  /// Get RSI interpretation
  static String getInterpretation(double rsi) {
    if (rsi > 70) {
      return 'Overbought - Consider selling';
    } else if (rsi >= 60) {
      return 'Strong uptrend';
    } else if (rsi >= 50) {
      return 'Moderate uptrend';
    } else if (rsi >= 40) {
      return 'Moderate downtrend';
    } else if (rsi >= 30) {
      return 'Strong downtrend';
    } else {
      return 'Oversold - Consider buying';
    }
  }
}

enum RSISignal {
  OVERBOUGHT,
  OVERSOLD,
  NEUTRAL,
}
