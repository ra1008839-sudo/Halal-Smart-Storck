import 'package:flutter/foundation.dart';
import '../../data/models/order_model.dart';
import '../../services/api_service.dart';
import '../../services/audio_service.dart';

class OrderProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final AudioService _audioService = AudioService();
  
  List<OrderModel> _orders = [];
  List<OrderModel> _pendingOrders = [];
  List<OrderModel> _executedOrders = [];
  List<OrderModel> _cancelledOrders = [];
  bool _isLoading = false;
  String? _errorMessage;
  
  List<OrderModel> get orders => _orders;
  List<OrderModel> get pendingOrders => _pendingOrders;
  List<OrderModel> get executedOrders => _executedOrders;
  List<OrderModel> get cancelledOrders => _cancelledOrders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  
  Future<void> fetchOrders(String userId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      
      final response = await _apiService.get('/orders', queryParams: {
        'userId': userId,
      });
      
      if (response.statusCode == 200) {
        final data = response.data as List;
        _orders = data.map((json) => OrderModel.fromJson(json)).toList();
        _categorizeOrders();
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<bool> placeOrder(OrderModel order) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      
      final response = await _apiService.post(
        '/orders',
        data: order.toJson(),
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final newOrder = OrderModel.fromJson(response.data);
        _orders.add(newOrder);
        _categorizeOrders();
        
        // Play sound based on order type
        if (order.isBuy) {
          _audioService.playBuySound();
        } else {
          _audioService.playSellSound();
        }
        
        _isLoading = false;
        notifyListeners();
        return true;
      }
      
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  Future<bool> cancelOrder(String orderId) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      final response = await _apiService.delete('/orders/$orderId');
      
      if (response.statusCode == 200) {
        final index = _orders.indexWhere((o) => o.id == orderId);
        if (index != -1) {
          _orders.removeAt(index);
          _categorizeOrders();
        }
        
        _isLoading = false;
        notifyListeners();
        return true;
      }
      
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  void _categorizeOrders() {
    _pendingOrders = _orders.where((o) => o.status == 'PENDING').toList();
    _executedOrders = _orders.where((o) => o.status == 'EXECUTED').toList();
    _cancelledOrders = _orders
        .where((o) => o.status == 'CANCELLED' || o.status == 'REJECTED')
        .toList();
  }
  
  OrderModel? getOrder(String orderId) {
    try {
      return _orders.firstWhere((o) => o.id == orderId);
    } catch (e) {
      return null;
    }
  }
  
  List<OrderModel> getOrdersBySymbol(String symbol) {
    return _orders.where((o) => o.symbol == symbol).toList();
  }
  
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
