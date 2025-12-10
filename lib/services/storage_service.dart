import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageService {
  static StorageService? _instance;
  static SharedPreferences? _preferences;
  
  StorageService._();
  
  static Future<StorageService> getInstance() async {
    _instance ??= StorageService._();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }
  
  // Save string
  Future<bool> saveString(String key, String value) async {
    return await _preferences!.setString(key, value);
  }
  
  // Get string
  String? getString(String key) {
    return _preferences!.getString(key);
  }
  
  // Save int
  Future<bool> saveInt(String key, int value) async {
    return await _preferences!.setInt(key, value);
  }
  
  // Get int
  int? getInt(String key) {
    return _preferences!.getInt(key);
  }
  
  // Save bool
  Future<bool> saveBool(String key, bool value) async {
    return await _preferences!.setBool(key, value);
  }
  
  // Get bool
  bool? getBool(String key) {
    return _preferences!.getBool(key);
  }
  
  // Save double
  Future<bool> saveDouble(String key, double value) async {
    return await _preferences!.setDouble(key, value);
  }
  
  // Get double
  double? getDouble(String key) {
    return _preferences!.getDouble(key);
  }
  
  // Save object as JSON
  Future<bool> saveObject(String key, Map<String, dynamic> value) async {
    return await _preferences!.setString(key, jsonEncode(value));
  }
  
  // Get object from JSON
  Map<String, dynamic>? getObject(String key) {
    final jsonString = _preferences!.getString(key);
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }
  
  // Remove key
  Future<bool> remove(String key) async {
    return await _preferences!.remove(key);
  }
  
  // Clear all
  Future<bool> clear() async {
    return await _preferences!.clear();
  }
  
  // Check if key exists
  bool containsKey(String key) {
    return _preferences!.containsKey(key);
  }
}
