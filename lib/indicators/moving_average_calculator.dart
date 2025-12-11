class MovingAverageCalculator {
  // Calculate Simple Moving Average (SMA)
  static double calculateSMA(List<double> prices, {int period = 20}) {
    if (prices.isEmpty) return 0.0;
    if (prices.length < period) period = prices.length;

    final recentPrices = prices.sublist(prices.length - period);
    final sum = recentPrices.reduce((a, b) => a + b);
    return sum / period;
  }

  // Calculate Exponential Moving Average (EMA)
  static double calculateEMA(List<double> prices, {int period = 20}) {
    if (prices.isEmpty) return 0.0;
    if (prices.length < period) return calculateSMA(prices);

    // Calculate multiplier
    final multiplier = 2.0 / (period + 1);

    // Start with SMA for initial EMA
    final initialPrices = prices.sublist(0, period);
    double ema = calculateSMA(initialPrices, period: period);

    // Calculate EMA for remaining prices
    for (int i = period; i < prices.length; i++) {
      ema = (prices[i] - ema) * multiplier + ema;
    }

    return ema;
  }

  // Calculate Weighted Moving Average (WMA)
  static double calculateWMA(List<double> prices, {int period = 20}) {
    if (prices.isEmpty) return 0.0;
    if (prices.length < period) period = prices.length;

    final recentPrices = prices.sublist(prices.length - period);
    double weightedSum = 0.0;
    double weightSum = 0.0;

    for (int i = 0; i < period; i++) {
      final weight = (i + 1).toDouble();
      weightedSum += recentPrices[i] * weight;
      weightSum += weight;
    }

    return weightedSum / weightSum;
  }

  // Calculate SMA series
  static List<double> calculateSMASeries(List<double> prices, {int period = 20}) {
    final smaValues = <double>[];

    for (int i = period; i <= prices.length; i++) {
      final subset = prices.sublist(0, i);
      smaValues.add(calculateSMA(subset, period: period));
    }

    return smaValues;
  }

  // Calculate EMA series
  static List<double> calculateEMASeries(List<double> prices, {int period = 20}) {
    final emaValues = <double>[];

    for (int i = period; i <= prices.length; i++) {
      final subset = prices.sublist(0, i);
      emaValues.add(calculateEMA(subset, period: period));
    }

    return emaValues;
  }

  // Check for Golden Cross (bullish signal)
  static bool hasGoldenCross(
    List<double> prices, {
    int shortPeriod = 50,
    int longPeriod = 200,
  }) {
    if (prices.length < longPeriod + 1) return false;

    final currentShortMA = calculateSMA(prices, period: shortPeriod);
    final currentLongMA = calculateSMA(prices, period: longPeriod);

    final previousPrices = prices.sublist(0, prices.length - 1);
    final previousShortMA = calculateSMA(previousPrices, period: shortPeriod);
    final previousLongMA = calculateSMA(previousPrices, period: longPeriod);

    return previousShortMA <= previousLongMA && currentShortMA > currentLongMA;
  }

  // Check for Death Cross (bearish signal)
  static bool hasDeathCross(
    List<double> prices, {
    int shortPeriod = 50,
    int longPeriod = 200,
  }) {
    if (prices.length < longPeriod + 1) return false;

    final currentShortMA = calculateSMA(prices, period: shortPeriod);
    final currentLongMA = calculateSMA(prices, period: longPeriod);

    final previousPrices = prices.sublist(0, prices.length - 1);
    final previousShortMA = calculateSMA(previousPrices, period: shortPeriod);
    final previousLongMA = calculateSMA(previousPrices, period: longPeriod);

    return previousShortMA >= previousLongMA && currentShortMA < currentLongMA;
  }
}
