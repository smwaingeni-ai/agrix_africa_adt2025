import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/contracts/contract_offer.dart';

class ContractService {
  static const String _storageKey = 'contract_offers';

  /// 🔹 Save the full list of contract offers
  static Future<void> saveOffers(List<ContractOffer> offers) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = jsonEncode(offers.map((e) => e.toJson()).toList());
      await prefs.setString(_storageKey, encoded);
      print('✅ Contract offers saved.');
    } catch (e) {
      print('❌ Failed to save contract offers: $e');
    }
  }

  /// 🔹 Load all saved contract offers
  static Future<List<ContractOffer>> loadOffers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_storageKey);
      if (raw == null) return [];

      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded.map((e) => ContractOffer.fromJson(e)).toList();
    } catch (e) {
      print('❌ Failed to load contract offers: $e');
      return [];
    }
  }

  /// 🔹 Add a new contract offer
  static Future<void> addOffer(ContractOffer newOffer) async {
    try {
      final offers = await loadOffers();
      offers.add(newOffer);
      await saveOffers(offers);
      print('📄 Contract offer added: ${newOffer.id}');
    } catch (e) {
      print('❌ Failed to add contract offer: $e');
    }
  }

  /// 🔹 Update an existing contract offer by ID
  static Future<void> updateOffer(ContractOffer updatedOffer) async {
    try {
      final offers = await loadOffers();
      final index = offers.indexWhere((e) => e.id == updatedOffer.id);
      if (index != -1) {
        offers[index] = updatedOffer;
        await saveOffers(offers);
        print('🔄 Contract offer updated: ${updatedOffer.id}');
      } else {
        print('⚠️ Offer not found: ${updatedOffer.id}');
      }
    } catch (e) {
      print('❌ Failed to update contract offer: $e');
    }
  }

  /// 🔹 Delete a contract offer by ID
  static Future<void> deleteOffer(String id) async {
    try {
      final offers = await loadOffers();
      offers.removeWhere((e) => e.id == id);
      await saveOffers(offers);
      print('🗑️ Contract offer deleted: $id');
    } catch (e) {
      print('❌ Failed to delete contract offer: $e');
    }
  }

  /// 🔹 Retrieve a contract offer by ID
  static Future<ContractOffer?> getOfferById(String id) async {
    try {
      final offers = await loadOffers();
      return offers.firstWhere((e) => e.id == id, orElse: () => null);
    } catch (e) {
      print('❌ Error fetching offer by ID: $e');
      return null;
    }
  }

  /// 🔹 Clear all offers (for testing or reset)
  static Future<void> clearAllOffers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_storageKey);
      print('🧹 All contract offers cleared.');
    } catch (e) {
      print('❌ Failed to clear contract offers: $e');
    }
  }
}
