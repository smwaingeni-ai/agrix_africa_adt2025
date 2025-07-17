import 'dart:convert';
import 'dart:io';
import 'package:agrix_africa_adt2025/models/contracts/contract_offer.dart';
import 'package:path_provider/path_provider.dart';

class ContractService {
  static const String _fileName = 'contract_offers.json';

  static Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$_fileName';
  }

  static Future<List<ContractOffer>> loadOffers() async {
    try {
      final path = await _getFilePath();
      final file = File(path);
      if (!await file.exists()) return [];
      final contents = await file.readAsString();
      final List<dynamic> jsonData = json.decode(contents);
      return jsonData.map((e) => ContractOffer.fromJson(e)).toList();
    } catch (e) {
      print('Error loading contract offers: $e');
      return [];
    }
  }

  static Future<void> saveOffers(List<ContractOffer> offers) async {
    try {
      final path = await _getFilePath();
      final file = File(path);
      final jsonData = offers.map((e) => e.toJson()).toList();
      await file.writeAsString(json.encode(jsonData));
    } catch (e) {
      print('Error saving contract offers: $e');
    }
  }

  static Future<void> addOffer(ContractOffer offer) async {
    final offers = await loadOffers();
    offers.add(offer);
    await saveOffers(offers);
  }

  static Future<void> updateOffer(String id, ContractOffer updatedOffer) async {
    final offers = await loadOffers();
    final index = offers.indexWhere((offer) => offer.id == id);
    if (index != -1) {
      offers[index] = updatedOffer;
      await saveOffers(offers);
    }
  }

  static Future<void> deleteOffer(String id) async {
    final offers = await loadOffers();
    offers.removeWhere((offer) => offer.id == id);
    await saveOffers(offers);
  }

  static Future<ContractOffer?> getOfferById(String id) async {
    final offers = await loadOffers();
    return offers.firstWhere((offer) => offer.id == id, orElse: () => null);
  }
}
