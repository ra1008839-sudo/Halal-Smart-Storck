import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/portfolio_model.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/cards/holding_card.dart';
import '../../widgets/common/empty_state.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});
  
  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  // Sample portfolio data
  final PortfolioModel _portfolio = PortfolioModel(
    userId: 'user123',
    totalInvestment: 100000,
    currentValue: 112500,
    totalPnL: 12500,
    totalPnLPercent: 12.5,
    lastUpdated: DateTime.now(),
    holdings: [
      HoldingModel(
        symbol: 'RELIANCE',
        name: 'Reliance Industries Ltd.',
        quantity: 10,
        avgPrice: 2400,
        currentPrice: 2456.75,
        investedValue: 24000,
        currentValue: 24567.5,
        pnl: 567.5,
        pnlPercent: 2.36,
        purchaseDate: DateTime.now().subtract(const Duration(days: 30)),
      ),
      HoldingModel(
        symbol: 'TCS',
        name: 'Tata Consultancy Services Ltd.',
        quantity: 5,
        avgPrice: 3700,
        currentPrice: 3678.90,
        investedValue: 18500,
        currentValue: 18394.5,
        pnl: -105.5,
        pnlPercent: -0.57,
        purchaseDate: DateTime.now().subtract(const Duration(days: 45)),
      ),
      HoldingModel(
        symbol: 'INFY',
        name: 'Infosys Ltd.',
        quantity: 20,
        avgPrice: 1500,
        currentPrice: 1542.30,
        investedValue: 30000,
        currentValue: 30846,
        pnl: 846,
        pnlPercent: 2.82,
        purchaseDate: DateTime.now().subtract(const Duration(days: 60)),
      ),
    ],
  );
  
  @override
  Widget build(BuildContext context) {
    final pnlColor = _portfolio.totalPnL >= 0 ? AppTheme.accentGreen : AppTheme.accentRed;
    
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      appBar: const CustomAppBar(
        title: 'Portfolio',
        showBackButton: false,
      ),
      body: _portfolio.holdings.isEmpty
          ? const EmptyState(
              icon: Icons.pie_chart_outline,
              title: 'No Holdings',
              message: 'Start investing to build your portfolio',
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Portfolio Summary Card
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: _portfolio.totalPnL >= 0
                          ? AppTheme.greenGradient
                          : AppTheme.redGradient,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Value',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '₹${_portfolio.currentValue.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Invested',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '₹${_portfolio.totalInvestment.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  'Total P&L',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${_portfolio.totalPnL >= 0 ? '+' : ''}₹${_portfolio.totalPnL.toStringAsFixed(2)} (${_portfolio.totalPnLPercent.toStringAsFixed(2)}%)',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Holdings Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Holdings',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        Text(
                          '${_portfolio.holdings.length} stocks',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Holdings List
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _portfolio.holdings.length,
                      itemBuilder: (context, index) {
                        return HoldingCard(
                          holding: _portfolio.holdings[index],
                          onTap: () {
                            // Navigate to stock detail
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }
}
