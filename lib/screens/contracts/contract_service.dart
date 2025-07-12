import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/contracts/contract_offer.dart';

class ContractService {
  final String _key = 'contracts';

  Future<List<ContractOffer>> loadContracts() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data.map((e) => ContractOffer.fromJson(json.decode(e))).toList();
  }

  Future<void> saveContract(ContractOffer contract) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await loadContracts();
    existing.add(contract);
    final encoded = existing.map((c) => json.encode(c.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }
}
