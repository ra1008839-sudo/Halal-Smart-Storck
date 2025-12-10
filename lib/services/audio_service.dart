import 'package:audioplayers/audioplayers.dart';
import '../core/constants/app_constants.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  
  final AudioPlayer _player = AudioPlayer();
  bool _soundEnabled = true;
  
  AudioService._internal();
  
  // Enable/disable sound
  void setSoundEnabled(bool enabled) {
    _soundEnabled = enabled;
  }
  
  // Play buy sound
  Future<void> playBuySound() async {
    if (_soundEnabled) {
      try {
        await _player.play(AssetSource(AppConstants.buySoundPath.replaceAll('assets/', '')));
      } catch (e) {
        // Silently fail if sound file not found
      }
    }
  }
  
  // Play sell sound
  Future<void> playSellSound() async {
    if (_soundEnabled) {
      try {
        await _player.play(AssetSource(AppConstants.sellSoundPath.replaceAll('assets/', '')));
      } catch (e) {
        // Silently fail if sound file not found
      }
    }
  }
  
  // Play notification sound
  Future<void> playNotificationSound() async {
    if (_soundEnabled) {
      try {
        await _player.play(AssetSource(AppConstants.notificationSoundPath.replaceAll('assets/', '')));
      } catch (e) {
        // Silently fail if sound file not found
      }
    }
  }
  
  // Stop current sound
  Future<void> stop() async {
    await _player.stop();
  }
  
  // Dispose
  void dispose() {
    _player.dispose();
  }
}
