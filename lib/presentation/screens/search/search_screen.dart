import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/stock_model.dart';
import '../../widgets/cards/stock_card.dart';
import '../../widgets/common/empty_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<StockModel> _searchResults = [];
  bool _isSearching = false;
  
  // Sample stocks for search
  final List<StockModel> _allStocks = [
    StockModel(
      symbol: 'RELIANCE',
      name: 'Reliance Industries Ltd.',
      currentPrice: 2456.75,
      change: 23.45,
      changePercent: 0.96,
      open: 2433.30,
      high: 2478.90,
      low: 2425.10,
      previousClose: 2433.30,
      volume: 5234567,
      halalStatus: 'HALAL_VERIFIED',
    ),
    StockModel(
      symbol: 'TCS',
      name: 'Tata Consultancy Services Ltd.',
      currentPrice: 3678.90,
      change: -12.35,
      changePercent: -0.33,
      open: 3691.25,
      high: 3705.50,
      low: 3665.80,
      previousClose: 3691.25,
      volume: 2345678,
      halalStatus: 'HALAL_VERIFIED',
    ),
    StockModel(
      symbol: 'INFY',
      name: 'Infosys Ltd.',
      currentPrice: 1542.30,
      change: 18.65,
      changePercent: 1.22,
      open: 1523.65,
      high: 1556.40,
      low: 1518.90,
      previousClose: 1523.65,
      volume: 4567890,
      halalStatus: 'HALAL_COMPLIANT',
    ),
    StockModel(
      symbol: 'WIPRO',
      name: 'Wipro Ltd.',
      currentPrice: 445.60,
      change: 5.30,
      changePercent: 1.20,
      open: 440.30,
      high: 448.90,
      low: 438.50,
      previousClose: 440.30,
      volume: 6789012,
      halalStatus: 'HALAL_VERIFIED',
    ),
  ];
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  void _performSearch(String query) {
    setState(() {
      _isSearching = true;
    });
    
    // Simulate API call delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          if (query.isEmpty) {
            _searchResults = [];
          } else {
            _searchResults = _allStocks.where((stock) {
              return stock.symbol.toLowerCase().contains(query.toLowerCase()) ||
                  stock.name.toLowerCase().contains(query.toLowerCase());
            }).toList();
          }
          _isSearching = false;
        });
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryBackground,
        elevation: 0,
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: AppTheme.textPrimary),
          decoration: InputDecoration(
            hintText: 'Search stocks...',
            hintStyle: const TextStyle(color: AppTheme.textSecondary),
            border: InputBorder.none,
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: AppTheme.textSecondary),
                    onPressed: () {
                      _searchController.clear();
                      _performSearch('');
                    },
                  )
                : null,
          ),
          onChanged: _performSearch,
        ),
      ),
      body: _buildBody(),
    );
  }
  
  Widget _buildBody() {
    if (_isSearching) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppTheme.accentGreen,
        ),
      );
    }
    
    if (_searchController.text.isEmpty) {
      return const EmptyState(
        icon: Icons.search,
        title: 'Search Stocks',
        message: 'Search for stocks by symbol or company name',
      );
    }
    
    if (_searchResults.isEmpty) {
      return const EmptyState(
        icon: Icons.search_off,
        title: 'No Results',
        message: 'No stocks found matching your search',
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return StockCard(
          stock: _searchResults[index],
          onTap: () {
            Navigator.pop(context);
            // Navigate to stock detail
          },
        );
      },
    );
  }
}
