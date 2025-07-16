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

  /// 🔹 Dummy list for fallback or test usage
  static Future<List<ContractOffer>> loadOffers() async {
    return [
      ContractOffer(
        id: const Uuid().v4(),
        title: 'Maize Production Contract',
        description: 'Farmer required to produce 10 tons of maize by June 2026.',
        location: 'Chisamba, Zambia',
        duration: '6 months',
        paymentTerms: '50% upfront, 50% on delivery',
        contact: '+260971234567',
        isActive: true,
        postedAt: DateTime.now(),
        parties: ['Farmer A', 'Buyer B'], // ✅ required field
      ),
      ContractOffer(
        id: const Uuid().v4(),
        title: 'Tomato Supply Contract',
        description: 'Ongoing tomato supply for Lusaka market vendors.',
        location: 'Lusaka Rural',
        duration: '12 months',
        paymentTerms: 'Monthly settlement',
        contact: '+260976543210',
        isActive: true,
        postedAt: DateTime.now(),
        parties: ['Farmer C', 'Vendor D'], // ✅ required field
      ),
    ];
  }

  /// Example usage: Get contracts linked to a farmer
  List<ContractOffer> getContractsForFarmer(String farmerId) {
    return [
      ContractOffer(
        id: '001',
        title: 'Maize Supply Contract',
        description: 'Supply 1000kg of maize monthly',
        location: 'Eastern Province',
        duration: '6 months',
        paymentTerms: 'Quarterly',
        contact: '+260971111111',
        isActive: true,
        postedAt: DateTime.now(),
        parties: ['Farmer John', 'Zambia Agro Ltd'], // ✅ required field
      ),
      ContractOffer(
        id: '002',
        title: 'Groundnuts Agreement',
        description: 'Deliver 500kg of groundnuts at harvest',
        location: 'Central Province',
        duration: '8 months',
        paymentTerms: 'On delivery',
        contact: '+260972222222',
        isActive: true,
        postedAt: DateTime.now(),
        parties: ['Farmer Jane', 'PeanutCo'], // ✅ required field
      ),
    ];
  }
}
