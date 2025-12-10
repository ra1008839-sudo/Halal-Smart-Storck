import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

enum SignalType {
  strongBuy,
  buy,
  hold,
  sell,
  strongSell,
}

class SignalBadge extends StatelessWidget {
  final SignalType signal;
  final double size;
  
  const SignalBadge({
    super.key,
    required this.signal,
    this.size = 80,
  });
  
  @override
  Widget build(BuildContext context) {
    final config = _getSignalConfig();
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: config['gradient'] as Gradient,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: (config['color'] as Color).withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            config['icon'] as IconData,
            color: Colors.white,
            size: size * 0.35,
          ),
          SizedBox(height: size * 0.05),
          Text(
            config['label'] as String,
            style: TextStyle(
              fontSize: size * 0.15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
  
  Map<String, dynamic> _getSignalConfig() {
    switch (signal) {
      case SignalType.strongBuy:
        return {
          'label': 'STRONG BUY',
          'color': const Color(0xFF00C853),
          'gradient': const LinearGradient(
            colors: [Color(0xFF00C853), Color(0xFF00B248)],
          ),
          'icon': Icons.trending_up,
        };
      case SignalType.buy:
        return {
          'label': 'BUY',
          'color': AppTheme.accentGreen,
          'gradient': AppTheme.greenGradient,
          'icon': Icons.arrow_upward,
        };
      case SignalType.hold:
        return {
          'label': 'HOLD',
          'color': AppTheme.chartOrange,
          'gradient': AppTheme.orangeGradient,
          'icon': Icons.remove,
        };
      case SignalType.sell:
        return {
          'label': 'SELL',
          'color': AppTheme.accentRed,
          'gradient': AppTheme.redGradient,
          'icon': Icons.arrow_downward,
        };
      case SignalType.strongSell:
        return {
          'label': 'STRONG SELL',
          'color': const Color(0xFFD32F2F),
          'gradient': const LinearGradient(
            colors: [Color(0xFFD32F2F), Color(0xFFB71C1C)],
          ),
          'icon': Icons.trending_down,
        };
    }
  }
}
