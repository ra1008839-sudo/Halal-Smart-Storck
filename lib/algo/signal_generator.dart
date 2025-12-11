import '../data/models/candle_model.dart';
import 'algo_engine.dart';

class SignalGenerator {
  // Generate buy/sell signals based on indicators
  TradeSignal? generate({
    required double rsi,
    required Map<String, double> macd,
    required double currentPrice,
    required List<CandleModel> candles,
  }) {
    // Buy Signal Conditions
    if (_shouldBuy(rsi, macd, candles)) {
      return _createBuySignal(currentPrice, candles);
    }

    // Sell Signal Conditions
    if (_shouldSell(rsi, macd, candles)) {
      return _createSellSignal(currentPrice, candles);
    }

    return null;
  }

  bool _shouldBuy(double rsi, Map<String, double> macd, List<CandleModel> candles) {
    // RSI oversold (< 30)
    final rsiOversold = rsi < 30;

    // MACD bullish crossover
    final macdBullish = (macd['macd'] ?? 0) > (macd['signal'] ?? 0);

    // Price above support level
    final recentLow = candles.sublist(candles.length - 20).map((c) => c.low).reduce((a, b) => a < b ? a : b);
    final aboveSupport = candles.last.close > recentLow * 1.01;

    // At least 2 conditions must be true
    final conditions = [rsiOversold, macdBullish, aboveSupport];
    return conditions.where((c) => c).length >= 2;
  }

  bool _shouldSell(double rsi, Map<String, double> macd, List<CandleModel> candles) {
    // RSI overbought (> 70)
    final rsiOverbought = rsi > 70;

    // MACD bearish crossover
    final macdBearish = (macd['macd'] ?? 0) < (macd['signal'] ?? 0);

    // Price below resistance level
    final recentHigh = candles.sublist(candles.length - 20).map((c) => c.high).reduce((a, b) => a > b ? a : b);
    final belowResistance = candles.last.close < recentHigh * 0.99;

    // At least 2 conditions must be true
    final conditions = [rsiOverbought, macdBearish, belowResistance];
    return conditions.where((c) => c).length >= 2;
  }

  TradeSignal _createBuySignal(double currentPrice, List<CandleModel> candles) {
    // Calculate stop loss (2% below current price)
    final stopLoss = currentPrice * 0.98;

    // Calculate target (4% above current price for 1:2 risk-reward)
    final target = currentPrice * 1.04;

    // Calculate quantity (will be adjusted by risk manager)
    const quantity = 1.0;

    return TradeSignal(
      type: 'BUY',
      price: currentPrice,
      quantity: quantity,
      stopLoss: stopLoss,
      target: target,
      reason: 'RSI + MACD + Support Level',
      timestamp: DateTime.now(),
    );
  }

  TradeSignal _createSellSignal(double currentPrice, List<CandleModel> candles) {
    // Calculate stop loss (2% above current price)
    final stopLoss = currentPrice * 1.02;

    // Calculate target (4% below current price for 1:2 risk-reward)
    final target = currentPrice * 0.96;

    // Calculate quantity
    const quantity = 1.0;

    return TradeSignal(
      type: 'SELL',
      price: currentPrice,
      quantity: quantity,
      stopLoss: stopLoss,
      target: target,
      reason: 'RSI + MACD + Resistance Level',
      timestamp: DateTime.now(),
    );
  }
}
