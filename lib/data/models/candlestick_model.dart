class CandlestickModel {
  final DateTime time;
  final double open;
  final double high;
  final double low;
  final double close;
  final int volume;
  
  CandlestickModel({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });
  
  factory CandlestickModel.fromJson(Map<String, dynamic> json) {
    return CandlestickModel(
      time: DateTime.parse(json['time'] ?? DateTime.now().toIso8601String()),
      open: (json['open'] ?? 0).toDouble(),
      high: (json['high'] ?? 0).toDouble(),
      low: (json['low'] ?? 0).toDouble(),
      close: (json['close'] ?? 0).toDouble(),
      volume: json['volume'] ?? 0,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'time': time.toIso8601String(),
      'open': open,
      'high': high,
      'low': low,
      'close': close,
      'volume': volume,
    };
  }
  
  bool get isBullish => close >= open;
  double get change => close - open;
  double get changePercent => (change / open) * 100;
}
