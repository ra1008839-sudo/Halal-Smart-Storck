import '../config/app_config.dart';

/// Risk Manager for Algo Trading
/// Implements the Max 2% Loss Rule and Position Sizing
class RiskManager {
  // Maximum risk per trade (2% of account)
  final double maxRiskPercentage = AppConfig.maxLossPercentage;
  
  // Maximum number of open positions
  final int maxPositions = AppConfig.maxPositions;
  
  // Daily loss limit (percentage of account)
  final double dailyLossLimit = 5.0;
  
  // Current account balance (should be fetched from user account)
  double accountBalance = 100000.0; // Default: ₹1,00,000
  
  /// Assess risk for a potential trade
  RiskAssessment assessRisk(dynamic stock, dynamic signal) {
    // Check if max positions reached
    final currentPositions = _getCurrentPositionsCount();
    if (currentPositions >= maxPositions) {
      return RiskAssessment(
        isAcceptable: false,
        reason: 'Maximum positions ($maxPositions) reached',
        riskLevel: RiskLevel.HIGH,
      );
    }
    
    // Check daily loss limit
    final todayLoss = _getTodayLoss();
    final dailyLossPercentage = (todayLoss / accountBalance) * 100;
    if (dailyLossPercentage >= dailyLossLimit) {
      return RiskAssessment(
        isAcceptable: false,
        reason: 'Daily loss limit ($dailyLossLimit%) reached',
        riskLevel: RiskLevel.HIGH,
      );
    }
    
    // Calculate potential loss
    final stopLossPrice = signal.stopLoss ?? (stock.currentPrice * 0.98);
    final potentialLoss = stock.currentPrice - stopLossPrice;
    final potentialLossPercent = (potentialLoss / stock.currentPrice) * 100;
    
    // Check if stop loss is too tight or too wide
    if (potentialLossPercent < 0.5) {
      return RiskAssessment(
        isAcceptable: false,
        reason: 'Stop loss too tight (<0.5%)',
        riskLevel: RiskLevel.HIGH,
      );
    }
    
    if (potentialLossPercent > 5.0) {
      return RiskAssessment(
        isAcceptable: false,
        reason: 'Stop loss too wide (>5%)',
        riskLevel: RiskLevel.HIGH,
      );
    }
    
    // Assess market conditions
    final volatility = _calculateVolatility(stock);
    RiskLevel riskLevel;
    if (volatility > 3.0) {
      riskLevel = RiskLevel.HIGH;
    } else if (volatility > 1.5) {
      riskLevel = RiskLevel.MEDIUM;
    } else {
      riskLevel = RiskLevel.LOW;
    }
    
    return RiskAssessment(
      isAcceptable: true,
      reason: 'Risk acceptable',
      riskLevel: riskLevel,
      potentialLossPercent: potentialLossPercent,
    );
  }
  
  /// Calculate position size based on 2% risk rule
  /// Formula: Position Size = (Account Balance × Risk%) / (Entry Price - Stop Loss Price)
  int calculatePositionSize(double entryPrice, double? stopLossPrice) {
    if (stopLossPrice == null) {
      // Default stop loss at 2% below entry
      stopLossPrice = entryPrice * 0.98;
    }
    
    // Maximum amount to risk per trade
    final maxRiskAmount = accountBalance * (maxRiskPercentage / 100);
    
    // Risk per share
    final riskPerShare = entryPrice - stopLossPrice;
    
    if (riskPerShare <= 0) {
      return 1; // Minimum 1 share
    }
    
    // Calculate position size
    final positionSize = (maxRiskAmount / riskPerShare).floor();
    
    // Ensure minimum of 1 share
    return positionSize > 0 ? positionSize : 1;
  }
  
  /// Calculate trailing stop loss
  double? calculateTrailingStopLoss({
    required double entryPrice,
    required double currentPrice,
    required double trailingPercent,
    required double currentStopLoss,
  }) {
    // Only trail stop loss if price moved up
    if (currentPrice <= entryPrice) {
      return null; // Don't adjust
    }
    
    // Calculate new stop loss based on current price
    final newStopLoss = currentPrice * (1 - trailingPercent / 100);
    
    // Only move stop loss up, never down
    if (newStopLoss > currentStopLoss) {
      return newStopLoss;
    }
    
    return null; // Don't adjust
  }
  
  /// Calculate Risk-Reward Ratio
  double calculateRiskRewardRatio({
    required double entryPrice,
    required double stopLoss,
    required double target,
  }) {
    final risk = entryPrice - stopLoss;
    final reward = target - entryPrice;
    
    if (risk <= 0) return 0;
    
    return reward / risk;
  }
  
  /// Check if Risk-Reward ratio is favorable
  bool isRiskRewardFavorable({
    required double entryPrice,
    required double stopLoss,
    required double target,
    double minRatio = 2.0,
  }) {
    final ratio = calculateRiskRewardRatio(
      entryPrice: entryPrice,
      stopLoss: stopLoss,
      target: target,
    );
    return ratio >= minRatio;
  }
  
  /// Get current positions count (placeholder - should fetch from database)
  int _getCurrentPositionsCount() {
    // TODO: Implement actual position count from database
    return 0;
  }
  
  /// Get today's loss (placeholder - should fetch from database)
  double _getTodayLoss() {
    // TODO: Implement actual today's loss calculation
    return 0.0;
  }
  
  /// Calculate volatility (placeholder - should use actual data)
  double _calculateVolatility(dynamic stock) {
    // Simple volatility based on price range
    final range = stock.highPrice - stock.lowPrice;
    final volatilityPercent = (range / stock.currentPrice) * 100;
    return volatilityPercent;
  }
  
  /// Update account balance
  void updateAccountBalance(double newBalance) {
    accountBalance = newBalance;
  }
}

/// Risk Assessment Result
class RiskAssessment {
  final bool isAcceptable;
  final String reason;
  final RiskLevel riskLevel;
  final double? potentialLossPercent;
  
  RiskAssessment({
    required this.isAcceptable,
    required this.reason,
    required this.riskLevel,
    this.potentialLossPercent,
  });
}

/// Risk Level Enum
enum RiskLevel {
  LOW,
  MEDIUM,
  HIGH,
}
