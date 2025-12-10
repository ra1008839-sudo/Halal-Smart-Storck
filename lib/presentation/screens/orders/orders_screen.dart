import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/order_model.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/cards/order_card.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Sample orders
  final List<OrderModel> _pendingOrders = [
    OrderModel(
      id: 'ORD001',
      symbol: 'RELIANCE',
      type: 'BUY',
      orderType: 'Limit',
      quantity: 10,
      price: 2450.00,
      status: 'PENDING',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      userId: 'user123',
    ),
  ];
  
  final List<OrderModel> _executedOrders = [
    OrderModel(
      id: 'ORD002',
      symbol: 'TCS',
      type: 'BUY',
      orderType: 'Market',
      quantity: 5,
      price: 3700.00,
      status: 'EXECUTED',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      executedAt: DateTime.now().subtract(const Duration(days: 2, hours: -1)),
      userId: 'user123',
    ),
    OrderModel(
      id: 'ORD003',
      symbol: 'INFY',
      type: 'SELL',
      orderType: 'Market',
      quantity: 8,
      price: 1520.00,
      status: 'EXECUTED',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      executedAt: DateTime.now().subtract(const Duration(days: 5)),
      userId: 'user123',
    ),
  ];
  
  final List<OrderModel> _cancelledOrders = [];
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      appBar: const CustomAppBar(title: 'Orders'),
      body: Column(
        children: [
          // Tab Bar
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.dividerColor,
                  width: 1,
                ),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppTheme.accentGreen,
              labelColor: AppTheme.accentGreen,
              unselectedLabelColor: AppTheme.textSecondary,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Pending'),
                      if (_pendingOrders.isNotEmpty) ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppTheme.accentGreen,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${_pendingOrders.length}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const Tab(text: 'Executed'),
                const Tab(text: 'Cancelled'),
              ],
            ),
          ),
          
          // Tab View
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrderList(_pendingOrders, 'No pending orders'),
                _buildOrderList(_executedOrders, 'No executed orders'),
                _buildOrderList(_cancelledOrders, 'No cancelled orders'),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildOrderList(List<OrderModel> orders, String emptyMessage) {
    if (orders.isEmpty) {
      return EmptyState(
        icon: Icons.receipt_long_outlined,
        title: 'No Orders',
        message: emptyMessage,
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderCard(
          order: orders[index],
          onTap: () {
            // Show order details
          },
        );
      },
    );
  }
}
