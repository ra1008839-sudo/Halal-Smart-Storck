import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/color_constants.dart';
import '../../providers/stock_provider.dart';
import '../../providers/watchlist_provider.dart';
import '../../widgets/cards/stock_card.dart';
import '../../widgets/cards/index_card.dart';
import '../../widgets/common/loading_shimmer.dart';

class StocksTab extends StatefulWidget {
  const StocksTab({super.key});

  @override
  State<StocksTab> createState() => _StocksTabState();
}

class _StocksTabState extends State<StocksTab> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: ColorConstants.backgroundPrimary,
        elevation: 0,
        title: Text(
          'Stocks',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: ColorConstants.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
            color: ColorConstants.textPrimary,
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {},
            color: ColorConstants.textPrimary,
          ),
        ],
      ),
      body: Consumer2<StockProvider, WatchlistProvider>(
        builder: (context, stockProvider, watchlistProvider, child) {
          if (stockProvider.isLoading) {
            return const LoadingShimmer();
          }

          if (stockProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: ColorConstants.textSecondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    stockProvider.error!,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: ColorConstants.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => stockProvider.refreshStocks(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final stocks = stockProvider.stocks;

          return RefreshIndicator(
            onRefresh: () => stockProvider.refreshStocks(),
            color: ColorConstants.accentGreen,
            child: CustomScrollView(
              slivers: [
                // Search Bar
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) => stockProvider.setSearchQuery(value),
                      style: GoogleFonts.inter(
                        color: ColorConstants.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search stocks...',
                        hintStyle: GoogleFonts.inter(
                          color: ColorConstants.textSecondary,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: ColorConstants.textSecondary,
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  color: ColorConstants.textSecondary,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  stockProvider.setSearchQuery('');
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: ColorConstants.backgroundSecondary,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),

                // Market Indices
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Market Indices',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Row(
                          children: [
                            Expanded(
                              child: IndexCard(
                                name: 'NIFTY 50',
                                value: 21453.50,
                                change: 125.30,
                                changePercent: 0.59,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: IndexCard(
                                name: 'SENSEX',
                                value: 71232.40,
                                change: -45.20,
                                changePercent: -0.06,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),

                // Stocks List Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Halal Stocks (${stocks.length})',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.textPrimary,
                          ),
                        ),
                        TextButton(
                          onPressed: () => stockProvider.clearFilters(),
                          child: Text(
                            'Clear Filters',
                            style: GoogleFonts.inter(
                              color: ColorConstants.accentGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Stocks List
                stocks.isEmpty
                    ? SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: ColorConstants.textSecondary,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No stocks found',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: ColorConstants.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final stock = stocks[index];
                              final isInWatchlist = watchlistProvider.isInWatchlist(stock.symbol);
                              
                              return StockCard(
                                stock: stock,
                                isInWatchlist: isInWatchlist,
                                onTap: () {
                                  // Navigate to stock detail
                                },
                                onWatchlistTap: () {
                                  watchlistProvider.toggleWatchlist(stock);
                                },
                              );
                            },
                            childCount: stocks.length,
                          ),
                        ),
                      ),

                // Bottom Padding
                const SliverToBoxAdapter(
                  child: SizedBox(height: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
