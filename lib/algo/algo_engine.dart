import '../data/models/candle_model.dart';
import '../indicators/rsi_calculator.dart';
import '../indicators/macd_calculator.dart';
import 'risk_manager.dart';
import 'signal_generator.dart';

class AlgoEngine {
  final RiskManager riskManager;
  final SignalGenerator signalGenerator;

  AlgoEngine({
    required this.riskManager,
    required this.signalGenerator,
  });

  factory AlgoEngine.standard() {
    return AlgoEngine(
      riskManager: RiskManager(),
      signalGenerator: SignalGenerator(),
    );
  }

  // Analyze market data and generate signals
  Future<TradeSignal?> analyze({
    required List<CandleModel> candles,
    required double currentPrice,
    required double portfolioValue,
  }) async {
    if (candles.length < 100) {
      return null; // Need minimum data
    }

    // Calculate indicators
    final rsi = RSICalculator.calculate(
      candles.map((c) => c.close).toList(),
      period: 14,
    );

    final macd = MACDCalculator.calculate(
      candles.map((c) => c.close).toList(),
    );

    // Generate signal
    final signal = signalGenerator.generate(
      rsi: rsi,
      macd: macd,
      currentPrice: currentPrice,
      candles: candles,
    );

    if (signal != null) {
      // Apply risk management
      final adjustedSignal = riskManager.validateSignal(
        signal: signal,
        portfolioValue: portfolioValue,
        currentPrice: currentPrice,
      );

      return adjustedSignal;
    }

    return null;
  }

  // Execute trade (simulation)
  Future<bool> executeTrade(TradeSignal signal) async {
    // In a real implementation, this would connect to broker API
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }
}

class TradeSignal {
  final String type; // 'BUY' or 'SELL'
  final double price;
  final double quantity;
  final double stopLoss;
  final double target;
  final String reason;
  final DateTime timestamp;

  TradeSignal({
    required this.type,
    required this.price,
    required this.quantity,
    required this.stopLoss,
    required this.target,
    required this.reason,
    required this.timestamp,
  });
}
