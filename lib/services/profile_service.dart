import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../models/farmer_profile.dart';

class ProfileService {
  static const String _fileName = 'farmer_profiles.json';

  /// Get the profile storage file
  static Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  /// Save a new profile (overwrites existing list with just one profile)
  static Future<void> saveProfile(FarmerProfile profile) async {
    try {
      final file = await _getFile();
      final profiles = [profile]; // Always overwrite with single profile for simplicity
      await file.writeAsString(FarmerProfile.encode(profiles), flush: true);
      print('✅ Profile saved successfully.');
    } catch (e) {
      print('❌ Error saving profile: $e');
    }
  }

  /// Load the first profile (for single-user use case)
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

  /// Delete the saved profile (clears all)
  static Future<void> deleteProfile() async {
    try {
      final file = await _getFile();
      if (await file.exists()) {
        await file.writeAsString('[]', flush: true);
        print('🗑️ Profile deleted.');
      }
    } catch (e) {
      print('❌ Error deleting profile: $e');
    }
  }

  /// Load all profiles (for future multi-user support)
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

  /// Clear all profiles from file
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

  /// Check if at least one profile exists
  static Future<bool> profileExists() async {
    try {
      final profiles = await loadProfiles();
      return profiles.isNotEmpty;
    } catch (e) {
      print('❌ Error checking profile existence: $e');
      return false;
    }
  }

  /// Export all profiles as JSON
  static Future<String?> exportProfilesAsJson() async {
    try {
      final profiles = await loadProfiles();
      return FarmerProfile.encode(profiles);
    } catch (e) {
      print('❌ Error exporting profiles: $e');
      return null;
    }
  }

  /// Import profiles from a JSON string (overwrites file)
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
