import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/empty_state.dart';

class FnoScreen extends StatelessWidget {
  const FnoScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryBackground,
        elevation: 0,
        title: const Text(
          'F&O',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
      ),
      body: const EmptyState(
        icon: Icons.bar_chart,
        title: 'F&O Trading',
        message: 'Futures & Options trading will be available here',
      ),
    );
  }
}
