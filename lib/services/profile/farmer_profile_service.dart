import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:agrix_africa_adt2025/models/farmer_profile.dart';

class FarmerProfileService {
  static const String _fileName = 'farmer_profiles.json';
  static const String _activeFileName = 'active_farmer_profile.json';

  // 🔹 Get file path for all profiles
  static Future<File> _getProfileFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_fileName');
  }

  // 🔹 Get file path for active profile
  static Future<File> _getActiveFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_activeFileName');
  }

  // ✅ Save a single profile (overwrites all with one)
  static Future<void> saveProfile(FarmerProfile profile) async {
    try {
      final file = await _getProfileFile();
      final profiles = [profile];
      await file.writeAsString(FarmerProfile.encode(profiles), flush: true);
      print('✅ Profile saved successfully.');
    } catch (e) {
      print('❌ Error saving profile: $e');
    }
  }

  // ✅ Save or update a profile in the list
  static Future<void> saveFarmer(FarmerProfile profile) async {
    try {
      final farmers = await loadProfiles();
      farmers.removeWhere((x) => x.id == profile.id);
      farmers.add(profile);
      final file = await _getProfileFile();
      await file.writeAsString(jsonEncode(farmers.map((f) => f.toJson()).toList()));
      print('✅ Farmer saved: ${profile.name}');
    } catch (e) {
      print('❌ Error saving farmer: $e');
    }
  }

  // ✅ Update an existing farmer (same as saveFarmer)
  static Future<void> updateFarmer(FarmerProfile profile) async {
    try {
      final farmers = await loadProfiles();
      farmers.removeWhere((p) => p.id == profile.id);
      farmers.add(profile);
      final file = await _getProfileFile();
      await file.writeAsString(FarmerProfile.encode(farmers), flush: true);
      print('✅ Farmer updated: ${profile.name}');
    } catch (e) {
      print('❌ Error updating farmer: $e');
    }
  }

  // 🔍 Load all profiles
  static Future<List<FarmerProfile>> loadProfiles() async {
    try {
      final file = await _getProfileFile();
      if (await file.exists()) {
        final content = await file.readAsString();
        return FarmerProfile.decode(content);
      }
    } catch (e) {
      print('❌ Error loading profiles: $e');
    }
    return [];
  }

  // 🔍 Load active profile
  static Future<FarmerProfile?> loadActiveProfile() async {
    try {
      final file = await _getActiveFile();
      if (await file.exists()) {
        final content = await file.readAsString();
        return FarmerProfile.fromRawJson(content);
      }
    } catch (e) {
      print('❌ Error loading active profile: $e');
    }
    return null;
  }

  // ✅ Save active profile
  static Future<void> saveActiveProfile(FarmerProfile profile) async {
    try {
      final file = await _getActiveFile();
      await file.writeAsString(jsonEncode(profile.toJson()));
      print('✅ Active profile saved.');
    } catch (e) {
      print('❌ Error saving active profile: $e');
    }
  }

  // 🧼 Clear active profile
  static Future<void> clearActiveProfile() async {
    try {
      final file = await _getActiveFile();
      if (await file.exists()) {
        await file.delete();
        print('🗑️ Active profile cleared.');
      }
    } catch (e) {
      print('❌ Error clearing active profile: $e');
    }
  }

  // 🗑️ Delete all profiles
  static Future<void> deleteAllProfiles() async {
    try {
      final file = await _getProfileFile();
      if (await file.exists()) {
        await file.writeAsString('[]', flush: true);
        print('🗑️ All profiles deleted.');
      }
    } catch (e) {
      print('❌ Error deleting profiles: $e');
    }
  }

  // 🗑️ Delete single profile by ID
  static Future<void> deleteFarmer(String id) async {
    try {
      final farmers = await loadProfiles();
      farmers.removeWhere((f) => f.id == id);
      final file = await _getProfileFile();
      await file.writeAsString(jsonEncode(farmers.map((f) => f.toJson()).toList()));
      print('🗑️ Farmer deleted: $id');
    } catch (e) {
      print('❌ Error deleting farmer: $e');
    }
  }

  // 🔍 Get single profile by ID
  static Future<FarmerProfile?> getFarmerById(String id) async {
    final farmers = await loadProfiles();
    return farmers.firstWhere((f) => f.id == id, orElse: () => FarmerProfile.empty());
  }

  // ✅ Check if any profile exists
  static Future<bool> profileExists() async {
    final profiles = await loadProfiles();
    return profiles.isNotEmpty;
  }

  // 📤 Export to JSON string
  static Future<String?> exportProfilesAsJson() async {
    try {
      final profiles = await loadProfiles();
      return FarmerProfile.encode(profiles);
    } catch (e) {
      print('❌ Error exporting profiles: $e');
      return null;
    }
  }

  // 📥 Import from JSON string
  static Future<void> importProfilesFromJson(String jsonStr) async {
    try {
      final profiles = FarmerProfile.decode(jsonStr);
      final file = await _getProfileFile();
      await file.writeAsString(FarmerProfile.encode(profiles), flush: true);
      print('📥 Profiles imported successfully.');
    } catch (e) {
      print('❌ Error importing profiles: $e');
    }
  }
}
