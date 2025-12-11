class CandleModel {
  final DateTime timestamp;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;

  CandleModel({
    required this.timestamp,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  // Check if candle is bullish
  bool get isBullish => close > open;

  // Check if candle is bearish
  bool get isBearish => close < open;

  // Get candle body size
  double get bodySize => (close - open).abs();

  // Get candle total range
  double get totalRange => high - low;

  // Get upper shadow size
  double get upperShadow => high - (isBullish ? close : open);

  // Get lower shadow size
  double get lowerShadow => (isBullish ? open : close) - low;

  factory CandleModel.fromJson(Map<String, dynamic> json) {
    return CandleModel(
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
      open: (json['open'] ?? 0).toDouble(),
      high: (json['high'] ?? 0).toDouble(),
      low: (json['low'] ?? 0).toDouble(),
      close: (json['close'] ?? 0).toDouble(),
      volume: (json['volume'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'open': open,
      'high': high,
      'low': low,
      'close': close,
      'volume': volume,
    };
  }

  CandleModel copyWith({
    DateTime? timestamp,
    double? open,
    double? high,
    double? low,
    double? close,
    double? volume,
  }) {
    return CandleModel(
      timestamp: timestamp ?? this.timestamp,
      open: open ?? this.open,
      high: high ?? this.high,
      low: low ?? this.low,
      close: close ?? this.close,
      volume: volume ?? this.volume,
    );
  }
}
