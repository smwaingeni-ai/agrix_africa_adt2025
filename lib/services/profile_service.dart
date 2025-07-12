import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../models/farmer_profile.dart';

class ProfileService {
  static const String _fileName = 'farmer_profile.json';

  /// 🔹 Get full file path for storing farmer profile
  static Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$_fileName';
  }

  /// 🔹 Save FarmerProfile to disk
  static Future<void> saveProfile(FarmerProfile profile) async {
    try {
      final path = await _getFilePath();
      final file = File(path);
      final json = profile.toRawJson();
      await file.writeAsString(json, flush: true, encoding: utf8);
      print('✅ Profile saved at: $path');
    } catch (e) {
      print('❌ Error saving profile: $e');
    }
  }

  /// 🔹 Load FarmerProfile from disk
  static Future<FarmerProfile?> loadProfile() async {
    try {
      final path = await _getFilePath();
      final file = File(path);
      if (await file.exists()) {
        final contents = await file.readAsString(encoding: utf8);
        return FarmerProfile.fromRawJson(contents);
      } else {
        print('ℹ️ No saved profile found.');
        return null;
      }
    } catch (e) {
      print('❌ Error loading profile: $e');
      return null;
    }
  }

  /// 🔹 Delete FarmerProfile file
  static Future<void> deleteProfile() async {
    try {
      final path = await _getFilePath();
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
        print('🗑️ Farmer profile deleted.');
      } else {
        print('⚠️ No profile file to delete.');
      }
    } catch (e) {
      print('❌ Error deleting profile: $e');
    }
  }

  /// 🔹 Check if profile file exists
  static Future<bool> profileExists() async {
    try {
      final path = await _getFilePath();
      return File(path).exists();
    } catch (e) {
      print('❌ Error checking profile existence: $e');
      return false;
    }
  }

  /// 🔹 Export profile as raw JSON string (for sharing or backup)
  static Future<String?> exportProfileAsJson() async {
    try {
      final profile = await loadProfile();
      return profile?.toRawJson();
    } catch (e) {
      print('❌ Error exporting profile: $e');
      return null;
    }
  }

  /// 🔹 Import and save a profile from raw JSON string (optional use)
  static Future<void> importProfileFromJson(String jsonStr) async {
    try {
      final profile = FarmerProfile.fromRawJson(jsonStr);
      await saveProfile(profile);
      print('📥 Profile imported successfully.');
    } catch (e) {
      print('❌ Error importing profile: $e');
    }
  }
}
