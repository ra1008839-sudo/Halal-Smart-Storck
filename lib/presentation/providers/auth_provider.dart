import 'package:flutter/foundation.dart';
import '../../data/models/user_model.dart';
import '../../services/auth_service.dart';
import '../../services/storage_service.dart';
import '../../core/constants/app_constants.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  late final StorageService _storageService;
  
  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;
  
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;
  
  AuthProvider() {
    _initializeStorage();
    _checkAuthState();
  }
  
  Future<void> _initializeStorage() async {
    _storageService = await StorageService.getInstance();
  }
  
  Future<void> _checkAuthState() async {
    _authService.authStateChanges.listen((firebaseUser) {
      if (firebaseUser != null) {
        _loadUserData(firebaseUser.uid);
      } else {
        _user = null;
        notifyListeners();
      }
    });
  }
  
  Future<void> _loadUserData(String uid) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      final userData = _storageService.getObject(AppConstants.userKey);
      if (userData != null) {
        _user = UserModel.fromJson(userData);
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load user data';
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<bool> signInWithEmail(String email, String password) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      
      _user = await _authService.signInWithEmail(email, password);
      
      if (_user != null) {
        await _storageService.saveObject(AppConstants.userKey, _user!.toJson());
      }
      
      _isLoading = false;
      notifyListeners();
      return _user != null;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  Future<bool> registerWithEmail(String name, String email, String password) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      
      _user = await _authService.registerWithEmail(name, email, password);
      
      if (_user != null) {
        await _storageService.saveObject(AppConstants.userKey, _user!.toJson());
      }
      
      _isLoading = false;
      notifyListeners();
      return _user != null;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  Future<void> signInWithPhone(
    String phoneNumber,
    Function(String verificationId) onCodeSent,
  ) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      
      await _authService.signInWithPhone(
        phoneNumber,
        (verificationId) {
          _isLoading = false;
          notifyListeners();
          onCodeSent(verificationId);
        },
        (error) {
          _errorMessage = error;
          _isLoading = false;
          notifyListeners();
        },
      );
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<bool> verifyOTP(String verificationId, String otp) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      
      _user = await _authService.verifyOTP(verificationId, otp);
      
      if (_user != null) {
        await _storageService.saveObject(AppConstants.userKey, _user!.toJson());
      }
      
      _isLoading = false;
      notifyListeners();
      return _user != null;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      
      await _authService.sendPasswordResetEmail(email);
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  Future<void> signOut() async {
    try {
      await _authService.signOut();
      await _storageService.remove(AppConstants.userKey);
      _user = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
  
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
