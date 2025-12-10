import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/empty_state.dart';

class MFScreen extends StatelessWidget {
  const MFScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryBackground,
        elevation: 0,
        title: const Text(
          'Mutual Funds',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
      ),
      body: const EmptyState(
        icon: Icons.account_balance,
        title: 'Mutual Funds',
        message: 'Start investing in mutual funds for long-term wealth creation',
      ),
    );
  }
}
