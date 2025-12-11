import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';
import 'stocks_tab.dart';
import 'fno_tab.dart';
import 'mutual_funds_tab.dart';
import 'upi_tab.dart';
import 'loans_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const StocksTab(),
    const FnoTab(),
    const MutualFundsTab(),
    const UpiTab(),
    const LoansTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundPrimary,
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ColorConstants.backgroundSecondary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: ColorConstants.backgroundSecondary,
            selectedItemColor: ColorConstants.accentGreen,
            unselectedItemColor: ColorConstants.textSecondary,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.show_chart),
                label: 'Stocks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics_outlined),
                label: 'F&O',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined),
                label: 'Mutual Funds',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payment),
                label: 'UPI',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.credit_card),
                label: 'Loans',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
