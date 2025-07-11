import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../models/farmer_profile.dart';

class ProfileService {
  static const _fileName = 'farmer_profile.json';

  /// 🔹 Get path to local storage
  static Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$_fileName';
  }

  /// 🔹 Save the profile (including image path, ID number, etc.)
  static Future<void> saveProfile(FarmerProfile profile) async {
    try {
      final path = await _getFilePath();
      final file = File(path);
      final json = profile.toRawJson();
      await file.writeAsString(json, flush: true, encoding: utf8);
    } catch (e) {
      print('❌ Error saving profile: $e');
    }
  }

  /// 🔹 Load profile if it exists
  static Future<FarmerProfile?> loadProfile() async {
    try {
      final path = await _getFilePath();
      final file = File(path);
      if (await file.exists()) {
        final contents = await file.readAsString(encoding: utf8);
        return FarmerProfile.fromRawJson(contents);
      }
      return null;
    } catch (e) {
      print('❌ Error loading profile: $e');
      return null;
    }
  }

  /// 🔹 Delete profile
  static Future<void> deleteProfile() async {
    try {
      final path = await _getFilePath();
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
        print('🗑️ Profile deleted.');
      }
    } catch (e) {
      print('❌ Error deleting profile: $e');
    }
  }

  /// 🔹 Check if profile exists
  static Future<bool> profileExists() async {
    final path = await _getFilePath();
    return File(path).exists();
  }

  /// 🔹 (Optional) Export profile as shareable JSON string
  static Future<String?> exportProfileAsJson() async {
    final profile = await loadProfile();
    return profile?.toRawJson();
  }
}
