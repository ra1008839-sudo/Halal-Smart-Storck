import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class TimeframeSelector extends StatelessWidget {
  final String selectedTimeframe;
  final Function(String) onTimeframeSelected;
  
  const TimeframeSelector({
    super.key,
    required this.selectedTimeframe,
    required this.onTimeframeSelected,
  });
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppConstants.timeframes.length,
        itemBuilder: (context, index) {
          final timeframe = AppConstants.timeframes[index];
          final isSelected = timeframe == selectedTimeframe;
          
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : 8,
              right: index == AppConstants.timeframes.length - 1 ? 0 : 0,
            ),
            child: GestureDetector(
              onTap: () => onTimeframeSelected(timeframe),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.accentGreen.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? AppTheme.accentGreen : AppTheme.dividerColor,
                  ),
                ),
                child: Center(
                  child: Text(
                    timeframe,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? AppTheme.accentGreen : AppTheme.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
