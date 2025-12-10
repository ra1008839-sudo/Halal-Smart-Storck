import 'package:flutter/foundation.dart';
import '../../data/models/portfolio_model.dart';
import '../../services/api_service.dart';

class PortfolioProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  PortfolioModel? _portfolio;
  bool _isLoading = false;
  String? _errorMessage;
  
  PortfolioModel? get portfolio => _portfolio;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  
  double get totalInvestment => _portfolio?.totalInvestment ?? 0.0;
  double get currentValue => _portfolio?.currentValue ?? 0.0;
  double get totalPnL => _portfolio?.totalPnL ?? 0.0;
  double get totalPnLPercent => _portfolio?.totalPnLPercent ?? 0.0;
  List<HoldingModel> get holdings => _portfolio?.holdings ?? [];
  
  Future<void> fetchPortfolio(String userId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      
      final response = await _apiService.get('/portfolio/$userId');
      if (response.statusCode == 200) {
        _portfolio = PortfolioModel.fromJson(response.data);
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> refreshPortfolio() async {
    if (_portfolio != null) {
      await fetchPortfolio(_portfolio!.userId);
    }
  }
  
  Future<void> addHolding(HoldingModel holding) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      final response = await _apiService.post(
        '/portfolio/holdings',
        data: holding.toJson(),
      );
      
      if (response.statusCode == 200) {
        await refreshPortfolio();
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> removeHolding(String symbol) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      final response = await _apiService.delete('/portfolio/holdings/$symbol');
      
      if (response.statusCode == 200) {
        _portfolio?.holdings.removeWhere((h) => h.symbol == symbol);
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
  
  HoldingModel? getHolding(String symbol) {
    return holdings.firstWhere(
      (h) => h.symbol == symbol,
      orElse: () => HoldingModel(
        symbol: '',
        name: '',
        quantity: 0,
        avgPrice: 0,
        currentPrice: 0,
        investedValue: 0,
        currentValue: 0,
        pnl: 0,
        pnlPercent: 0,
        purchaseDate: DateTime.now(),
      ),
    );
  }
  
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
