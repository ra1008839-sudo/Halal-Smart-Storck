import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _currentUser;
  bool _isAuthenticated = false;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final authToken = prefs.getString('authToken');

    if (userId != null && authToken != null) {
      // In a real app, validate token with backend
      _isAuthenticated = true;
      _currentUser = UserModel(
        id: userId,
        name: 'Demo User',
        email: 'demo@halalsmartstock.com',
        phone: '9876543210',
        createdAt: DateTime.now(),
        isVerified: true,
      );
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Mock successful login
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', 'user_123');
    await prefs.setString('authToken', 'mock_token_123');

    _currentUser = UserModel(
      id: 'user_123',
      name: 'Demo User',
      email: email,
      phone: '9876543210',
      createdAt: DateTime.now(),
      isVerified: true,
    );

    _isAuthenticated = true;
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> register(String name, String email, String phone, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Mock successful registration
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', 'user_123');
    await prefs.setString('authToken', 'mock_token_123');

    _currentUser = UserModel(
      id: 'user_123',
      name: name,
      email: email,
      phone: phone,
      createdAt: DateTime.now(),
      isVerified: false,
    );

    _isAuthenticated = true;
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('authToken');

    _currentUser = null;
    _isAuthenticated = false;
    _isLoading = false;
    notifyListeners();
  }

  void updateUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }
}
