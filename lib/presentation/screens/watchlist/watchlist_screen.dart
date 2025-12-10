import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/stock_model.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/cards/stock_card.dart';
import '../../widgets/common/empty_state.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});
  
  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  // Sample watchlist data
  final List<StockModel> _watchlistStocks = [
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
      appBar: CustomAppBar(
        title: 'Watchlist',
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppTheme.textPrimary),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
        ],
      ),
      body: _watchlistStocks.isEmpty
          ? EmptyState(
              icon: Icons.bookmark_border,
              title: 'No Watchlist',
              message: 'Add stocks to your watchlist to track them',
              actionText: 'Add Stocks',
              onActionPressed: () {
                Navigator.pushNamed(context, '/search');
              },
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _watchlistStocks.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_watchlistStocks[index].symbol),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: AppTheme.accentRed,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      _watchlistStocks.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Stock removed from watchlist'),
                        backgroundColor: AppTheme.accentRed,
                      ),
                    );
                  },
                  child: StockCard(
                    stock: _watchlistStocks[index],
                    onTap: () {
                      // Navigate to stock detail
                    },
                  ),
                );
              },
            ),
    );
  }
}
