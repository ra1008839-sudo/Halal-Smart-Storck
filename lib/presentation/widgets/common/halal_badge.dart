import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class HalalBadge extends StatelessWidget {
  final String status;
  final double size;
  
  const HalalBadge({
    super.key,
    required this.status,
    this.size = 20,
  });
  
  @override
  Widget build(BuildContext context) {
    final isHalal = status == 'HALAL_VERIFIED' || status == 'HALAL_COMPLIANT';
    
    if (!isHalal) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppTheme.accentGreen.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppTheme.accentGreen,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified,
            size: size,
            color: AppTheme.accentGreen,
          ),
          const SizedBox(width: 4),
          Text(
            'HALAL',
            style: TextStyle(
              fontSize: size * 0.6,
              fontWeight: FontWeight.bold,
              color: AppTheme.accentGreen,
            ),
          ),
        ],
      ),
    );
  }
}
