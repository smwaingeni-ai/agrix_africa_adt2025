import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agrix_africa_adt2025/models/contracts/contract_offer.dart';

class ContractService {
  static const String _contractsKey = 'contract_offers';

  /// Save all contract offers to local storage
  static Future<void> saveContracts(List<ContractOffer> offers) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = offers.map((e) => e.toJson()).toList();
    await prefs.setString(_contractsKey, json.encode(jsonList));
  }

  /// Load all contract offers from local storage
  static Future<List<ContractOffer>> loadContracts() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_contractsKey);
    if (raw == null) return [];
    final decoded = json.decode(raw) as List<dynamic>;
    return decoded.map((e) => ContractOffer.fromJson(e)).toList();
  }

  /// Add a new contract offer to local storage
  static Future<void> addContract(ContractOffer offer) async {
    final offers = await loadContracts();
    offers.add(offer);
    await saveContracts(offers);
  }

  /// Update an existing contract offer by ID
  static Future<void> updateContract(ContractOffer updatedOffer) async {
    final offers = await loadContracts();
    final index = offers.indexWhere((o) => o.id == updatedOffer.id);
    if (index != -1) {
      offers[index] = updatedOffer;
      await saveContracts(offers);
    }
  }

  /// Retrieve a contract offer by ID
  static Future<ContractOffer?> getContractById(String id) async {
    final offers = await loadContracts();
    return offers.firstWhere(
      (offer) => offer.id == id,
      orElse: () => null,
    );
  }

  /// Delete a contract offer by ID
  static Future<void> deleteContract(String id) async {
    final offers = await loadContracts();
    final updated = offers.where((offer) => offer.id != id).toList();
    await saveContracts(updated);
  }

  // 🔁 Aliases for compatibility

  /// Alias for addContract()
  static Future<void> addContractOffer(ContractOffer offer) async {
    print('[ContractService] addContractOffer called');
    await addContract(offer);
  }

  /// Alias for loadContracts()
  static Future<List<ContractOffer>> loadOffers() async {
    print('[ContractService] loadOffers called');
    return await loadContracts();
  }
}
