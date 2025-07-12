// ✅ market_service.dart
// Path: lib/services/market_service.dart
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import '../models/market_item.dart';

class MarketService {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/market_items.json');
  }

  static Future<List<MarketItem>> loadItems() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        return MarketItem.decode(contents);
      }
    } catch (e) {
      print("❌ Error loading items: \$e");
    }
    return [];
  }

  static Future<void> saveItem(MarketItem item) async {
    final items = await loadItems();
    final updatedItems = items.where((x) => x.id != item.id).toList();
    updatedItems.add(item);
    final file = await _localFile;
    await file.writeAsString(MarketItem.encode(updatedItems));
    print("✅ Market item saved: \${item.title}");
  }

  static Future<void> deleteItem(String id) async {
    final items = await loadItems();
    final updatedItems = items.where((x) => x.id != id).toList();
    final file = await _localFile;
    await file.writeAsString(MarketItem.encode(updatedItems));
    print("🗑️ Market item deleted: \$id");
  }
}
