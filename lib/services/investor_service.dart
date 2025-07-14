import 'dart:convert';
import 'dart:io';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:path_provider/path_provider.dart';
import 'package:agrix_africa_adt2025/models/investor_profile.dart';

class InvestorService {
  static const String _fileName = 'investor_profiles_encrypted.json';

  final _key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows!'); // 32 chars key
  final _iv = encrypt.IV.fromLength(16); // AES IV

  encrypt.Encrypter get _encrypter => encrypt.Encrypter(encrypt.AES(_key));

  /// 🔹 Full file path for encrypted investor data
  Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/$_fileName';
  }

  /// 🔹 Save encrypted investor list to file
  Future<void> saveEncrypted(List<InvestorProfile> profiles) async {
    try {
      final plainText = InvestorProfile.encode(profiles);
      final encryptedText = _encrypter.encrypt(plainText, iv: _iv).base64;
      final file = File(await _getFilePath());
      await file.writeAsString(encryptedText);
      print('🔐 Investor profiles encrypted and saved.');
    } catch (e) {
      print('❌ Error saving encrypted investors: $e');
    }
  }

  /// 🔹 Load and decrypt investor profiles from file
  Future<List<InvestorProfile>> loadEncrypted() async {
    try {
      final file = File(await _getFilePath());
      if (!await file.exists()) return [];

      final encryptedData = await file.readAsString();
      final decrypted = _encrypter.decrypt64(encryptedData, iv: _iv);
      return InvestorProfile.decode(decrypted);
    } catch (e) {
      print('❌ Decryption failed: $e');
      return [];
    }
  }

  /// 🔹 Add a new investor
  Future<void> addInvestor(InvestorProfile investor) async {
    final investors = await loadEncrypted();
    investors.add(investor);
    await saveEncrypted(investors);
  }

  /// 🔹 Remove investor by ID
  Future<void> removeInvestor(String id) async {
    final investors = await loadEncrypted();
    investors.removeWhere((i) => i.id == id);
    await saveEncrypted(investors);
  }

  /// 🔹 Get investor by ID
  Future<InvestorProfile?> getInvestorById(String id) async {
    final investors = await loadEncrypted();
    return investors.firstWhere((i) => i.id == id, orElse: () => null);
  }

  /// 🔹 Add or update investor
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
