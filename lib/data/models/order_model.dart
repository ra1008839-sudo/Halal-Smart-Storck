class OrderModel {
  final String id;
  final String symbol;
  final String type; // BUY or SELL
  final String orderType; // Market, Limit, Stop Loss
  final int quantity;
  final double price;
  final double? stopLoss;
  final double? trailingStopLoss;
  final String status; // PENDING, EXECUTED, CANCELLED, REJECTED
  final DateTime createdAt;
  final DateTime? executedAt;
  final String userId;
  
  OrderModel({
    required this.id,
    required this.symbol,
    required this.type,
    required this.orderType,
    required this.quantity,
    required this.price,
    this.stopLoss,
    this.trailingStopLoss,
    required this.status,
    required this.createdAt,
    this.executedAt,
    required this.userId,
  });
  
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      symbol: json['symbol'] ?? '',
      type: json['type'] ?? 'BUY',
      orderType: json['orderType'] ?? 'Market',
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      stopLoss: json['stopLoss']?.toDouble(),
      trailingStopLoss: json['trailingStopLoss']?.toDouble(),
      status: json['status'] ?? 'PENDING',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      executedAt: json['executedAt'] != null ? DateTime.parse(json['executedAt']) : null,
      userId: json['userId'] ?? '',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'type': type,
      'orderType': orderType,
      'quantity': quantity,
      'price': price,
      'stopLoss': stopLoss,
      'trailingStopLoss': trailingStopLoss,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'executedAt': executedAt?.toIso8601String(),
      'userId': userId,
    };
  }
  
  bool get isBuy => type == 'BUY';
  bool get isPending => status == 'PENDING';
  bool get isExecuted => status == 'EXECUTED';
  double get totalValue => quantity * price;
}
