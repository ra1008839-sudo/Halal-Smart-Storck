/// Order Model
class OrderModel {
  final String id;
  final String userId;
  final String stockId;
  final String symbol;
  final String stockName;
  final OrderType orderType; // BUY or SELL
  final OrderCategory category; // MARKET, LIMIT, STOP_LOSS
  final int quantity;
  final double price;
  final double? limitPrice;
  final double? stopLossPrice;
  final double? trailingStopLoss;
  final OrderStatus status;
  final String? exchange;
  final DateTime createdAt;
  final DateTime? executedAt;
  final String? errorMessage;
  
  OrderModel({
    required this.id,
    required this.userId,
    required this.stockId,
    required this.symbol,
    required this.stockName,
    required this.orderType,
    required this.category,
    required this.quantity,
    required this.price,
    this.limitPrice,
    this.stopLossPrice,
    this.trailingStopLoss,
    required this.status,
    this.exchange,
    required this.createdAt,
    this.executedAt,
    this.errorMessage,
  });
  
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      stockId: json['stockId'] as String,
      symbol: json['symbol'] as String,
      stockName: json['stockName'] as String,
      orderType: OrderType.values.firstWhere(
        (e) => e.toString() == 'OrderType.${json['orderType']}',
      ),
      category: OrderCategory.values.firstWhere(
        (e) => e.toString() == 'OrderCategory.${json['category']}',
      ),
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
      limitPrice: json['limitPrice'] != null ? (json['limitPrice'] as num).toDouble() : null,
      stopLossPrice: json['stopLossPrice'] != null ? (json['stopLossPrice'] as num).toDouble() : null,
      trailingStopLoss: json['trailingStopLoss'] != null ? (json['trailingStopLoss'] as num).toDouble() : null,
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == 'OrderStatus.${json['status']}',
      ),
      exchange: json['exchange'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      executedAt: json['executedAt'] != null ? DateTime.parse(json['executedAt'] as String) : null,
      errorMessage: json['errorMessage'] as String?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'stockId': stockId,
      'symbol': symbol,
      'stockName': stockName,
      'orderType': orderType.toString().split('.').last,
      'category': category.toString().split('.').last,
      'quantity': quantity,
      'price': price,
      'limitPrice': limitPrice,
      'stopLossPrice': stopLossPrice,
      'trailingStopLoss': trailingStopLoss,
      'status': status.toString().split('.').last,
      'exchange': exchange,
      'createdAt': createdAt.toIso8601String(),
      'executedAt': executedAt?.toIso8601String(),
      'errorMessage': errorMessage,
    };
  }
  
  double get totalValue => price * quantity;
}

enum OrderType {
  BUY,
  SELL,
}

enum OrderCategory {
  MARKET,
  LIMIT,
  STOP_LOSS,
  TRAILING_STOP_LOSS,
}

enum OrderStatus {
  PENDING,
  EXECUTED,
  CANCELLED,
  REJECTED,
  PARTIAL,
}
