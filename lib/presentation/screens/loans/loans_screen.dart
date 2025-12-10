import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/empty_state.dart';

class LoansScreen extends StatelessWidget {
  const LoansScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryBackground,
        elevation: 0,
        title: const Text(
          'Loans',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
      ),
      body: const EmptyState(
        icon: Icons.monetization_on,
        title: 'Loan Products',
        message: 'Get instant loans and credit products at competitive rates',
      ),
    );
  }
}
