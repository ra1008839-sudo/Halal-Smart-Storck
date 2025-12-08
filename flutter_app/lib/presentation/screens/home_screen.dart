import 'package:flutter/material.dart';
import '../../config/theme_config.dart';
import '../widgets/stock_card.dart';
import '../widgets/fii_dii_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const StocksTab(),
    const FuturesOptionsTab(),
    const MutualFundsTab(),
    const UPITab(),
    const LoansTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.primaryBackground,
      appBar: AppBar(
        title: const Text('Halal Smart Stock'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Navigate to search
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Navigate to notifications
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: ThemeConfig.cardBackground,
        selectedItemColor: ThemeConfig.accentGreen,
        unselectedItemColor: ThemeConfig.textSecondary,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Stocks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'F&O',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Mutual Funds',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'UPI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'Loans',
          ),
        ],
      ),
    );
  }
}

/// Stocks Tab
class StocksTab extends StatelessWidget {
  const StocksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // FII/DII Banner
        const FIIDIIBanner(),
        const SizedBox(height: 16),
        
        // Market Status
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ThemeConfig.cardBackground,
            borderRadius: BorderRadius.circular(ThemeConfig.radiusL),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Market Status',
                style: ThemeConfig.heading3,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: ThemeConfig.accentGreen.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(ThemeConfig.radiusM),
                ),
                child: const Text(
                  'OPEN',
                  style: TextStyle(
                    color: ThemeConfig.accentGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        
        // Top Gainers Section
        const Text(
          'Top Gainers',
          style: ThemeConfig.heading3,
        ),
        const SizedBox(height: 12),
        const StockCard(
          symbol: 'TCS',
          name: 'Tata Consultancy Services',
          currentPrice: 3450.50,
          changePercent: 2.45,
          isHalal: true,
        ),
        const SizedBox(height: 8),
        const StockCard(
          symbol: 'INFY',
          name: 'Infosys Limited',
          currentPrice: 1523.75,
          changePercent: 1.89,
          isHalal: true,
        ),
        const SizedBox(height: 16),
        
        // Top Losers Section
        const Text(
          'Top Losers',
          style: ThemeConfig.heading3,
        ),
        const SizedBox(height: 12),
        const StockCard(
          symbol: 'TATAMOTORS',
          name: 'Tata Motors',
          currentPrice: 645.30,
          changePercent: -1.25,
          isHalal: true,
        ),
        const SizedBox(height: 16),
        
        // Most Traded Section
        const Text(
          'Most Traded',
          style: ThemeConfig.heading3,
        ),
        const SizedBox(height: 12),
        const StockCard(
          symbol: 'RELIANCE',
          name: 'Reliance Industries',
          currentPrice: 2456.80,
          changePercent: 0.75,
          isHalal: true,
        ),
      ],
    );
  }
}

/// Futures & Options Tab
class FuturesOptionsTab extends StatelessWidget {
  const FuturesOptionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Futures & Options',
        style: ThemeConfig.heading2,
      ),
    );
  }
}

/// Mutual Funds Tab
class MutualFundsTab extends StatelessWidget {
  const MutualFundsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Mutual Funds',
        style: ThemeConfig.heading2,
      ),
    );
  }
}

/// UPI Tab
class UPITab extends StatelessWidget {
  const UPITab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Wallet Balance
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: ThemeConfig.greenGradient,
            borderRadius: BorderRadius.circular(ThemeConfig.radiusL),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Wallet Balance',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '₹1,00,000.00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: ThemeConfig.accentGreen,
                ),
                child: const Text('Add Money'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        
        // Quick Add Amounts
        const Text(
          'Quick Add',
          style: ThemeConfig.heading3,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _QuickAddButton(amount: 7500),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _QuickAddButton(amount: 20000),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _QuickAddButton(amount: 50000),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickAddButton extends StatelessWidget {
  final int amount;
  
  const _QuickAddButton({required this.amount});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: ThemeConfig.accentGreen),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text(
        '₹${amount.toString()}',
        style: const TextStyle(color: ThemeConfig.accentGreen),
      ),
    );
  }
}

/// Loans Tab
class LoansTab extends StatelessWidget {
  const LoansTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Loans',
        style: ThemeConfig.heading2,
      ),
    );
  }
}
