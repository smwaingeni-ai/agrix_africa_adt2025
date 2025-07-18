import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:agrix_africa_adt2025/models/farmer_profile.dart';

class FarmerService {
  static const String _fileName = 'farmers.json';

  /// 🔹 Get full path to farmer storage file
  static Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/$_fileName';
  }

  /// 🔹 Load all farmer profiles
  static Future<List<FarmerProfile>> loadFarmers() async {
    try {
      final file = File(await _getFilePath());
      if (!await file.exists()) return [];
      final content = await file.readAsString();
      final List<dynamic> decoded = jsonDecode(content);
      return decoded.map((e) => FarmerProfile.fromJson(e)).toList();
    } catch (e) {
      print('❌ Error loading farmers: $e');
      return [];
    }
  }

  /// 🔹 Save or update a farmer profile
  static Future<void> saveFarmer(FarmerProfile profile) async {
    try {
      final farmers = await loadFarmers();
      farmers.removeWhere((x) => x.id == profile.id);
      farmers.add(profile);
      final file = File(await _getFilePath());
      await file.writeAsString(jsonEncode(farmers.map((f) => f.toJson()).toList()));
      print('✅ Farmer saved: ${profile.name}');
    } catch (e) {
      print('❌ Error saving farmer: $e');
    }
  }

  /// 🔹 Get farmer by ID
  static Future<FarmerProfile?> getFarmerById(String id) async {
    final farmers = await loadFarmers();
    return farmers.firstWhere(
      (f) => f.id == id,
      orElse: () => FarmerProfile.empty(),
    );
  }

  /// 🔹 Delete farmer by ID
  static Future<void> deleteFarmer(String id) async {
    try {
      final farmers = await loadFarmers();
      farmers.removeWhere((f) => f.id == id);
      final file = File(await _getFilePath());
      await file.writeAsString(jsonEncode(farmers.map((f) => f.toJson()).toList()));
      print('🗑️ Farmer deleted: $id');
    } catch (e) {
      print('❌ Error deleting farmer: $e');
    }
  }
}
