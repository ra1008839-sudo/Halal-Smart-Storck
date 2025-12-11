import 'package:flutter/material.dart';
import '../../data/models/stock_model.dart';
import '../../data/models/order_model.dart';

class PortfolioProvider with ChangeNotifier {
  final Map<String, _HoldingData> _holdings = {};
  final List<OrderModel> _orders = [];
  bool _isLoading = false;

  Map<String, _HoldingData> get holdings => _holdings;
  List<OrderModel> get orders => _orders;
  bool get isLoading => _isLoading;

  double get totalInvestment {
    return _holdings.values.fold(0.0, (sum, holding) => sum + holding.totalInvested);
  }

  double getCurrentValue(Map<String, double> currentPrices) {
    return _holdings.entries.fold(0.0, (sum, entry) {
      final currentPrice = currentPrices[entry.key] ?? entry.value.avgPrice;
      return sum + (entry.value.quantity * currentPrice);
    });
  }

  double getProfitLoss(Map<String, double> currentPrices) {
    return getCurrentValue(currentPrices) - totalInvestment;
  }

  double getProfitLossPercentage(Map<String, double> currentPrices) {
    if (totalInvestment == 0) return 0;
    return (getProfitLoss(currentPrices) / totalInvestment) * 100;
  }

  Future<void> loadPortfolio() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock data - in real app, load from backend
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addHolding(StockModel stock, double quantity, double avgPrice) async {
    final symbol = stock.symbol;
    if (_holdings.containsKey(symbol)) {
      final existing = _holdings[symbol]!;
      final totalQuantity = existing.quantity + quantity;
      final totalInvested = existing.totalInvested + (quantity * avgPrice);
      final newAvgPrice = totalInvested / totalQuantity;

      _holdings[symbol] = _HoldingData(
        stock: stock,
        quantity: totalQuantity,
        avgPrice: newAvgPrice,
        totalInvested: totalInvested,
      );
    } else {
      _holdings[symbol] = _HoldingData(
        stock: stock,
        quantity: quantity,
        avgPrice: avgPrice,
        totalInvested: quantity * avgPrice,
      );
    }
    notifyListeners();
  }

  Future<void> removeHolding(String symbol, double quantity) async {
    if (!_holdings.containsKey(symbol)) return;

    final existing = _holdings[symbol]!;
    if (quantity >= existing.quantity) {
      _holdings.remove(symbol);
    } else {
      final newQuantity = existing.quantity - quantity;
      final newTotalInvested = existing.avgPrice * newQuantity;
      _holdings[symbol] = _HoldingData(
        stock: existing.stock,
        quantity: newQuantity,
        avgPrice: existing.avgPrice,
        totalInvested: newTotalInvested,
      );
    }
    notifyListeners();
  }

  Future<void> placeOrder(OrderModel order) async {
    _orders.insert(0, order);
    notifyListeners();

    // In a real app, send order to backend
    await Future.delayed(const Duration(seconds: 1));
  }

  void clearPortfolio() {
    _holdings.clear();
    _orders.clear();
    notifyListeners();
  }
}

class _HoldingData {
  final StockModel stock;
  final double quantity;
  final double avgPrice;
  final double totalInvested;

  _HoldingData({
    required this.stock,
    required this.quantity,
    required this.avgPrice,
    required this.totalInvested,
  });
}
