import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/stock_model.dart';
import '../../../data/models/candlestick_model.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/halal_badge.dart';
import '../../widgets/trading/buy_sell_buttons.dart';
import '../../widgets/trading/order_dialog.dart';
import '../../widgets/charts/timeframe_selector.dart';
import '../../widgets/charts/candlestick_chart_widget.dart';

class StockDetailScreen extends StatefulWidget {
  final StockModel stock;
  
  const StockDetailScreen({
    super.key,
    required this.stock,
  });
  
  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedTimeframe = '1D';
  
  // Sample candlestick data
  final List<CandlestickModel> _sampleCandles = List.generate(
    20,
    (i) {
      final basePrice = 2456.75;
      final random = (i % 5) * 10;
      return CandlestickModel(
        time: DateTime.now().subtract(Duration(minutes: (20 - i) * 15)),
        open: basePrice + random - 5,
        high: basePrice + random + 10,
        low: basePrice + random - 15,
        close: basePrice + random,
        volume: 100000 + (i * 5000),
      );
    },
  );
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final color = widget.stock.isPositive ? AppTheme.accentGreen : AppTheme.accentRed;
    
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      appBar: CustomAppBar(
        title: widget.stock.symbol,
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border, color: AppTheme.textPrimary),
            onPressed: () {
              // Add to watchlist
            },
          ),
          IconButton(
            icon: const Icon(Icons.share, color: AppTheme.textPrimary),
            onPressed: () {
              // Share stock
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Stock Info Header
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.stock.name,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),
                    if (widget.stock.isHalal)
                      HalalBadge(status: widget.stock.halalStatus),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${widget.stock.currentPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            widget.stock.isPositive
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            size: 14,
                            color: color,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.stock.changePercent.toStringAsFixed(2)}%',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: color,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${widget.stock.isPositive ? '+' : ''}₹${widget.stock.change.toStringAsFixed(2)})',
                            style: TextStyle(
                              fontSize: 12,
                              color: color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Timeframe Selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TimeframeSelector(
              selectedTimeframe: _selectedTimeframe,
              onTimeframeSelected: (timeframe) {
                setState(() {
                  _selectedTimeframe = timeframe;
                });
              },
            ),
          ),
          const SizedBox(height: 16),
          
          // Chart
          CandlestickChartWidget(
            candles: _sampleCandles,
            height: 250,
          ),
          
          // Tab Bar
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.dividerColor,
                  width: 1,
                ),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppTheme.accentGreen,
              labelColor: AppTheme.accentGreen,
              unselectedLabelColor: AppTheme.textSecondary,
              tabs: const [
                Tab(text: 'Summary'),
                Tab(text: 'Fundamentals'),
                Tab(text: 'Technicals'),
                Tab(text: 'News'),
              ],
            ),
          ),
          
          // Tab View
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSummaryTab(),
                _buildFundamentalsTab(),
                _buildTechnicalsTab(),
                _buildNewsTab(),
              ],
            ),
          ),
          
          // Bottom Buy/Sell Buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: BuySellButtons(
              onBuyPressed: () async {
                await showOrderDialog(context, widget.stock, true);
              },
              onSellPressed: () async {
                await showOrderDialog(context, widget.stock, false);
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSummaryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard([
            _buildInfoRow('Open', '₹${widget.stock.open.toStringAsFixed(2)}'),
            _buildInfoRow('High', '₹${widget.stock.high.toStringAsFixed(2)}'),
            _buildInfoRow('Low', '₹${widget.stock.low.toStringAsFixed(2)}'),
            _buildInfoRow('Previous Close', '₹${widget.stock.previousClose.toStringAsFixed(2)}'),
            _buildInfoRow('Volume', '${widget.stock.volume}'),
            _buildInfoRow('Market Cap', _formatMarketCap(widget.stock.marketCap)),
          ]),
        ],
      ),
    );
  }
  
  Widget _buildFundamentalsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard([
            _buildInfoRow('P/E Ratio', widget.stock.pe.toStringAsFixed(2)),
            _buildInfoRow('EPS', '₹${widget.stock.eps.toStringAsFixed(2)}'),
            _buildInfoRow('Sector', widget.stock.sector),
            _buildInfoRow('Exchange', widget.stock.exchange),
            _buildInfoRow('Halal Status', widget.stock.halalStatus),
          ]),
        ],
      ),
    );
  }
  
  Widget _buildTechnicalsTab() {
    return const Center(
      child: Text(
        'Technical Analysis',
        style: TextStyle(color: AppTheme.textSecondary),
      ),
    );
  }
  
  Widget _buildNewsTab() {
    return const Center(
      child: Text(
        'Latest News',
        style: TextStyle(color: AppTheme.textSecondary),
      ),
    );
  }
  
  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: children,
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
  
  String _formatMarketCap(double marketCap) {
    if (marketCap >= 1000000000000) {
      return '₹${(marketCap / 1000000000000).toStringAsFixed(2)}T';
    } else if (marketCap >= 10000000000) {
      return '₹${(marketCap / 10000000000).toStringAsFixed(2)}B';
    } else if (marketCap >= 10000000) {
      return '₹${(marketCap / 10000000).toStringAsFixed(2)}Cr';
    }
    return '₹${marketCap.toStringAsFixed(0)}';
  }
}
