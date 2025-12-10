class PortfolioModel {
  final String userId;
  final double totalInvestment;
  final double currentValue;
  final double totalPnL;
  final double totalPnLPercent;
  final List<HoldingModel> holdings;
  final DateTime lastUpdated;
  
  PortfolioModel({
    required this.userId,
    required this.totalInvestment,
    required this.currentValue,
    required this.totalPnL,
    required this.totalPnLPercent,
    required this.holdings,
    required this.lastUpdated,
  });
  
  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    return PortfolioModel(
      userId: json['userId'] ?? '',
      totalInvestment: (json['totalInvestment'] ?? 0).toDouble(),
      currentValue: (json['currentValue'] ?? 0).toDouble(),
      totalPnL: (json['totalPnL'] ?? 0).toDouble(),
      totalPnLPercent: (json['totalPnLPercent'] ?? 0).toDouble(),
      holdings: (json['holdings'] as List?)
          ?.map((h) => HoldingModel.fromJson(h))
          .toList() ?? [],
      lastUpdated: DateTime.parse(json['lastUpdated'] ?? DateTime.now().toIso8601String()),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'totalInvestment': totalInvestment,
      'currentValue': currentValue,
      'totalPnL': totalPnL,
      'totalPnLPercent': totalPnLPercent,
      'holdings': holdings.map((h) => h.toJson()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}

class HoldingModel {
  final String symbol;
  final String name;
  final int quantity;
  final double avgPrice;
  final double currentPrice;
  final double investedValue;
  final double currentValue;
  final double pnl;
  final double pnlPercent;
  final DateTime purchaseDate;
  
  HoldingModel({
    required this.symbol,
    required this.name,
    required this.quantity,
    required this.avgPrice,
    required this.currentPrice,
    required this.investedValue,
    required this.currentValue,
    required this.pnl,
    required this.pnlPercent,
    required this.purchaseDate,
  });
  
  factory HoldingModel.fromJson(Map<String, dynamic> json) {
    return HoldingModel(
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      avgPrice: (json['avgPrice'] ?? 0).toDouble(),
      currentPrice: (json['currentPrice'] ?? 0).toDouble(),
      investedValue: (json['investedValue'] ?? 0).toDouble(),
      currentValue: (json['currentValue'] ?? 0).toDouble(),
      pnl: (json['pnl'] ?? 0).toDouble(),
      pnlPercent: (json['pnlPercent'] ?? 0).toDouble(),
      purchaseDate: DateTime.parse(json['purchaseDate'] ?? DateTime.now().toIso8601String()),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'quantity': quantity,
      'avgPrice': avgPrice,
      'currentPrice': currentPrice,
      'investedValue': investedValue,
      'currentValue': currentValue,
      'pnl': pnl,
      'pnlPercent': pnlPercent,
      'purchaseDate': purchaseDate.toIso8601String(),
    };
  }
  
  bool get isProfit => pnl >= 0;
}
