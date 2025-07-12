import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../models/farmer_profile.dart';

class ProfileService {
  static const String _fileName = 'farmer_profiles.json';

  /// Get the full file for storing the profiles
  static Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  /// Save a new profile (append to existing list)
  static Future<void> saveProfile(FarmerProfile profile) async {
    try {
      final profiles = await loadProfiles();
      profiles.add(profile);
      final file = await _getFile();
      await file.writeAsString(FarmerProfile.encode(profiles), flush: true);
      print('✅ Profile saved successfully.');
    } catch (e) {
      print('❌ Error saving profile: $e');
    }
  }

  /// Load all profiles
  static Future<List<FarmerProfile>> loadProfiles() async {
    try {
      final file = await _getFile();
      if (await file.exists()) {
        final contents = await file.readAsString();
        return FarmerProfile.decode(contents);
      } else {
        return [];
      }
    } catch (e) {
      print('❌ Error loading profiles: $e');
      return [];
    }
  }

  /// Delete all saved profiles
  static Future<void> clearProfiles() async {
    try {
      final file = await _getFile();
      if (await file.exists()) {
        await file.writeAsString('[]');
        print('🗑️ All profiles cleared.');
      }
    } catch (e) {
      print('❌ Error clearing profiles: $e');
    }
  }

  /// Check if any profile exists
  static Future<bool> profileExists() async {
    try {
      final file = await _getFile();
      return file.exists();
    } catch (e) {
      print('❌ Error checking profile existence: $e');
      return false;
    }
  }

  /// Export all profiles as raw JSON string
  static Future<String?> exportProfilesAsJson() async {
    try {
      final profiles = await loadProfiles();
      return FarmerProfile.encode(profiles);
    } catch (e) {
      print('❌ Error exporting profiles: $e');
      return null;
    }
  }

  /// Import multiple profiles from JSON string (overwrites all)
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
