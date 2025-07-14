// lib/services/market_service.dart

import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:agrix_africa_adt2025/models/market_item.dart';
import 'package:agrix_africa_adt2025/models/investment_offer.dart';

class MarketService {
  static Future<File> _getMarketFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/market_items.json');
  }

  static Future<File> _getOffersFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/investment_offers.json');
  }

  /// 🔹 Save list of market items
  static Future<void> saveItems(List<MarketItem> items) async {
    try {
      final file = await _getMarketFile();
      final jsonList = items.map((item) => item.toJson()).toList();
      await file.writeAsString(jsonEncode(jsonList), flush: true);
      print('✅ Market items saved.');
    } catch (e) {
      print('❌ Error saving market items: \$e');
    }
  }

  /// 🔹 Load market items
  static Future<List<MarketItem>> loadItems() async {
    try {
      final file = await _getMarketFile();
      if (!await file.exists()) return [];
      final contents = await file.readAsString();
      final List decoded = jsonDecode(contents);
      return decoded.map((e) => MarketItem.fromJson(e)).toList();
    } catch (e) {
      print('❌ Error loading market items: \$e');
      return [];
    }
  }

  /// 🔹 Add a single item
  static Future<void> addItem(MarketItem item) async {
    final items = await loadItems();
    items.add(item);
    await saveItems(items);
  }

  /// 🔹 Save investment offers
  static Future<void> saveOffers(List<InvestmentOffer> offers) async {
    try {
      final file = await _getOffersFile();
      final jsonList = offers.map((e) => e.toJson()).toList();
      await file.writeAsString(jsonEncode(jsonList), flush: true);
      print('✅ Investment offers saved.');
    } catch (e) {
      print('❌ Error saving investment offers: \$e');
    }
  }

  /// 🔹 Load investment offers
  static Future<List<InvestmentOffer>> loadOffers() async {
    try {
      final file = await _getOffersFile();
      if (!await file.exists()) return [];
      final contents = await file.readAsString();
      final List decoded = jsonDecode(contents);
      return decoded.map((e) => InvestmentOffer.fromJson(e)).toList();
    } catch (e) {
      print('❌ Error loading investment offers: \$e');
      return [];
    }
  }

  /// 🔹 Add new investment offer
  static Future<void> addOffer(InvestmentOffer offer) async {
    final offers = await loadOffers();
    offers.add(offer);
    await saveOffers(offers);
  }
}
