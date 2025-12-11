import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/stock_model.dart';

class StockCard extends StatelessWidget {
  final StockModel stock;
  final bool isInWatchlist;
  final VoidCallback? onTap;
  final VoidCallback? onWatchlistTap;

  const StockCard({
    super.key,
    required this.stock,
    required this.isInWatchlist,
    this.onTap,
    this.onWatchlistTap,
  });

  @override
  Widget build(BuildContext context) {
    final isGaining = stock.isGaining;
    final changeColor = isGaining ? ColorConstants.accentGreen : ColorConstants.accentRed;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: ColorConstants.backgroundSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Stock Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Symbol
                    Text(
                      stock.symbol,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    
                    // Name
                    Text(
                      stock.name,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: ColorConstants.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    
                    // Sector Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: ColorConstants.accentGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        stock.sector,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: ColorConstants.accentGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Price Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Current Price
                  Text(
                    Formatters.formatCurrency(stock.currentPrice),
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  
                  // Change
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: changeColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isGaining ? Icons.arrow_upward : Icons.arrow_downward,
                          size: 12,
                          color: changeColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          Formatters.formatPercentage(
                            stock.changePercentage,
                            includeSign: false,
                          ),
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: changeColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(width: 8),
              
              // Watchlist Button
              IconButton(
                icon: Icon(
                  isInWatchlist ? Icons.bookmark : Icons.bookmark_border,
                  color: isInWatchlist ? ColorConstants.accentGreen : ColorConstants.textSecondary,
                ),
                onPressed: onWatchlistTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
