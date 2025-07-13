import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../models/contracts/contract_offer.dart';

class ContractService {
  final String _key = 'contracts';

  /// Load all saved contract offers from local storage
  Future<List<ContractOffer>> loadContracts() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];

    return data.map((e) {
      try {
        return ContractOffer.fromJson(json.decode(e));
      } catch (_) {
        return ContractOffer.empty(); // fallback for corrupted JSON
      }
    }).where((c) => c.id.isNotEmpty).toList(); // filter invalid contracts
  }

  /// Save a new contract offer with UUID if not already set
  Future<void> saveContract(ContractOffer contract) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await loadContracts();

    if (contract.id.isEmpty) {
      contract.id = const Uuid().v4();
    }

    existing.add(contract);
    final encoded = existing.map((c) => json.encode(c.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }

  /// Delete a contract offer by its ID
  Future<void> deleteContract(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await loadContracts();

    final updated = existing.where((c) => c.id != id).toList();
    final encoded = updated.map((c) => json.encode(c.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }

  /// Update an existing contract offer
  Future<void> updateContract(ContractOffer updatedContract) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await loadContracts();

    final updated = existing.map((c) =>
      c.id == updatedContract.id ? updatedContract : c
    ).toList();

    final encoded = updated.map((c) => json.encode(c.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }
}
