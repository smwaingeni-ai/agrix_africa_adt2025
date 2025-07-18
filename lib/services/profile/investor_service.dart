import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:path_provider/path_provider.dart';
import 'package:agrix_africa_adt2025/models/investments/investor_profile.dart';

class InvestorService {
  static const String _fileName = 'investor_profiles_encrypted.json';

  // AES encryption setup
  final _key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows!'); // 32-byte key
  final _iv = encrypt.IV.fromLength(16); // 16-byte IV

  encrypt.Encrypter get _encrypter => encrypt.Encrypter(encrypt.AES(_key));

  /// Get secure file path
  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$_fileName';
  }

  /// Save list of investor profiles (encrypted)
  Future<void> saveEncrypted(List<InvestorProfile> profiles) async {
    try {
      final plainText = InvestorProfile.encode(profiles);
      final encrypted = _encrypter.encrypt(plainText, iv: _iv).base64;
      final file = File(await _getFilePath());
      await file.writeAsString(encrypted);
      debugPrint('✅ Investor profiles encrypted and saved.');
    } catch (e) {
      debugPrint('❌ Error saving encrypted investors: $e');
    }
  }

  /// Load and decrypt investor profiles
  Future<List<InvestorProfile>> loadEncrypted() async {
    try {
      final file = File(await _getFilePath());
      if (!await file.exists()) return [];

      final encryptedText = await file.readAsString();
      final decryptedText = _encrypter.decrypt64(encryptedText, iv: _iv);
      return InvestorProfile.decode(decryptedText);
    } catch (e) {
      debugPrint('❌ Failed to decrypt investor data: $e');
      return [];
    }
  }

  /// Public method to load all investors
  Future<List<InvestorProfile>> loadInvestors() async {
    return await loadEncrypted();
  }

  /// Add a new investor profile
  Future<void> addInvestor(InvestorProfile investor) async {
    final investors = await loadEncrypted();
    investors.add(investor);
    await saveEncrypted(investors);
  }

  /// Remove investor by ID
  Future<void> removeInvestor(String id) async {
    final investors = await loadEncrypted();
    investors.removeWhere((i) => i.id == id);
    await saveEncrypted(investors);
  }

  /// Fetch an investor by ID
  Future<InvestorProfile> getInvestorById(String id) async {
    final investors = await loadEncrypted();
    return investors.firstWhere(
      (i) => i.id == id,
      orElse: () => InvestorProfile.empty(),
    );
  }

  /// Save or update an investor profile
  Future<void> saveInvestorProfile(InvestorProfile profile) async {
    final investors = await loadEncrypted();
    final index = investors.indexWhere((i) => i.id == profile.id);
    if (index != -1) {
      investors[index] = profile;
    } else {
      investors.add(profile);
    }
    await saveEncrypted(investors);
  }

  /// Aliased save method (for consistent external use)
  Future<void> saveInvestor(InvestorProfile investor) async {
    await saveInvestorProfile(investor);
  }
}
