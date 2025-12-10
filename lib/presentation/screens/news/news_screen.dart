import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/cards/news_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});
  
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  // Sample news data
  final List<Map<String, dynamic>> _newsItems = [
    {
      'id': '1',
      'title': 'Reliance Industries announces Q4 results',
      'description': 'Reliance Industries reported strong Q4 earnings with revenue growth of 12% YoY.',
      'imageUrl': 'https://via.placeholder.com/400x200',
      'source': 'Economic Times',
      'publishedAt': DateTime.now().subtract(const Duration(hours: 2)),
      'category': 'Earnings',
    },
    {
      'id': '2',
      'title': 'TCS wins $500M contract from US bank',
      'description': 'Tata Consultancy Services secured a major deal with a leading American financial institution.',
      'imageUrl': 'https://via.placeholder.com/400x200',
      'source': 'Business Standard',
      'publishedAt': DateTime.now().subtract(const Duration(hours: 5)),
      'category': 'Business',
    },
    {
      'id': '3',
      'title': 'Infosys to hire 50,000 freshers this year',
      'description': 'Infosys announced plans to onboard 50,000 fresh graduates in the current fiscal year.',
      'imageUrl': 'https://via.placeholder.com/400x200',
      'source': 'Mint',
      'publishedAt': DateTime.now().subtract(const Duration(hours: 8)),
      'category': 'Jobs',
    },
    {
      'id': '4',
      'title': 'SEBI introduces new regulations for algorithmic trading',
      'description': 'The Securities and Exchange Board of India announced new guidelines for algo trading.',
      'imageUrl': 'https://via.placeholder.com/400x200',
      'source': 'MoneyControl',
      'publishedAt': DateTime.now().subtract(const Duration(days: 1)),
      'category': 'Regulation',
    },
  ];
  
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Earnings',
    'Business',
    'Jobs',
    'Regulation',
    'Market',
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      appBar: const CustomAppBar(title: 'Market News'),
      body: Column(
        children: [
          // Category Filter
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.accentGreen.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.accentGreen
                              : AppTheme.dividerColor,
                        ),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                          color: isSelected
                              ? AppTheme.accentGreen
                              : AppTheme.textSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // News List
          Expanded(
            child: RefreshIndicator(
              color: AppTheme.accentGreen,
              onRefresh: () async {
                // Refresh news
                await Future.delayed(const Duration(seconds: 1));
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _newsItems.length,
                itemBuilder: (context, index) {
                  final news = _newsItems[index];
                  return NewsCard(
                    news: news,
                    onTap: () {
                      // Open news detail
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
