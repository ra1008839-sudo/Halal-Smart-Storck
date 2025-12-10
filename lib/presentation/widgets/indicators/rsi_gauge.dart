import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class RSIGauge extends StatelessWidget {
  final double rsi;
  final double size;
  
  const RSIGauge({
    super.key,
    required this.rsi,
    this.size = 150,
  });
  
  @override
  Widget build(BuildContext context) {
    final rsiClamped = rsi.clamp(0.0, 100.0);
    final color = _getRSIColor(rsiClamped);
    final status = _getRSIStatus(rsiClamped);
    
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Label
          const Text(
            'RSI',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          
          // Gauge
          SizedBox(
            width: size * 0.6,
            height: size * 0.6,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background Circle
                CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: 8,
                  color: AppTheme.dividerColor,
                ),
                
                // Progress Circle
                CircularProgressIndicator(
                  value: rsiClamped / 100,
                  strokeWidth: 8,
                  color: color,
                ),
                
                // Value Text
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      rsiClamped.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: size * 0.15,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: size * 0.08,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          
          // Reference Lines
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildReferencePoint('30', 'Oversold', AppTheme.accentGreen),
              _buildReferencePoint('70', 'Overbought', AppTheme.accentRed),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildReferencePoint(String value, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 8,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }
  
  Color _getRSIColor(double rsi) {
    if (rsi >= 70) {
      return AppTheme.accentRed; // Overbought
    } else if (rsi <= 30) {
      return AppTheme.accentGreen; // Oversold
    } else {
      return AppTheme.chartOrange; // Neutral
    }
  }
  
  String _getRSIStatus(double rsi) {
    if (rsi >= 70) {
      return 'Overbought';
    } else if (rsi <= 30) {
      return 'Oversold';
    } else {
      return 'Neutral';
    }
  }
}
