import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/stock_model.dart';
import '../../widgets/cards/stock_card.dart';
import '../../widgets/common/loading_shimmer.dart';

class StockListScreen extends StatefulWidget {
  const StockListScreen({super.key});
  
  @override
  State<StockListScreen> createState() => _StockListScreenState();
}

class _StockListScreenState extends State<StockListScreen> {
  bool _isLoading = false;
  
  // Sample data - Replace with actual API call
  final List<StockModel> _stocks = [
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
      symbol: 'HDFCBANK',
      name: 'HDFC Bank Ltd.',
      currentPrice: 1678.45,
      change: -8.90,
      changePercent: -0.53,
      open: 1687.35,
      high: 1695.20,
      low: 1672.10,
      previousClose: 1687.35,
      volume: 3456789,
      halalStatus: 'NON_HALAL',
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryBackground,
        elevation: 0,
        title: const Text(
          'Stocks',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppTheme.textPrimary),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: AppTheme.textPrimary),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Indices Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: _buildIndexCard(
                    'NIFTY 50',
                    '19,234.50',
                    '+123.45',
                    '+0.65%',
                    true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildIndexCard(
                    'SENSEX',
                    '64,567.80',
                    '-45.30',
                    '-0.07%',
                    false,
                  ),
                ),
              ],
            ),
          ),
          
          // Tabs
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildTab('All', true),
                const SizedBox(width: 16),
                _buildTab('Halal', false),
                const SizedBox(width: 16),
                _buildTab('Watchlist', false),
                const SizedBox(width: 16),
                _buildTab('Gainers', false),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Stock List
          Expanded(
            child: _isLoading
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const StockCardShimmer();
                    },
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _stocks.length,
                    itemBuilder: (context, index) {
                      return StockCard(
                        stock: _stocks[index],
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/stock-detail',
                            arguments: _stocks[index],
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildIndexCard(
    String name,
    String value,
    String change,
    String changePercent,
    bool isPositive,
  ) {
    final color = isPositive ? AppTheme.accentGreen : AppTheme.accentRed;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                change,
                style: TextStyle(
                  fontSize: 11,
                  color: color,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                changePercent,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildTab(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // Handle tab selection
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.accentGreen.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.accentGreen : AppTheme.dividerColor,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? AppTheme.accentGreen : AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}
