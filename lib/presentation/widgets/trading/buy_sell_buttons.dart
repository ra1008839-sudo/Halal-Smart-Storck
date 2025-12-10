import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class BuySellButtons extends StatelessWidget {
  final VoidCallback onBuyPressed;
  final VoidCallback onSellPressed;
  final bool isLoading;
  
  const BuySellButtons({
    super.key,
    required this.onBuyPressed,
    required this.onSellPressed,
    this.isLoading = false,
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildButton(
            text: 'BUY',
            gradient: AppTheme.greenGradient,
            onPressed: onBuyPressed,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildButton(
            text: 'SELL',
            gradient: AppTheme.redGradient,
            onPressed: onSellPressed,
          ),
        ),
      ],
    );
  }
  
  Widget _buildButton({
    required String text,
    required Gradient gradient,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
