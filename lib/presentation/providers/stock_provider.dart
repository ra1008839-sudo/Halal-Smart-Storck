import 'package:flutter/foundation.dart';
import '../../data/models/stock_model.dart';
import '../../data/models/candlestick_model.dart';
import '../../services/api_service.dart';
import '../../services/websocket_service.dart';

class StockProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final WebSocketService _wsService = WebSocketService();
  
  List<StockModel> _stocks = [];
  List<StockModel> _searchResults = [];
  StockModel? _selectedStock;
  List<CandlestickModel> _candlesticks = [];
  String _selectedTimeframe = '1D';
  bool _isLoading = false;
  String? _errorMessage;
  
  List<StockModel> get stocks => _stocks;
  List<StockModel> get searchResults => _searchResults;
  StockModel? get selectedStock => _selectedStock;
  List<CandlestickModel> get candlesticks => _candlesticks;
  String get selectedTimeframe => _selectedTimeframe;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  
  StockProvider() {
    _initializeWebSocket();
    fetchStocks();
  }
  
  void _initializeWebSocket() {
    _wsService.dataStream.listen((data) {
      _updateStockFromWebSocket(data);
    });
    _wsService.connect();
  }
  
  Future<void> fetchStocks() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      
      final response = await _apiService.get('/stocks');
      if (response.statusCode == 200) {
        final data = response.data as List;
        _stocks = data.map((json) => StockModel.fromJson(json)).toList();
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> searchStocks(String query) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      final response = await _apiService.get(
        '/stocks/search',
        queryParams: {'q': query},
      );
      
      if (response.statusCode == 200) {
        final data = response.data as List;
        _searchResults = data.map((json) => StockModel.fromJson(json)).toList();
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> selectStock(String symbol) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      final response = await _apiService.get('/stocks/$symbol');
      if (response.statusCode == 200) {
        _selectedStock = StockModel.fromJson(response.data);
        _wsService.subscribeToStock(symbol);
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> fetchCandlesticks(String symbol, String timeframe) async {
    try {
      _isLoading = true;
      _selectedTimeframe = timeframe;
      notifyListeners();
      
      final response = await _apiService.get(
        '/stocks/$symbol/candles',
        queryParams: {'timeframe': timeframe},
      );
      
      if (response.statusCode == 200) {
        final data = response.data as List;
        _candlesticks = data.map((json) => CandlestickModel.fromJson(json)).toList();
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
  
  void _updateStockFromWebSocket(Map<String, dynamic> data) {
    final symbol = data['symbol'] as String?;
    if (symbol == null) return;
    
    // Update stock in list
    final index = _stocks.indexWhere((s) => s.symbol == symbol);
    if (index != -1) {
      _stocks[index] = StockModel.fromJson(data);
      notifyListeners();
    }
    
    // Update selected stock
    if (_selectedStock?.symbol == symbol) {
      _selectedStock = StockModel.fromJson(data);
      notifyListeners();
    }
  }
  
  void clearSearch() {
    _searchResults = [];
    notifyListeners();
  }
  
  @override
  void dispose() {
    _wsService.dispose();
    super.dispose();
  }
}
