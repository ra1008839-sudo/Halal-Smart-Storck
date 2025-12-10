import 'package:flutter/material.dart';
import '../../services/storage_service.dart';
import '../../core/constants/app_constants.dart';

class ThemeProvider with ChangeNotifier {
  late final StorageService _storageService;
  ThemeMode _themeMode = ThemeMode.dark;
  
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  
  ThemeProvider() {
    _initializeTheme();
  }
  
  Future<void> _initializeTheme() async {
    _storageService = await StorageService.getInstance();
    final savedTheme = _storageService.getString(AppConstants.themeKey);
    
    if (savedTheme != null) {
      _themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }
  
  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await _storageService.saveString(
      AppConstants.themeKey,
      _themeMode == ThemeMode.dark ? 'dark' : 'light',
    );
    notifyListeners();
  }
  
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _storageService.saveString(
      AppConstants.themeKey,
      mode == ThemeMode.dark ? 'dark' : 'light',
    );
    notifyListeners();
  }
}
