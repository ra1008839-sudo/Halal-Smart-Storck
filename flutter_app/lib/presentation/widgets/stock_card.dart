import 'package:flutter/material.dart';
import '../../config/theme_config.dart';

/// Stock Card Widget - Groww Style
class StockCard extends StatelessWidget {
  final String symbol;
  final String name;
  final double currentPrice;
  final double changePercent;
  final bool isHalal;
  final VoidCallback? onTap;

  const StockCard({
    super.key,
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.changePercent,
    required this.isHalal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPositive = changePercent >= 0;
    final Color changeColor = isPositive ? ThemeConfig.accentGreen : ThemeConfig.accentRed;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ThemeConfig.cardBackground,
          borderRadius: BorderRadius.circular(ThemeConfig.radiusL),
          border: Border.all(
            color: ThemeConfig.borderColor,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Left Side - Stock Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Symbol and Halal Badge
                  Row(
                    children: [
                      Text(
                        symbol,
                        style: const TextStyle(
                          fontFamily: ThemeConfig.fontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ThemeConfig.textPrimary,
                        ),
                      ),
                      if (isHalal) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: ThemeConfig.accentGreen.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'HALAL',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: ThemeConfig.accentGreen,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  
                  // Company Name
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: ThemeConfig.fontFamily,
                      fontSize: 12,
                      color: ThemeConfig.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // Right Side - Price Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Current Price
                Text(
                  '₹${currentPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontFamily: ThemeConfig.fontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ThemeConfig.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                
                // Change Percentage
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: changeColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                        size: 12,
                        color: changeColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${changePercent.abs().toStringAsFixed(2)}%',
                        style: TextStyle(
                          fontFamily: ThemeConfig.fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: changeColor,
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
    );
  }
}
