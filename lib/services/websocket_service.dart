import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../core/constants/app_constants.dart';

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;
  
  WebSocketChannel? _channel;
  final StreamController<Map<String, dynamic>> _dataController = 
      StreamController<Map<String, dynamic>>.broadcast();
  
  bool _isConnected = false;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 5;
  
  WebSocketService._internal();
  
  Stream<Map<String, dynamic>> get dataStream => _dataController.stream;
  bool get isConnected => _isConnected;
  
  // Connect to WebSocket server
  Future<void> connect() async {
    if (_isConnected) return;
    
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse(AppConstants.wsUrl),
      );
      
      _isConnected = true;
      _reconnectAttempts = 0;
      
      // Listen to messages
      _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDone,
      );
    } catch (e) {
      _isConnected = false;
      _scheduleReconnect();
    }
  }
  
  // Send message to server
  void send(Map<String, dynamic> message) {
    if (_isConnected && _channel != null) {
      _channel!.sink.add(jsonEncode(message));
    }
  }
  
  // Subscribe to stock updates
  void subscribeToStock(String symbol) {
    send({
      'action': 'subscribe',
      'symbol': symbol,
    });
  }
  
  // Unsubscribe from stock updates
  void unsubscribeFromStock(String symbol) {
    send({
      'action': 'unsubscribe',
      'symbol': symbol,
    });
  }
  
  // Subscribe to multiple stocks
  void subscribeToStocks(List<String> symbols) {
    send({
      'action': 'subscribe_multiple',
      'symbols': symbols,
    });
  }
  
  // Disconnect from server
  Future<void> disconnect() async {
    _isConnected = false;
    _reconnectTimer?.cancel();
    await _channel?.sink.close();
    _channel = null;
  }
  
  // Handle incoming messages
  void _onMessage(dynamic message) {
    try {
      final data = jsonDecode(message);
      _dataController.add(data);
    } catch (e) {
      // Invalid message format
    }
  }
  
  // Handle errors
  void _onError(error) {
    _isConnected = false;
    _scheduleReconnect();
  }
  
  // Handle connection close
  void _onDone() {
    _isConnected = false;
    _scheduleReconnect();
  }
  
  // Schedule reconnection attempt
  void _scheduleReconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      return;
    }
    
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(
      Duration(seconds: 2 * (_reconnectAttempts + 1)),
      () {
        _reconnectAttempts++;
        connect();
      },
    );
  }
  
  // Dispose resources
  void dispose() {
    _reconnectTimer?.cancel();
    _channel?.sink.close();
    _dataController.close();
  }
}
