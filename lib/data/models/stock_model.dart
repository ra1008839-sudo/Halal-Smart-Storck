class StockModel {
  final String symbol;
  final String name;
  final double currentPrice;
  final double change;
  final double changePercent;
  final double open;
  final double high;
  final double low;
  final double previousClose;
  final int volume;
  final String halalStatus;
  final double marketCap;
  final double pe;
  final double eps;
  final String sector;
  final String exchange;
  
  StockModel({
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.change,
    required this.changePercent,
    required this.open,
    required this.high,
    required this.low,
    required this.previousClose,
    required this.volume,
    required this.halalStatus,
    this.marketCap = 0.0,
    this.pe = 0.0,
    this.eps = 0.0,
    this.sector = '',
    this.exchange = 'NSE',
  });
  
  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      currentPrice: (json['currentPrice'] ?? 0).toDouble(),
      change: (json['change'] ?? 0).toDouble(),
      changePercent: (json['changePercent'] ?? 0).toDouble(),
      open: (json['open'] ?? 0).toDouble(),
      high: (json['high'] ?? 0).toDouble(),
      low: (json['low'] ?? 0).toDouble(),
      previousClose: (json['previousClose'] ?? 0).toDouble(),
      volume: json['volume'] ?? 0,
      halalStatus: json['halalStatus'] ?? 'UNDER_REVIEW',
      marketCap: (json['marketCap'] ?? 0).toDouble(),
      pe: (json['pe'] ?? 0).toDouble(),
      eps: (json['eps'] ?? 0).toDouble(),
      sector: json['sector'] ?? '',
      exchange: json['exchange'] ?? 'NSE',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'currentPrice': currentPrice,
      'change': change,
      'changePercent': changePercent,
      'open': open,
      'high': high,
      'low': low,
      'previousClose': previousClose,
      'volume': volume,
      'halalStatus': halalStatus,
      'marketCap': marketCap,
      'pe': pe,
      'eps': eps,
      'sector': sector,
      'exchange': exchange,
    };
  }
  
  bool get isPositive => change >= 0;
  bool get isHalal => halalStatus == 'HALAL_VERIFIED' || halalStatus == 'HALAL_COMPLIANT';
}
