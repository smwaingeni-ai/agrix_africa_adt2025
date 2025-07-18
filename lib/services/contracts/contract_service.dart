import 'dart:convert';
import 'dart:io';
import 'package:agrix_africa_adt2025/models/contracts/contract_offer.dart';
import 'package:path_provider/path_provider.dart';

class ContractService {
  static const String _fileName = 'contract_offers.json';

  /// 🔧 Helper to get local storage file path
  static Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$_fileName';
  }

  /// 📥 Load all saved contract offers
  static Future<List<ContractOffer>> loadOffers() async {
    try {
      final path = await _getFilePath();
      final file = File(path);
      if (!await file.exists()) return [];
      final contents = await file.readAsString();
      final List<dynamic> jsonData = json.decode(contents);
      return jsonData.map((e) => ContractOffer.fromJson(e)).toList();
    } catch (e) {
      print('❌ Error loading contract offers: $e');
      return [];
    }
  }

  /// 💾 Save all offers to local storage
  static Future<void> saveOffers(List<ContractOffer> offers) async {
    try {
      final path = await _getFilePath();
      final file = File(path);
      final jsonData = offers.map((e) => e.toJson()).toList();
      await file.writeAsString(json.encode(jsonData));
    } catch (e) {
      print('❌ Error saving contract offers: $e');
    }
  }

  /// ➕ Add a single contract offer (ensures defaults)
  static Future<void> addContractOffer(ContractOffer offer) async {
    try {
      final offers = await loadOffers();

      // ⛑️ Optional: Provide fallback/default values
      if (offer.amount == null) {
        offer = offer.copyWith(amount: 0.0);
      }

      offers.add(offer);
      await saveOffers(offers);
    } catch (e) {
      print('❌ Error in addContractOffer: $e');
    }
  }

  /// 🧱 Compatibility alias for addContractOffer()
  static Future<void> addOffer(ContractOffer offer) async {
    await addContractOffer(offer); // Delegate to main logic
  }

  /// 🔄 Update an existing offer by ID
  static Future<void> updateOffer(String id, ContractOffer updatedOffer) async {
    try {
      final offers = await loadOffers();
      final index = offers.indexWhere((offer) => offer.id == id);
      if (index != -1) {
        offers[index] = updatedOffer;
        await saveOffers(offers);
      }
    } catch (e) {
      print('❌ Error updating contract offer: $e');
    }
  }

  /// ❌ Remove an offer by ID
  static Future<void> deleteOffer(String id) async {
    try {
      final offers = await loadOffers();
      offers.removeWhere((offer) => offer.id == id);
      await saveOffers(offers);
    } catch (e) {
      print('❌ Error deleting contract offer: $e');
    }
  }

  /// 🔍 Retrieve offer by ID
  static Future<ContractOffer?> getOfferById(String id) async {
    try {
      final offers = await loadOffers();
      return offers.firstWhere((offer) => offer.id == id, orElse: () => null);
    } catch (e) {
      print('❌ Error retrieving contract offer by ID: $e');
      return null;
    }
  }
}
