class OrderModel {
  final String id;
  final String symbol;
  final String orderType; // 'BUY' or 'SELL'
  final String priceType; // 'MARKET', 'LIMIT', 'STOP_LOSS'
  final double quantity;
  final double price;
  final double? stopLossPrice;
  final String status; // 'PENDING', 'EXECUTED', 'CANCELLED', 'REJECTED'
  final DateTime createdAt;
  final DateTime? executedAt;

  OrderModel({
    required this.id,
    required this.symbol,
    required this.orderType,
    required this.priceType,
    required this.quantity,
    required this.price,
    this.stopLossPrice,
    required this.status,
    required this.createdAt,
    this.executedAt,
  });

  // Calculate total value
  double get totalValue => quantity * price;

  // Check if order is buy
  bool get isBuyOrder => orderType == 'BUY';

  // Check if order is sell
  bool get isSellOrder => orderType == 'SELL';

  // Check if order is pending
  bool get isPending => status == 'PENDING';

  // Check if order is executed
  bool get isExecuted => status == 'EXECUTED';

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      symbol: json['symbol'] ?? '',
      orderType: json['orderType'] ?? 'BUY',
      priceType: json['priceType'] ?? 'MARKET',
      quantity: (json['quantity'] ?? 0).toDouble(),
      price: (json['price'] ?? 0).toDouble(),
      stopLossPrice: json['stopLossPrice'] != null
          ? (json['stopLossPrice']).toDouble()
          : null,
      status: json['status'] ?? 'PENDING',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      executedAt: json['executedAt'] != null
          ? DateTime.parse(json['executedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'orderType': orderType,
      'priceType': priceType,
      'quantity': quantity,
      'price': price,
      'stopLossPrice': stopLossPrice,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'executedAt': executedAt?.toIso8601String(),
    };
  }

  OrderModel copyWith({
    String? id,
    String? symbol,
    String? orderType,
    String? priceType,
    double? quantity,
    double? price,
    double? stopLossPrice,
    String? status,
    DateTime? createdAt,
    DateTime? executedAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      orderType: orderType ?? this.orderType,
      priceType: priceType ?? this.priceType,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      stopLossPrice: stopLossPrice ?? this.stopLossPrice,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      executedAt: executedAt ?? this.executedAt,
    );
  }
}
