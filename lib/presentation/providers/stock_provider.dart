import 'package:flutter/material.dart';
import '../../data/models/stock_model.dart';
import '../../data/static/halal_stocks_data.dart';

class StockProvider with ChangeNotifier {
  List<StockModel> _stocks = [];
  List<StockModel> _topGainers = [];
  List<StockModel> _topLosers = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  String? _selectedSector;

  List<StockModel> get stocks => _filteredStocks();
  List<StockModel> get topGainers => _topGainers;
  List<StockModel> get topLosers => _topLosers;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  String? get selectedSector => _selectedSector;

  StockProvider() {
    loadStocks();
  }

  List<StockModel> _filteredStocks() {
    var filtered = _stocks;

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((stock) {
        return stock.symbol.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               stock.name.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Filter by sector
    if (_selectedSector != null && _selectedSector!.isNotEmpty) {
      filtered = filtered.where((stock) => stock.sector == _selectedSector).toList();
    }

    return filtered;
  }

  Future<void> loadStocks() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      _stocks = HalalStocksData.getHalalStocks();
      _topGainers = HalalStocksData.getTopGainers(limit: 10);
      _topLosers = HalalStocksData.getTopLosers(limit: 10);
      
      _error = null;
    } catch (e) {
      _error = 'Failed to load stocks: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshStocks() async {
    await loadStocks();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSector(String? sector) {
    _selectedSector = sector;
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedSector = null;
    notifyListeners();
  }

  StockModel? getStockBySymbol(String symbol) {
    try {
      return _stocks.firstWhere((stock) => stock.symbol == symbol);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateStockPrice(String symbol, double newPrice) async {
    final index = _stocks.indexWhere((stock) => stock.symbol == symbol);
    if (index != -1) {
      _stocks[index] = _stocks[index].copyWith(
        currentPrice: newPrice,
        lastUpdated: DateTime.now(),
      );
      notifyListeners();
    }
  }
}
