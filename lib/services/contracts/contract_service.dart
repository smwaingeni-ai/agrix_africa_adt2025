import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../../models/contracts/contract_offer.dart';

class ContractService {
  static Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/contract_offers.json';
  }

  static Future<List<ContractOffer>> loadContractOffers() async {
    try {
      final filePath = await _getFilePath();
      final file = File(filePath);

      if (!await file.exists()) return [];

      final contents = await file.readAsString();
      final List<dynamic> jsonData = json.decode(contents);
      return jsonData.map((json) => ContractOffer.fromJson(json)).toList();
    } catch (e) {
      print('Error loading contract offers: $e');
      return [];
    }
  }

  static Future<void> saveContractOffers(List<ContractOffer> offers) async {
    try {
      final filePath = await _getFilePath();
      final file = File(filePath);
      final jsonData = offers.map((offer) => offer.toJson()).toList();
      await file.writeAsString(json.encode(jsonData));
    } catch (e) {
      print('Error saving contract offers: $e');
    }
  }

  static Future<void> addContractOffer(ContractOffer offer) async {
    final offers = await loadContractOffers();
    offers.add(offer);
    await saveContractOffers(offers);
  }

  static Future<void> deleteContractOffer(String id) async {
    final offers = await loadContractOffers();
    offers.removeWhere((offer) => offer.id == id);
    await saveContractOffers(offers);
  }

  static Future<void> updateContractOffer(ContractOffer updatedOffer) async {
    final offers = await loadContractOffers();
    final index = offers.indexWhere((offer) => offer.id == updatedOffer.id);
    if (index != -1) {
      offers[index] = updatedOffer;
      await saveContractOffers(offers);
    }
  }
}
