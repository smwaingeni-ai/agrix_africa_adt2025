import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PinAuthService {
  static const _storage = FlutterSecureStorage();
  static const _pinKey = 'agrix_user_pin';

  /// Save the user PIN securely
  static Future<void> savePin(String pin) async {
    try {
      await _storage.write(key: _pinKey, value: pin);
    } catch (e) {
      print('Error saving PIN: $e');
    }
  }

  /// Validate the entered PIN against the stored one
  static Future<bool> validatePin(String enteredPin) async {
    try {
      final storedPin = await _storage.read(key: _pinKey);
      return storedPin == enteredPin;
    } catch (e) {
      print('Error reading PIN: $e');
      return false;
    }
  }

  /// Clear the saved PIN
  static Future<void> clearPin() async {
    try {
      await _storage.delete(key: _pinKey);
    } catch (e) {
      print('Error clearing PIN: $e');
    }
  }

  /// Check if a PIN is already set
  static Future<bool> isPinSet() async {
    try {
      final storedPin = await _storage.read(key: _pinKey);
      return storedPin != null;
    } catch (e) {
      print('Error checking if PIN is set: $e');
      return false;
    }
  }
}
