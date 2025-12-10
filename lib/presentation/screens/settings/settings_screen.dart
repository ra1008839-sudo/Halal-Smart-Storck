import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/common/custom_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _biometricEnabled = false;
  bool _priceAlertsEnabled = true;
  bool _newsAlertsEnabled = true;
  
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      appBar: const CustomAppBar(title: 'Settings'),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          
          // Appearance Section
          _buildSectionHeader('Appearance'),
          _buildSwitchTile(
            'Dark Mode',
            'Use dark theme',
            themeProvider.isDarkMode,
            (value) {
              themeProvider.toggleTheme();
            },
            Icons.dark_mode,
          ),
          
          // Notifications Section
          _buildSectionHeader('Notifications'),
          _buildSwitchTile(
            'Push Notifications',
            'Receive push notifications',
            _notificationsEnabled,
            (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            Icons.notifications,
          ),
          _buildSwitchTile(
            'Price Alerts',
            'Get notified about price changes',
            _priceAlertsEnabled,
            (value) {
              setState(() {
                _priceAlertsEnabled = value;
              });
            },
            Icons.trending_up,
          ),
          _buildSwitchTile(
            'News Alerts',
            'Get notified about news',
            _newsAlertsEnabled,
            (value) {
              setState(() {
                _newsAlertsEnabled = value;
              });
            },
            Icons.article,
          ),
          
          // Security Section
          _buildSectionHeader('Security'),
          _buildSwitchTile(
            'Biometric Login',
            'Use fingerprint/face to login',
            _biometricEnabled,
            (value) {
              setState(() {
                _biometricEnabled = value;
              });
            },
            Icons.fingerprint,
          ),
          _buildListTile(
            'Change PIN',
            'Update your security PIN',
            Icons.pin,
            () {},
          ),
          
          // Audio Section
          _buildSectionHeader('Audio'),
          _buildSwitchTile(
            'Sound Effects',
            'Play sounds for trades',
            _soundEnabled,
            (value) {
              setState(() {
                _soundEnabled = value;
              });
            },
            Icons.volume_up,
          ),
          
          // Data Section
          _buildSectionHeader('Data & Storage'),
          _buildListTile(
            'Clear Cache',
            'Free up storage space',
            Icons.cleaning_services,
            () {
              _showClearCacheDialog(context);
            },
          ),
          
          // Legal Section
          _buildSectionHeader('Legal'),
          _buildListTile(
            'Privacy Policy',
            'Read our privacy policy',
            Icons.privacy_tip,
            () {},
          ),
          _buildListTile(
            'Terms of Service',
            'Read our terms',
            Icons.description,
            () {},
          ),
          
          // App Info
          _buildSectionHeader('About'),
          _buildInfoTile('Version', '1.0.0'),
          _buildInfoTile('Build', '1'),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }
  
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppTheme.accentGreen,
        ),
      ),
    );
  }
  
  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.textSecondary),
      title: Text(
        title,
        style: const TextStyle(color: AppTheme.textPrimary),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: AppTheme.textSecondary,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.accentGreen,
      ),
    );
  }
  
  Widget _buildListTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.textSecondary),
      title: Text(
        title,
        style: const TextStyle(color: AppTheme.textPrimary),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: AppTheme.textSecondary,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppTheme.textSecondary,
      ),
      onTap: onTap,
    );
  }
  
  Widget _buildInfoTile(String title, String value) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: AppTheme.textPrimary),
      ),
      trailing: Text(
        value,
        style: const TextStyle(
          color: AppTheme.textSecondary,
        ),
      ),
    );
  }
  
  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        title: const Text(
          'Clear Cache',
          style: TextStyle(color: AppTheme.textPrimary),
        ),
        content: const Text(
          'This will clear all cached data. Are you sure?',
          style: TextStyle(color: AppTheme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cache cleared successfully'),
                  backgroundColor: AppTheme.accentGreen,
                ),
              );
            },
            child: const Text(
              'Clear',
              style: TextStyle(color: AppTheme.accentRed),
            ),
          ),
        ],
      ),
    );
  }
}
