import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:agrix_africa_adt2025/models/market/market_item.dart';
import 'package:agrix_africa_adt2025/models/investments/investment_offer.dart';

class MarketService {
  // 🔹 Get local JSON file for market items
  static Future<File> _getMarketFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/market_items.json');
  }

  // 🔹 Get local JSON file for investment offers
  static Future<File> _getOffersFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/investment_offers.json');
  }

  // ------------------- Market Items -------------------

  static Future<void> saveItems(List<MarketItem> items) async {
    try {
      final file = await _getMarketFile();
      final jsonList = items.map((item) => item.toJson()).toList();
      await file.writeAsString(jsonEncode(jsonList), flush: true);
    } catch (e) {
      print('❌ Error saving market items: $e');
    }
  }

  static Future<List<MarketItem>> loadItems() async {
    try {
      final file = await _getMarketFile();
      if (!await file.exists()) return [];
      final contents = await file.readAsString();
      if (contents.trim().isEmpty) return [];
      final List decoded = jsonDecode(contents);
      return decoded.map((e) => MarketItem.fromJson(e)).toList();
    } catch (e) {
      print('❌ Error loading market items: $e');
      return [];
    }
  }

  static Future<void> addItem(MarketItem item) async {
    final items = await loadItems();
    items.add(item);
    await saveItems(items);
  }

  static Future<void> saveItem(MarketItem item) async {
    await addItem(item);
  }

  static Future<void> deleteItem(String id) async {
    final items = await loadItems();
    final updated = items.where((item) => item.id != id).toList();
    await saveItems(updated);
  }

  static Future<void> updateItem(MarketItem updatedItem) async {
    final items = await loadItems();
    final index = items.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      items[index] = updatedItem;
      await saveItems(items);
    }
  }

  // ------------------- Investment Offers -------------------

  static Future<void> saveOffers(List<InvestmentOffer> offers) async {
    try {
      final file = await _getOffersFile();
      final jsonList = offers.map((e) => e.toJson()).toList();
      await file.writeAsString(jsonEncode(jsonList), flush: true);
    } catch (e) {
      print('❌ Error saving investment offers: $e');
    }
  }

  static Future<List<InvestmentOffer>> loadOffers() async {
    try {
      final file = await _getOffersFile();
      if (!await file.exists()) return [];
      final contents = await file.readAsString();
      if (contents.trim().isEmpty) return [];
      final List decoded = jsonDecode(contents);
      return decoded.map((e) => InvestmentOffer.fromJson(e)).toList();
    } catch (e) {
      print('❌ Error loading investment offers: $e');
      return [];
    }
  }

  static Future<void> addOffer(InvestmentOffer offer) async {
    final offers = await loadOffers();
    offers.add(offer);
    await saveOffers(offers);
  }

  static Future<void> deleteOffer(String id) async {
    final offers = await loadOffers();
    final updated = offers.where((offer) => offer.id != id).toList();
    await saveOffers(updated);
  }

  static Future<void> updateOffer(InvestmentOffer updatedOffer) async {
    final offers = await loadOffers();
    final index = offers.indexWhere((offer) => offer.id == updatedOffer.id);
    if (index != -1) {
      offers[index] = updatedOffer;
      await saveOffers(offers);
    }
  }
}
