class StockModel {
  final String symbol;
  final String name;
  final String exchange;
  final double currentPrice;
  final double previousClose;
  final double open;
  final double high;
  final double low;
  final double volume;
  final double marketCap;
  final String sector;
  final bool isHalal;
  final DateTime lastUpdated;

  StockModel({
    required this.symbol,
    required this.name,
    required this.exchange,
    required this.currentPrice,
    required this.previousClose,
    required this.open,
    required this.high,
    required this.low,
    required this.volume,
    required this.marketCap,
    required this.sector,
    required this.isHalal,
    required this.lastUpdated,
  });

  // Calculate change
  double get change => currentPrice - previousClose;

  // Calculate change percentage
  double get changePercentage => ((change / previousClose) * 100);

  // Check if stock is gaining
  bool get isGaining => change > 0;

  // Check if stock is losing
  bool get isLosing => change < 0;

  // Factory method to create from JSON
  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      exchange: json['exchange'] ?? 'NSE',
      currentPrice: (json['currentPrice'] ?? 0).toDouble(),
      previousClose: (json['previousClose'] ?? 0).toDouble(),
      open: (json['open'] ?? 0).toDouble(),
      high: (json['high'] ?? 0).toDouble(),
      low: (json['low'] ?? 0).toDouble(),
      volume: (json['volume'] ?? 0).toDouble(),
      marketCap: (json['marketCap'] ?? 0).toDouble(),
      sector: json['sector'] ?? '',
      isHalal: json['isHalal'] ?? true,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : DateTime.now(),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'exchange': exchange,
      'currentPrice': currentPrice,
      'previousClose': previousClose,
      'open': open,
      'high': high,
      'low': low,
      'volume': volume,
      'marketCap': marketCap,
      'sector': sector,
      'isHalal': isHalal,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  // Copy with method
  StockModel copyWith({
    String? symbol,
    String? name,
    String? exchange,
    double? currentPrice,
    double? previousClose,
    double? open,
    double? high,
    double? low,
    double? volume,
    double? marketCap,
    String? sector,
    bool? isHalal,
    DateTime? lastUpdated,
  }) {
    return StockModel(
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      exchange: exchange ?? this.exchange,
      currentPrice: currentPrice ?? this.currentPrice,
      previousClose: previousClose ?? this.previousClose,
      open: open ?? this.open,
      high: high ?? this.high,
      low: low ?? this.low,
      volume: volume ?? this.volume,
      marketCap: marketCap ?? this.marketCap,
      sector: sector ?? this.sector,
      isHalal: isHalal ?? this.isHalal,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
