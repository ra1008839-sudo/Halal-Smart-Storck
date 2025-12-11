import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/utils/formatters.dart';

class IndexCard extends StatelessWidget {
  final String name;
  final double value;
  final double change;
  final double changePercent;

  const IndexCard({
    super.key,
    required this.name,
    required this.value,
    required this.change,
    required this.changePercent,
  });

  @override
  Widget build(BuildContext context) {
    final isGaining = change > 0;
    final changeColor = isGaining ? ColorConstants.accentGreen : ColorConstants.accentRed;

    return Card(
      color: ColorConstants.backgroundSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Index Name
            Text(
              name,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ColorConstants.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            
            // Index Value
            Text(
              Formatters.formatNumber(value),
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorConstants.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            
            // Change
            Row(
              children: [
                Icon(
                  isGaining ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 14,
                  color: changeColor,
                ),
                const SizedBox(width: 4),
                Text(
                  '${Formatters.formatNumber(change.abs())} (${Formatters.formatPercentage(changePercent, includeSign: false)})',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: changeColor,
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
