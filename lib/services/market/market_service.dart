import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agrix_africa_adt2025/models/market/market_item.dart' as model;
import 'package:agrix_africa_adt2025/models/investments/investment_offer.dart' as investment;

class MarketService {
  static const String _itemsKey = 'market_items';
  static const String _offersKey = 'investment_offers';

  /// Save all market items
  static Future<void> saveItems(List<model.MarketItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = items.map((item) => item.toJson()).toList();
    await prefs.setString(_itemsKey, json.encode(jsonList));
  }

  /// Load all market items
  static Future<List<model.MarketItem>> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_itemsKey);
    if (raw == null) return [];
    final decoded = json.decode(raw) as List<dynamic>;
    return decoded.map((e) => model.MarketItem.fromJson(e)).toList();
  }

  /// Add a new market item
  static Future<void> addItem(model.MarketItem item) async {
    final items = await loadItems();
    items.add(item);
    await saveItems(items);
  }

  /// Save a single market item (replacing by ID)
  static Future<void> saveItem(model.MarketItem item) async {
    final items = await loadItems();
    final updated = items.where((existing) => existing.id != item.id).toList();
    updated.add(item);
    await saveItems(updated);
  }

  /// Update a market item
  static Future<void> updateItem(model.MarketItem updatedItem) async {
    final items = await loadItems();
    final index = items.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      items[index] = updatedItem;
      await saveItems(items);
    }
  }

  /// Save investment offers
  static Future<void> saveOffers(List<investment.InvestmentOffer> offers) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = offers.map((e) => e.toJson()).toList();
    await prefs.setString(_offersKey, json.encode(jsonList));
  }

  /// Load investment offers
  static Future<List<investment.InvestmentOffer>> loadOffers() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_offersKey);
    if (raw == null) return [];
    final decoded = json.decode(raw) as List<dynamic>;
    return decoded.map((e) => investment.InvestmentOffer.fromJson(e)).toList();
  }

  /// Add a new investment offer
  static Future<void> addOffer(investment.InvestmentOffer offer) async {
    final offers = await loadOffers();
    offers.add(offer);
    await saveOffers(offers);
  }

  /// Save a single investment offer (replacing by ID)
  static Future<void> saveOffer(investment.InvestmentOffer offer) async {
    final offers = await loadOffers();
    final updated = offers.where((existing) => existing.id != offer.id).toList();
    updated.add(offer);
    await saveOffers(updated);
  }

  /// Update an investment offer
  static Future<void> updateOffer(investment.InvestmentOffer updatedOffer) async {
    final offers = await loadOffers();
    final index = offers.indexWhere((offer) => offer.id == updatedOffer.id);
    if (index != -1) {
      offers[index] = updatedOffer;
      await saveOffers(offers);
    }
  }
}
