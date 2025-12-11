import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          currentIndex: currentIndex,
          onTap: onTap,
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
    );
  }
}
