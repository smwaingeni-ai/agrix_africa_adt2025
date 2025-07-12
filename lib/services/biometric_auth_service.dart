import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class BiometricAuthService {
  static final LocalAuthentication _auth = LocalAuthentication();

  /// 🔹 Check if biometrics are available (fingerprint/face ID)
  static Future<bool> canCheckBiometrics() async {
    try {
      return await _auth.canCheckBiometrics && await _auth.isDeviceSupported();
    } on PlatformException catch (e) {
      print('❌ Error checking biometrics: $e');
      return false;
    }
  }

  /// 🔹 Authenticate using biometrics
  static Future<bool> authenticate() async {
    try {
      final isAvailable = await canCheckBiometrics();
      if (!isAvailable) {
        print('⚠️ Biometrics not available');
        return false;
      }

      return await _auth.authenticate(
        localizedReason: 'Please authenticate to access AgriX',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      print('❌ Biometric authentication failed: $e');
      return false;
    }
  }
}
