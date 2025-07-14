import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:path_provider/path_provider.dart';
import 'package:agrix_africa_adt2025/models/investor_profile.dart';

class InvestorService {
  static const String _fileName = 'investor_profiles_encrypted.json';

  // AES key must be 32 chars
  final _key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows!');
  final _iv = encrypt.IV.fromLength(16); // 128-bit IV

  encrypt.Encrypter get _encrypter => encrypt.Encrypter(encrypt.AES(_key));

  /// 🔹 Internal helper to get secure file path
  Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/$_fileName';
  }

  /// 🔐 Save encrypted investor list to local storage
  Future<void> saveEncrypted(List<InvestorProfile> profiles) async {
    try {
      final plainText = InvestorProfile.encode(profiles);
      final encryptedText = _encrypter.encrypt(plainText, iv: _iv).base64;
      final file = File(await _getFilePath());
      await file.writeAsString(encryptedText);
      debugPrint('✅ Investor profiles encrypted and saved.');
    } catch (e) {
      debugPrint('❌ Error saving investors: $e');
    }
  }

  /// 🔓 Load and decrypt investor list from local storage
  Future<List<InvestorProfile>> loadEncrypted() async {
    try {
      final file = File(await _getFilePath());
      if (!await file.exists()) return [];

      final encryptedData = await file.readAsString();
      final decrypted = _encrypter.decrypt64(encryptedData, iv: _iv);
      return InvestorProfile.decode(decrypted);
    } catch (e) {
      debugPrint('❌ Decryption failed: $e');
      return [];
    }
  }

  /// ✅ Aliased for UI consumption
  Future<List<InvestorProfile>> loadInvestors() async {
    return await loadEncrypted();
  }

  /// ➕ Add investor to encrypted list
  Future<void> addInvestor(InvestorProfile investor) async {
    final investors = await loadEncrypted();
    investors.add(investor);
    await saveEncrypted(investors);
  }

  /// 🗑 Remove investor by ID
  Future<void> removeInvestor(String id) async {
    final investors = await loadEncrypted();
    investors.removeWhere((i) => i.id == id);
    await saveEncrypted(investors);
  }

  /// 🔍 Fetch investor by ID (fallback = empty)
  Future<InvestorProfile> getInvestorById(String id) async {
    final investors = await loadEncrypted();
    return investors.firstWhere(
      (i) => i.id == id,
      orElse: () => InvestorProfile.empty(),
    );
  }

  /// 💾 Add or update investor (by ID)
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
}
