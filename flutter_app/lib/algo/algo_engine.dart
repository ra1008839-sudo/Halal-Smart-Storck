import '../data/models/stock.dart';
import '../data/models/order.dart';

/// Algo Trading Engine
/// Handles automated trading decisions, risk management, and trade execution
class AlgoEngine {
  bool _isRunning = false;
  final RiskManager _riskManager = RiskManager();
  final SignalGenerator _signalGenerator = SignalGenerator();
  final TradeExecutor _tradeExecutor = TradeExecutor();
  
  bool get isRunning => _isRunning;
  
  /// Start the algo trading bot
  Future<void> start() async {
    if (_isRunning) {
      throw Exception('Algo trading is already running');
    }
    _isRunning = true;
    print('🤖 Algo Trading Bot Started');
  }
  
  /// Stop the algo trading bot
  Future<void> stop() async {
    if (!_isRunning) {
      throw Exception('Algo trading is not running');
    }
    _isRunning = false;
    print('🛑 Algo Trading Bot Stopped');
  }
  
  /// Analyze stock and generate trading decision
  Future<TradingDecision> analyzeStock(Stock stock, Map<String, dynamic> indicators) async {
    if (!_isRunning) {
      throw Exception('Algo trading is not running');
    }
    
    // Get trading signal
    final signal = _signalGenerator.generateSignal(stock, indicators);
    
    // Check risk parameters
    final riskAssessment = _riskManager.assessRisk(stock, signal);
    
    if (!riskAssessment.isAcceptable) {
      return TradingDecision(
        action: TradingAction.HOLD,
        confidence: 0,
        reason: riskAssessment.reason,
        suggestedPrice: stock.currentPrice,
      );
    }
    
    // Calculate position size
    final positionSize = _riskManager.calculatePositionSize(
      stock.currentPrice,
      signal.stopLoss,
    );
    
    return TradingDecision(
      action: signal.action,
      confidence: signal.confidence,
      reason: signal.reason,
      suggestedPrice: stock.currentPrice,
      quantity: positionSize,
      stopLoss: signal.stopLoss,
      target: signal.target,
      trailingStopLoss: signal.trailingStopLoss,
    );
  }
  
  /// Execute trade based on decision
  Future<OrderModel?> executeTrade(TradingDecision decision, Stock stock, String userId) async {
    if (!_isRunning) {
      throw Exception('Algo trading is not running');
    }
    
    if (decision.action == TradingAction.HOLD) {
      return null;
    }
    
    return await _tradeExecutor.executeOrder(
      stock: stock,
      userId: userId,
      action: decision.action,
      quantity: decision.quantity ?? 1,
      stopLoss: decision.stopLoss,
      trailingStopLoss: decision.trailingStopLoss,
    );
  }
  
  /// Monitor open positions and adjust stop losses
  Future<void> monitorPositions(List<Position> positions) async {
    if (!_isRunning) return;
    
    for (final position in positions) {
      // Check if trailing stop loss needs adjustment
      final newStopLoss = _riskManager.calculateTrailingStopLoss(
        entryPrice: position.averagePrice,
        currentPrice: position.currentPrice,
        trailingPercent: position.trailingStopLoss ?? 2.0,
        currentStopLoss: position.stopLoss,
      );
      
      if (newStopLoss != null && newStopLoss != position.stopLoss) {
        print('📊 Adjusting Stop Loss for ${position.symbol}: ${position.stopLoss} → $newStopLoss');
        // Update stop loss in database
      }
      
      // Check if stop loss hit
      if (position.currentPrice <= position.stopLoss) {
        print('🛑 Stop Loss Hit for ${position.symbol}');
        // Execute sell order
        await _tradeExecutor.executeStopLoss(position);
      }
      
      // Check if target hit
      if (position.target != null && position.currentPrice >= position.target!) {
        print('🎯 Target Hit for ${position.symbol}');
        // Execute profit booking
        await _tradeExecutor.executeTargetSell(position);
      }
    }
  }
}

/// Trading Decision Model
class TradingDecision {
  final TradingAction action;
  final double confidence; // 0-100%
  final String reason;
  final double suggestedPrice;
  final int? quantity;
  final double? stopLoss;
  final double? target;
  final double? trailingStopLoss;
  
  TradingDecision({
    required this.action,
    required this.confidence,
    required this.reason,
    required this.suggestedPrice,
    this.quantity,
    this.stopLoss,
    this.target,
    this.trailingStopLoss,
  });
}

enum TradingAction {
  BUY,
  SELL,
  HOLD,
}

/// Position Model for monitoring
class Position {
  final String id;
  final String symbol;
  final int quantity;
  final double averagePrice;
  final double currentPrice;
  final double stopLoss;
  final double? target;
  final double? trailingStopLoss;
  
  Position({
    required this.id,
    required this.symbol,
    required this.quantity,
    required this.averagePrice,
    required this.currentPrice,
    required this.stopLoss,
    this.target,
    this.trailingStopLoss,
  });
}

/// Risk Manager (placeholder for actual implementation)
class RiskManager {
  RiskAssessment assessRisk(Stock stock, TradingSignal signal) {
    // Implementation in risk_manager.dart
    return RiskAssessment(isAcceptable: true, reason: 'Risk acceptable');
  }
  
  int calculatePositionSize(double price, double? stopLoss) {
    // Implementation in risk_manager.dart
    return 10;
  }
  
  double? calculateTrailingStopLoss({
    required double entryPrice,
    required double currentPrice,
    required double trailingPercent,
    required double currentStopLoss,
  }) {
    // Implementation in trailing_stop_loss.dart
    return null;
  }
}

/// Signal Generator (placeholder for actual implementation)
class SignalGenerator {
  TradingSignal generateSignal(Stock stock, Map<String, dynamic> indicators) {
    // Implementation in signal_generator.dart
    return TradingSignal(
      action: TradingAction.HOLD,
      confidence: 50,
      reason: 'Neutral market',
      stopLoss: stock.currentPrice * 0.98,
      target: stock.currentPrice * 1.05,
    );
  }
}

/// Trade Executor (placeholder for actual implementation)
class TradeExecutor {
  Future<OrderModel?> executeOrder({
    required Stock stock,
    required String userId,
    required TradingAction action,
    required int quantity,
    double? stopLoss,
    double? trailingStopLoss,
  }) async {
    // Implementation in trade_executor.dart
    return null;
  }
  
  Future<void> executeStopLoss(Position position) async {
    // Implementation in trade_executor.dart
  }
  
  Future<void> executeTargetSell(Position position) async {
    // Implementation in trade_executor.dart
  }
}

class RiskAssessment {
  final bool isAcceptable;
  final String reason;
  
  RiskAssessment({required this.isAcceptable, required this.reason});
}

class TradingSignal {
  final TradingAction action;
  final double confidence;
  final String reason;
  final double? stopLoss;
  final double? target;
  final double? trailingStopLoss;
  
  TradingSignal({
    required this.action,
    required this.confidence,
    required this.reason,
    this.stopLoss,
    this.target,
    this.trailingStopLoss,
  });
}
