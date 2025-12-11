import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../data/models/stock_model.dart';

class WatchlistProvider with ChangeNotifier {
  final List<String> _watchlistSymbols = [];
  bool _isLoading = false;

  List<String> get watchlistSymbols => List.unmodifiable(_watchlistSymbols);
  bool get isLoading => _isLoading;
  int get watchlistCount => _watchlistSymbols.length;

  WatchlistProvider() {
    loadWatchlist();
  }

  Future<void> loadWatchlist() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final watchlistJson = prefs.getString('watchlist');
      
      if (watchlistJson != null) {
        final List<dynamic> decoded = json.decode(watchlistJson);
        _watchlistSymbols.clear();
        _watchlistSymbols.addAll(decoded.cast<String>());
      }
    } catch (e) {
      // Handle error silently or log
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveWatchlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final watchlistJson = json.encode(_watchlistSymbols);
      await prefs.setString('watchlist', watchlistJson);
    } catch (e) {
      // Handle error
    }
  }

  bool isInWatchlist(String symbol) {
    return _watchlistSymbols.contains(symbol);
  }

  Future<void> addToWatchlist(StockModel stock) async {
    if (!_watchlistSymbols.contains(stock.symbol)) {
      _watchlistSymbols.add(stock.symbol);
      await _saveWatchlist();
      notifyListeners();
    }
  }

  Future<void> removeFromWatchlist(String symbol) async {
    if (_watchlistSymbols.contains(symbol)) {
      _watchlistSymbols.remove(symbol);
      await _saveWatchlist();
      notifyListeners();
    }
  }

  Future<void> toggleWatchlist(StockModel stock) async {
    if (isInWatchlist(stock.symbol)) {
      await removeFromWatchlist(stock.symbol);
    } else {
      await addToWatchlist(stock);
    }
  }

  Future<void> clearWatchlist() async {
    _watchlistSymbols.clear();
    await _saveWatchlist();
    notifyListeners();
  }

  List<StockModel> getWatchlistStocks(List<StockModel> allStocks) {
    return allStocks.where((stock) => isInWatchlist(stock.symbol)).toList();
  }
}
