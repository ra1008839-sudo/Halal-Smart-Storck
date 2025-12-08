/// Signal Generator for Algo Trading
/// Generates BUY/SELL/HOLD signals based on technical analysis

import '../data/models/stock.dart';
import '../indicators/rsi_calculator.dart';
import '../indicators/macd_calculator.dart';
import '../indicators/bollinger_calculator.dart';
import '../indicators/moving_average_calculator.dart';

class SignalGenerator {
  /// Generate trading signal based on multiple indicators
  TradingSignal generateSignal(Stock stock, Map<String, dynamic> indicators) {
    double confidence = 0;
    List<String> reasons = [];
    TradingAction suggestedAction = TradingAction.HOLD;
    
    // Get indicator values
    final rsi = indicators['rsi'] as double?;
    final macd = indicators['macd'] as MACDResult?;
    final bollinger = indicators['bollinger'] as BollingerBands?;
    final priceHistory = indicators['priceHistory'] as List<double>?;
    
    int buySignals = 0;
    int sellSignals = 0;
    
    // RSI Analysis
    if (rsi != null) {
      if (RSICalculator.isOversold(rsi)) {
        buySignals++;
        confidence += 15;
        reasons.add('RSI oversold (${rsi.toStringAsFixed(2)})');
      } else if (RSICalculator.isOverbought(rsi)) {
        sellSignals++;
        confidence += 15;
        reasons.add('RSI overbought (${rsi.toStringAsFixed(2)})');
      }
    }
    
    // MACD Analysis
    if (macd != null) {
      final signal = MACDCalculator.getSignal(macd);
      if (signal == MACDSignal.BULLISH && macd.histogram > 0) {
        buySignals++;
        confidence += 20;
        reasons.add('MACD bullish crossover');
      } else if (signal == MACDSignal.BEARISH && macd.histogram < 0) {
        sellSignals++;
        confidence += 20;
        reasons.add('MACD bearish crossover');
      }
    }
    
    // Bollinger Bands Analysis
    if (bollinger != null) {
      final signal = BollingerCalculator.getSignal(stock.currentPrice, bollinger);
      if (signal == BollingerSignal.OVERSOLD) {
        buySignals++;
        confidence += 15;
        reasons.add('Price at lower Bollinger Band');
      } else if (signal == BollingerSignal.OVERBOUGHT) {
        sellSignals++;
        confidence += 15;
        reasons.add('Price at upper Bollinger Band');
      }
    }
    
    // Moving Average Analysis
    if (priceHistory != null && priceHistory.length >= 50) {
      final sma20 = MovingAverageCalculator.calculateSMA(priceHistory, 20);
      final sma50 = MovingAverageCalculator.calculateSMA(priceHistory, 50);
      
      if (stock.currentPrice > sma20 && sma20 > sma50) {
        buySignals++;
        confidence += 10;
        reasons.add('Price above SMA(20) and SMA(50)');
      } else if (stock.currentPrice < sma20 && sma20 < sma50) {
        sellSignals++;
        confidence += 10;
        reasons.add('Price below SMA(20) and SMA(50)');
      }
      
      // Golden/Death Cross
      if (MovingAverageCalculator.isGoldenCross(priceHistory)) {
        buySignals += 2;
        confidence += 25;
        reasons.add('Golden Cross detected');
      } else if (MovingAverageCalculator.isDeathCross(priceHistory)) {
        sellSignals += 2;
        confidence += 25;
        reasons.add('Death Cross detected');
      }
    }
    
    // Price Trend Analysis
    if (stock.changePercent > 2.0) {
      buySignals++;
      confidence += 10;
      reasons.add('Strong upward momentum (+${stock.changePercent.toStringAsFixed(2)}%)');
    } else if (stock.changePercent < -2.0) {
      sellSignals++;
      confidence += 10;
      reasons.add('Strong downward momentum (${stock.changePercent.toStringAsFixed(2)}%)');
    }
    
    // Volume Analysis
    if (stock.volume > indicators['avgVolume'] as int? ?? 0) {
      confidence += 10;
      reasons.add('Above average volume');
    }
    
    // Determine final action
    if (buySignals > sellSignals && buySignals >= 2) {
      suggestedAction = TradingAction.BUY;
    } else if (sellSignals > buySignals && sellSignals >= 2) {
      suggestedAction = TradingAction.SELL;
    } else {
      suggestedAction = TradingAction.HOLD;
      reasons.add('Mixed signals - waiting for clearer trend');
    }
    
    // Calculate stop loss and target
    double? stopLoss;
    double? target;
    double? trailingStopLoss;
    
    if (suggestedAction == TradingAction.BUY) {
      // Set stop loss 2% below current price
      stopLoss = stock.currentPrice * 0.98;
      // Set target 5% above current price (2.5:1 risk-reward)
      target = stock.currentPrice * 1.05;
      // Set trailing stop loss at 2%
      trailingStopLoss = 2.0;
    } else if (suggestedAction == TradingAction.SELL) {
      // For selling existing position
      stopLoss = stock.currentPrice * 1.02; // Stop loss above current price
    }
    
    // Ensure confidence doesn't exceed 100
    confidence = confidence > 100 ? 100 : confidence;
    
    return TradingSignal(
      action: suggestedAction,
      confidence: confidence,
      reason: reasons.join(', '),
      stopLoss: stopLoss,
      target: target,
      trailingStopLoss: trailingStopLoss,
    );
  }
  
  /// Generate quick signal based on current price action
  TradingSignal quickSignal(Stock stock) {
    if (stock.changePercent > 3.0) {
      return TradingSignal(
        action: TradingAction.BUY,
        confidence: 60,
        reason: 'Strong positive momentum',
        stopLoss: stock.currentPrice * 0.98,
        target: stock.currentPrice * 1.05,
        trailingStopLoss: 2.0,
      );
    } else if (stock.changePercent < -3.0) {
      return TradingSignal(
        action: TradingAction.SELL,
        confidence: 60,
        reason: 'Strong negative momentum',
      );
    } else {
      return TradingSignal(
        action: TradingAction.HOLD,
        confidence: 50,
        reason: 'Neutral price action',
      );
    }
  }
}

enum TradingAction {
  BUY,
  SELL,
  HOLD,
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
