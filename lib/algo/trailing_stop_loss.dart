class TrailingStopLoss {
  double _initialStopLoss;
  double _currentStopLoss;
  final double trailingPercent; // Percentage to trail (0.5% - 10%)
  double _highestPrice;

  TrailingStopLoss({
    required double initialStopLoss,
    required this.trailingPercent,
    required double initialPrice,
  })  : _initialStopLoss = initialStopLoss,
        _currentStopLoss = initialStopLoss,
        _highestPrice = initialPrice {
    assert(trailingPercent >= 0.005 && trailingPercent <= 0.10,
        'Trailing percent must be between 0.5% and 10%');
  }

  // Update stop loss based on current price
  void update(double currentPrice) {
    // Update highest price if current price is higher
    if (currentPrice > _highestPrice) {
      _highestPrice = currentPrice;

      // Calculate new stop loss
      final newStopLoss = _highestPrice * (1 - trailingPercent);

      // Only move stop loss up, never down
      if (newStopLoss > _currentStopLoss) {
        _currentStopLoss = newStopLoss;
      }
    }
  }

  // Get current stop loss value
  double get currentStopLoss => _currentStopLoss;

  // Get initial stop loss value
  double get initialStopLoss => _initialStopLoss;

  // Get highest price reached
  double get highestPrice => _highestPrice;

  // Check if stop loss is hit
  bool isHit(double currentPrice) {
    return currentPrice <= _currentStopLoss;
  }

  // Get profit percentage from entry
  double getProfitPercent(double entryPrice) {
    return ((_highestPrice - entryPrice) / entryPrice) * 100;
  }

  // Get how much stop loss has trailed
  double getTrailedAmount() {
    return _currentStopLoss - _initialStopLoss;
  }

  // Reset to initial state
  void reset(double newInitialStopLoss, double newInitialPrice) {
    _initialStopLoss = newInitialStopLoss;
    _currentStopLoss = newInitialStopLoss;
    _highestPrice = newInitialPrice;
  }
}
