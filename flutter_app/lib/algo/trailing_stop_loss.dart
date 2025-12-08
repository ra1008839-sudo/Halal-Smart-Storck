/// Trailing Stop Loss Manager
/// Handles dynamic stop loss adjustment as price moves in favorable direction

import '../config/app_config.dart';

class TrailingStopLoss {
  /// Calculate new trailing stop loss
  /// Returns null if stop loss should not be adjusted
  static double? calculate({
    required double entryPrice,
    required double currentPrice,
    required double currentStopLoss,
    required double trailingPercent,
  }) {
    // Validate trailing percent is within range
    if (trailingPercent < AppConfig.minTrailingStopLoss ||
        trailingPercent > AppConfig.maxTrailingStopLoss) {
      throw ArgumentError(
        'Trailing percent must be between ${AppConfig.minTrailingStopLoss}% and ${AppConfig.maxTrailingStopLoss}%',
      );
    }
    
    // Only trail if price moved favorably from entry
    if (currentPrice <= entryPrice) {
      return null; // Don't adjust stop loss yet
    }
    
    // Calculate new stop loss based on current price
    final newStopLoss = currentPrice * (1 - trailingPercent / 100);
    
    // Only move stop loss up, never down
    if (newStopLoss > currentStopLoss) {
      return newStopLoss;
    }
    
    return null; // Don't adjust
  }
  
  /// Calculate trailing stop loss for multiple positions
  static Map<String, double?> calculateForPositions(
    Map<String, PositionData> positions,
  ) {
    Map<String, double?> newStopLosses = {};
    
    for (final entry in positions.entries) {
      final positionId = entry.key;
      final position = entry.value;
      
      final newStopLoss = calculate(
        entryPrice: position.entryPrice,
        currentPrice: position.currentPrice,
        currentStopLoss: position.stopLoss,
        trailingPercent: position.trailingPercent,
      );
      
      newStopLosses[positionId] = newStopLoss;
    }
    
    return newStopLosses;
  }
  
  /// Check if stop loss should be moved to breakeven
  static bool shouldMoveToBreakeven({
    required double entryPrice,
    required double currentPrice,
    required double currentStopLoss,
    double profitThreshold = 2.0, // Move to breakeven after 2% profit
  }) {
    final profitPercent = ((currentPrice - entryPrice) / entryPrice) * 100;
    
    // If profit exceeds threshold and stop loss is still below entry
    if (profitPercent >= profitThreshold && currentStopLoss < entryPrice) {
      return true;
    }
    
    return false;
  }
  
  /// Calculate breakeven stop loss
  static double calculateBreakeven({
    required double entryPrice,
    double buffer = 0.1, // 0.1% buffer to avoid whipsaws
  }) {
    return entryPrice * (1 + buffer / 100);
  }
  
  /// Get recommended trailing stop loss percentage based on volatility
  static double getRecommendedTrailingPercent({
    required double volatility,
  }) {
    // Low volatility (< 1%): Tighter stop loss
    if (volatility < 1.0) {
      return 1.0;
    }
    // Medium volatility (1-2%): Standard stop loss
    else if (volatility < 2.0) {
      return 2.0;
    }
    // High volatility (2-3%): Wider stop loss
    else if (volatility < 3.0) {
      return 3.0;
    }
    // Very high volatility (>3%): Much wider stop loss
    else {
      return 5.0;
    }
  }
  
  /// Calculate profit locked in by current stop loss
  static double calculateLockedProfit({
    required double entryPrice,
    required double currentStopLoss,
  }) {
    if (currentStopLoss <= entryPrice) {
      return 0.0; // No profit locked
    }
    
    return ((currentStopLoss - entryPrice) / entryPrice) * 100;
  }
  
  /// Simulate trailing stop loss over price history
  static TrailingStopLossSimulation simulate({
    required double entryPrice,
    required double initialStopLoss,
    required List<double> priceHistory,
    required double trailingPercent,
  }) {
    double currentStopLoss = initialStopLoss;
    double maxProfit = 0.0;
    double? exitPrice;
    int? exitIndex;
    
    for (int i = 0; i < priceHistory.length; i++) {
      final price = priceHistory[i];
      
      // Check if stop loss hit
      if (price <= currentStopLoss) {
        exitPrice = currentStopLoss;
        exitIndex = i;
        break;
      }
      
      // Update max profit
      final profit = ((price - entryPrice) / entryPrice) * 100;
      if (profit > maxProfit) {
        maxProfit = profit;
      }
      
      // Update trailing stop loss
      final newStopLoss = calculate(
        entryPrice: entryPrice,
        currentPrice: price,
        currentStopLoss: currentStopLoss,
        trailingPercent: trailingPercent,
      );
      
      if (newStopLoss != null) {
        currentStopLoss = newStopLoss;
      }
    }
    
    // If not exited, use last price
    if (exitPrice == null) {
      exitPrice = priceHistory.last;
      exitIndex = priceHistory.length - 1;
    }
    
    final finalProfit = ((exitPrice - entryPrice) / entryPrice) * 100;
    
    return TrailingStopLossSimulation(
      entryPrice: entryPrice,
      exitPrice: exitPrice,
      exitIndex: exitIndex!,
      finalProfit: finalProfit,
      maxProfit: maxProfit,
      profitCaptured: (finalProfit / maxProfit) * 100,
    );
  }
}

/// Position Data Model
class PositionData {
  final double entryPrice;
  final double currentPrice;
  final double stopLoss;
  final double trailingPercent;
  
  PositionData({
    required this.entryPrice,
    required this.currentPrice,
    required this.stopLoss,
    required this.trailingPercent,
  });
}

/// Trailing Stop Loss Simulation Result
class TrailingStopLossSimulation {
  final double entryPrice;
  final double exitPrice;
  final int exitIndex;
  final double finalProfit;
  final double maxProfit;
  final double profitCaptured; // Percentage of max profit captured
  
  TrailingStopLossSimulation({
    required this.entryPrice,
    required this.exitPrice,
    required this.exitIndex,
    required this.finalProfit,
    required this.maxProfit,
    required this.profitCaptured,
  });
}
