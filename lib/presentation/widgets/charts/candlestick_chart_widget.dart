import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/candlestick_model.dart';

class CandlestickChartWidget extends StatelessWidget {
  final List<CandlestickModel> candles;
  final double height;
  
  const CandlestickChartWidget({
    super.key,
    required this.candles,
    this.height = 300,
  });
  
  @override
  Widget build(BuildContext context) {
    if (candles.isEmpty) {
      return SizedBox(
        height: height,
        child: const Center(
          child: Text(
            'No data available',
            style: TextStyle(color: AppTheme.textSecondary),
          ),
        ),
      );
    }
    
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LineChart(
          _buildChartData(),
          duration: const Duration(milliseconds: 150),
          curve: Curves.linear,
        ),
      ),
    );
  }
  
  LineChartData _buildChartData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppTheme.dividerColor.withOpacity(0.3),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: AppTheme.dividerColor.withOpacity(0.3),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index >= 0 && index < candles.length) {
                final time = candles[index].time;
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    '${time.hour}:${time.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 10,
                    ),
                  ),
                );
              }
              return const Text('');
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 42,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toStringAsFixed(0),
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 10,
                ),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: AppTheme.dividerColor.withOpacity(0.3),
        ),
      ),
      minX: 0,
      maxX: (candles.length - 1).toDouble(),
      minY: _getMinPrice() * 0.99,
      maxY: _getMaxPrice() * 1.01,
      lineBarsData: [
        LineChartBarData(
          spots: _getSpots(),
          isCurved: true,
          gradient: const LinearGradient(
            colors: [AppTheme.accentGreen, AppTheme.chartBlue],
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                AppTheme.accentGreen.withOpacity(0.2),
                AppTheme.chartBlue.withOpacity(0.0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: AppTheme.cardBackground,
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              final index = spot.x.toInt();
              if (index >= 0 && index < candles.length) {
                final candle = candles[index];
                return LineTooltipItem(
                  'O: ${candle.open.toStringAsFixed(2)}\n'
                  'H: ${candle.high.toStringAsFixed(2)}\n'
                  'L: ${candle.low.toStringAsFixed(2)}\n'
                  'C: ${candle.close.toStringAsFixed(2)}',
                  const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 12,
                  ),
                );
              }
              return null;
            }).toList();
          },
        ),
      ),
    );
  }
  
  List<FlSpot> _getSpots() {
    return candles
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value.close))
        .toList();
  }
  
  double _getMinPrice() {
    return candles.map((c) => c.low).reduce((a, b) => a < b ? a : b);
  }
  
  double _getMaxPrice() {
    return candles.map((c) => c.high).reduce((a, b) => a > b ? a : b);
  }
}
