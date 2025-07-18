import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/farmer_profile.dart';

class ProfileService {
  static const String _fileName = 'farmer_profiles.json';
  static const String _activeProfileFile = 'active_farmer_profile.json';

  /// 📂 Get file for all profiles
  static Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  /// 📂 Get file for active profile
  static Future<File> _getActiveFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_activeProfileFile');
  }

  /// ✅ Save a new profile (overwrites existing list with one)
  static Future<void> saveProfile(FarmerProfile profile) async {
    try {
      final file = await _getFile();
      final profiles = [profile];
      await file.writeAsString(FarmerProfile.encode(profiles), flush: true);
      print('✅ Profile saved successfully.');
    } catch (e) {
      print('❌ Error saving profile: $e');
    }
  }

  /// ✅ Save active profile (for quick access or login)
  static Future<void> saveActiveProfile(FarmerProfile profile) async {
    try {
      final file = await _getActiveFile();
      await file.writeAsString(jsonEncode(profile.toJson()));
      print('✅ Active profile saved.');
    } catch (e) {
      print('❌ Error saving active profile: $e');
    }
  }

  /// 🔍 Load the first profile (single-user fallback)
  static Future<FarmerProfile?> loadProfile() async {
    try {
      final file = await _getFile();
      if (await file.exists()) {
        final contents = await file.readAsString();
        final profiles = FarmerProfile.decode(contents);
        return profiles.isNotEmpty ? profiles.first : null;
      }
    } catch (e) {
      print('❌ Error loading profile: $e');
    }
    return null;
  }

  /// 🔍 Load active profile (login/session)
  static Future<FarmerProfile?> loadActiveProfile() async {
    try {
      final file = await _getActiveFile();
      if (await file.exists()) {
        final jsonStr = await file.readAsString();
        return FarmerProfile.fromRawJson(jsonStr);
      }
    } catch (e) {
      print('❌ Error loading active profile: $e');
    }
    return null;
  }

  /// 🧼 Clear active profile only
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

  /// 🗑️ Delete all saved profiles
  static Future<void> deleteProfile() async {
    try {
      final file = await _getFile();
      if (await file.exists()) {
        await file.writeAsString('[]', flush: true);
        print('🗑️ Profiles deleted.');
      }
    } catch (e) {
      print('❌ Error deleting profiles: $e');
    }
  }

  /// 🔄 Load all saved profiles
  static Future<List<FarmerProfile>> loadProfiles() async {
    try {
      final file = await _getFile();
      if (await file.exists()) {
        final contents = await file.readAsString();
        return FarmerProfile.decode(contents);
      }
    } catch (e) {
      print('❌ Error loading profiles: $e');
    }
    return [];
  }

  /// ✅ Added method for use in other modules (alias for loadProfiles)
  static Future<List<FarmerProfile>> loadFarmers() async {
    return await loadProfiles();
  }

  /// 🔁 Clear profiles file
  static Future<void> clearProfiles() async {
    try {
      final file = await _getFile();
      if (await file.exists()) {
        await file.writeAsString('[]', flush: true);
        print('🧹 Profiles cleared.');
      }
    } catch (e) {
      print('❌ Error clearing profiles: $e');
    }
  }

  /// ❓ Check if any profile exists
  static Future<bool> profileExists() async {
    try {
      final profiles = await loadProfiles();
      return profiles.isNotEmpty;
    } catch (e) {
      print('❌ Error checking profile existence: $e');
      return false;
    }
  }

  /// 📤 Export all profiles to JSON
  static Future<String?> exportProfilesAsJson() async {
    try {
      final profiles = await loadProfiles();
      return FarmerProfile.encode(profiles);
    } catch (e) {
      print('❌ Error exporting profiles: $e');
      return null;
    }
  }

  /// 📥 Import profiles from JSON (overwrites)
  static Future<void> importProfilesFromJson(String jsonStr) async {
    try {
      final profiles = FarmerProfile.decode(jsonStr);
      final file = await _getFile();
      await file.writeAsString(FarmerProfile.encode(profiles), flush: true);
      print('📥 Profiles imported successfully.');
    } catch (e) {
      print('❌ Error importing profiles: $e');
    }
  }
}
