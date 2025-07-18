import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import '../../models/contracts/contract_offer.dart';

class ContractService {
  static const String _fileName = 'contracts_encrypted.json';

  final _key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows!');
  final _iv = encrypt.IV.fromLength(16);
  encrypt.Encrypter get _encrypter => encrypt.Encrypter(encrypt.AES(_key));

  Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/$_fileName';
  }

  Future<void> saveContracts(List<ContractOffer> contracts) async {
    try {
      final plainText = jsonEncode(contracts.map((c) => c.toJson()).toList());
      final encryptedText = _encrypter.encrypt(plainText, iv: _iv).base64;
      final file = File(await _getFilePath());
      await file.writeAsString(encryptedText);
    } catch (e) {
      debugPrint('❌ Failed to save contracts: $e');
    }
  }

  Future<List<ContractOffer>> loadContracts() async {
    try {
      final file = File(await _getFilePath());
      if (!await file.exists()) return [];

      final encryptedText = await file.readAsString();
      final decrypted = _encrypter.decrypt64(encryptedText, iv: _iv);
      final List<dynamic> data = json.decode(decrypted);
      return data.map((item) => ContractOffer.fromJson(item)).toList();
    } catch (e) {
      debugPrint('❌ Failed to load contracts: $e');
      return [];
    }
  }

  Future<void> addContract(ContractOffer offer) async {
    final contracts = await loadContracts();
    contracts.add(offer);
    await saveContracts(contracts);
  }

  Future<void> removeContract(String id) async {
    final contracts = await loadContracts();
    contracts.removeWhere((c) => c.id == id);
    await saveContracts(contracts);
  }

  Future<ContractOffer> getContractById(String id) async {
    final contracts = await loadContracts();
    return contracts.firstWhere(
      (c) => c.id == id,
      orElse: () => ContractOffer.empty(),
    );
  }
}
