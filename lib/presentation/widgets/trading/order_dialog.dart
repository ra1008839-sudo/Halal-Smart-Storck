import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/stock_model.dart';
import '../common/gradient_button.dart';

class OrderDialog extends StatefulWidget {
  final StockModel stock;
  final bool isBuy;
  
  const OrderDialog({
    super.key,
    required this.stock,
    required this.isBuy,
  });
  
  @override
  State<OrderDialog> createState() => _OrderDialogState();
}

class _OrderDialogState extends State<OrderDialog> {
  final _quantityController = TextEditingController(text: '1');
  final _priceController = TextEditingController();
  String _orderType = 'Market';
  double _stopLoss = 0.0;
  
  @override
  void initState() {
    super.initState();
    _priceController.text = widget.stock.currentPrice.toStringAsFixed(2);
  }
  
  @override
  void dispose() {
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }
  
  double get _totalValue {
    final qty = int.tryParse(_quantityController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0;
    return qty * price;
  }
  
  @override
  Widget build(BuildContext context) {
    final color = widget.isBuy ? AppTheme.accentGreen : AppTheme.accentRed;
    final gradient = widget.isBuy ? AppTheme.greenGradient : AppTheme.redGradient;
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.isBuy ? 'BUY' : 'SELL'} ${widget.stock.symbol}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: AppTheme.textSecondary),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.stock.name,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          
          // Order Type Selector
          Row(
            children: [
              _buildOrderTypeChip('Market'),
              const SizedBox(width: 8),
              _buildOrderTypeChip('Limit'),
              const SizedBox(width: 8),
              _buildOrderTypeChip('Stop Loss'),
            ],
          ),
          const SizedBox(height: 24),
          
          // Quantity
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quantity',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppTheme.primaryBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Price',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      enabled: _orderType != 'Market',
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppTheme.primaryBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Total Value
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Value',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.textSecondary,
                  ),
                ),
                Text(
                  '₹${_totalValue.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Place Order Button
          GradientButton(
            text: '${widget.isBuy ? 'BUY' : 'SELL'} ${widget.stock.symbol}',
            onPressed: () {
              // Handle order placement
              Navigator.pop(context, {
                'quantity': int.tryParse(_quantityController.text) ?? 0,
                'price': double.tryParse(_priceController.text) ?? 0,
                'orderType': _orderType,
              });
            },
            gradient: gradient,
          ),
        ],
      ),
    );
  }
  
  Widget _buildOrderTypeChip(String type) {
    final isSelected = _orderType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _orderType = type;
          if (type == 'Market') {
            _priceController.text = widget.stock.currentPrice.toStringAsFixed(2);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.accentGreen.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.accentGreen : AppTheme.dividerColor,
          ),
        ),
        child: Text(
          type,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? AppTheme.accentGreen : AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}

// Helper function to show the dialog
Future<Map<String, dynamic>?> showOrderDialog(
  BuildContext context,
  StockModel stock,
  bool isBuy,
) {
  return showModalBottomSheet<Map<String, dynamic>>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => OrderDialog(
      stock: stock,
      isBuy: isBuy,
    ),
  );
}
