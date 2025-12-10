import 'package:flutter/foundation.dart';
import '../../data/models/stock_model.dart';
import '../../services/api_service.dart';
import '../../services/storage_service.dart';

class WatchlistProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  late final StorageService _storageService;
  
  List<StockModel> _watchlistStocks = [];
  bool _isLoading = false;
  String? _errorMessage;
  
  List<StockModel> get watchlistStocks => _watchlistStocks;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get count => _watchlistStocks.length;
  
  WatchlistProvider() {
    _initializeStorage();
  }
  
  Future<void> _initializeStorage() async {
    _storageService = await StorageService.getInstance();
    await loadWatchlist();
  }
  
  Future<void> loadWatchlist() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      // Load from local storage first
      final savedWatchlist = _storageService.getObject('watchlist');
      if (savedWatchlist != null) {
        final symbols = (savedWatchlist['symbols'] as List).cast<String>();
        
        // Fetch stock details for each symbol
        for (final symbol in symbols) {
          final response = await _apiService.get('/stocks/$symbol');
          if (response.statusCode == 200) {
            _watchlistStocks.add(StockModel.fromJson(response.data));
          }
        }
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> addStock(StockModel stock) async {
    if (_watchlistStocks.any((s) => s.symbol == stock.symbol)) {
      return; // Already in watchlist
    }
    
    try {
      _watchlistStocks.add(stock);
      await _saveToStorage();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
  
  Future<void> removeStock(String symbol) async {
    try {
      _watchlistStocks.removeWhere((s) => s.symbol == symbol);
      await _saveToStorage();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
  
  Future<void> _saveToStorage() async {
    final symbols = _watchlistStocks.map((s) => s.symbol).toList();
    await _storageService.saveObject('watchlist', {'symbols': symbols});
  }
  
  bool isInWatchlist(String symbol) {
    return _watchlistStocks.any((s) => s.symbol == symbol);
  }
  
  Future<void> refreshWatchlist() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      final updatedStocks = <StockModel>[];
      for (final stock in _watchlistStocks) {
        final response = await _apiService.get('/stocks/${stock.symbol}');
        if (response.statusCode == 200) {
          updatedStocks.add(StockModel.fromJson(response.data));
        }
      }
      
      _watchlistStocks = updatedStocks;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
  
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
