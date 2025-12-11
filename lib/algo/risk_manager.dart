import 'algo_engine.dart';

class RiskManager {
  final double maxRiskPerTrade = 0.02; // 2% max loss per trade
  final double minRiskRewardRatio = 1.5; // Minimum 1:1.5 risk-reward

  // Validate and adjust trade signal based on risk parameters
  TradeSignal? validateSignal({
    required TradeSignal signal,
    required double portfolioValue,
    required double currentPrice,
  }) {
    // Calculate risk amount
    final riskAmount = (signal.price - signal.stopLoss).abs() * signal.quantity;
    final maxAllowedRisk = portfolioValue * maxRiskPerTrade;

    // If risk is too high, reduce quantity
    if (riskAmount > maxAllowedRisk) {
      final priceRisk = (signal.price - signal.stopLoss).abs();
      if (priceRisk == 0) return null;
      
      final adjustedQuantity = maxAllowedRisk / priceRisk;
      
      return TradeSignal(
        type: signal.type,
        price: signal.price,
        quantity: adjustedQuantity,
        stopLoss: signal.stopLoss,
        target: signal.target,
        reason: '${signal.reason} (Risk-Adjusted)',
        timestamp: signal.timestamp,
      );
    }

    // Calculate risk-reward ratio
    final risk = (signal.price - signal.stopLoss).abs();
    final reward = (signal.target - signal.price).abs();
    final riskRewardRatio = reward / risk;

    // Reject if risk-reward is not favorable
    if (riskRewardRatio < minRiskRewardRatio) {
      return null;
    }

    return signal;
  }

  // Calculate position size based on risk
  double calculatePositionSize({
    required double portfolioValue,
    required double entryPrice,
    required double stopLoss,
  }) {
    final maxLoss = portfolioValue * maxRiskPerTrade;
    final priceRisk = (entryPrice - stopLoss).abs();
    
    if (priceRisk == 0) return 0;
    
    return maxLoss / priceRisk;
  }

  // Check if we should continue holding position
  bool shouldHold({
    required double entryPrice,
    required double currentPrice,
    required double stopLoss,
    required double target,
  }) {
    // Exit if stop loss hit
    if (currentPrice <= stopLoss) return false;
    
    // Exit if target reached
    if (currentPrice >= target) return false;
    
    return true;
  }
}
