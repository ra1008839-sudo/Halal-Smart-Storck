/// Stock Model
class Stock {
  final String id;
  final String symbol;
  final String name;
  final String exchange; // NSE or BSE
  final double currentPrice;
  final double openPrice;
  final double highPrice;
  final double lowPrice;
  final double previousClose;
  final double changeAmount;
  final double changePercent;
  final int volume;
  final int marketCap;
  final String industry;
  final String sector;
  final bool isHalal;
  final String halalCertification;
  final double? pe;
  final double? eps;
  final double? dividendYield;
  final double? week52High;
  final double? week52Low;
  final double? bookValue;
  final double? roe;
  final double? debtToEquity;
  final DateTime lastUpdated;
  
  Stock({
    required this.id,
    required this.symbol,
    required this.name,
    required this.exchange,
    required this.currentPrice,
    required this.openPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.previousClose,
    required this.changeAmount,
    required this.changePercent,
    required this.volume,
    required this.marketCap,
    required this.industry,
    required this.sector,
    required this.isHalal,
    required this.halalCertification,
    this.pe,
    this.eps,
    this.dividendYield,
    this.week52High,
    this.week52Low,
    this.bookValue,
    this.roe,
    this.debtToEquity,
    required this.lastUpdated,
  });
  
  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      exchange: json['exchange'] as String,
      currentPrice: (json['currentPrice'] as num).toDouble(),
      openPrice: (json['openPrice'] as num).toDouble(),
      highPrice: (json['highPrice'] as num).toDouble(),
      lowPrice: (json['lowPrice'] as num).toDouble(),
      previousClose: (json['previousClose'] as num).toDouble(),
      changeAmount: (json['changeAmount'] as num).toDouble(),
      changePercent: (json['changePercent'] as num).toDouble(),
      volume: json['volume'] as int,
      marketCap: json['marketCap'] as int,
      industry: json['industry'] as String,
      sector: json['sector'] as String,
      isHalal: json['isHalal'] as bool,
      halalCertification: json['halalCertification'] as String,
      pe: json['pe'] != null ? (json['pe'] as num).toDouble() : null,
      eps: json['eps'] != null ? (json['eps'] as num).toDouble() : null,
      dividendYield: json['dividendYield'] != null ? (json['dividendYield'] as num).toDouble() : null,
      week52High: json['week52High'] != null ? (json['week52High'] as num).toDouble() : null,
      week52Low: json['week52Low'] != null ? (json['week52Low'] as num).toDouble() : null,
      bookValue: json['bookValue'] != null ? (json['bookValue'] as num).toDouble() : null,
      roe: json['roe'] != null ? (json['roe'] as num).toDouble() : null,
      debtToEquity: json['debtToEquity'] != null ? (json['debtToEquity'] as num).toDouble() : null,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'exchange': exchange,
      'currentPrice': currentPrice,
      'openPrice': openPrice,
      'highPrice': highPrice,
      'lowPrice': lowPrice,
      'previousClose': previousClose,
      'changeAmount': changeAmount,
      'changePercent': changePercent,
      'volume': volume,
      'marketCap': marketCap,
      'industry': industry,
      'sector': sector,
      'isHalal': isHalal,
      'halalCertification': halalCertification,
      'pe': pe,
      'eps': eps,
      'dividendYield': dividendYield,
      'week52High': week52High,
      'week52Low': week52Low,
      'bookValue': bookValue,
      'roe': roe,
      'debtToEquity': debtToEquity,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
  
  Stock copyWith({
    String? id,
    String? symbol,
    String? name,
    String? exchange,
    double? currentPrice,
    double? openPrice,
    double? highPrice,
    double? lowPrice,
    double? previousClose,
    double? changeAmount,
    double? changePercent,
    int? volume,
    int? marketCap,
    String? industry,
    String? sector,
    bool? isHalal,
    String? halalCertification,
    double? pe,
    double? eps,
    double? dividendYield,
    double? week52High,
    double? week52Low,
    double? bookValue,
    double? roe,
    double? debtToEquity,
    DateTime? lastUpdated,
  }) {
    return Stock(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      exchange: exchange ?? this.exchange,
      currentPrice: currentPrice ?? this.currentPrice,
      openPrice: openPrice ?? this.openPrice,
      highPrice: highPrice ?? this.highPrice,
      lowPrice: lowPrice ?? this.lowPrice,
      previousClose: previousClose ?? this.previousClose,
      changeAmount: changeAmount ?? this.changeAmount,
      changePercent: changePercent ?? this.changePercent,
      volume: volume ?? this.volume,
      marketCap: marketCap ?? this.marketCap,
      industry: industry ?? this.industry,
      sector: sector ?? this.sector,
      isHalal: isHalal ?? this.isHalal,
      halalCertification: halalCertification ?? this.halalCertification,
      pe: pe ?? this.pe,
      eps: eps ?? this.eps,
      dividendYield: dividendYield ?? this.dividendYield,
      week52High: week52High ?? this.week52High,
      week52Low: week52Low ?? this.week52Low,
      bookValue: bookValue ?? this.bookValue,
      roe: roe ?? this.roe,
      debtToEquity: debtToEquity ?? this.debtToEquity,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
  
  bool get isPositive => changePercent >= 0;
  bool get isNegative => changePercent < 0;
}
