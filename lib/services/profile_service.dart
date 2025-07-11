import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../models/farmer_profile.dart';

class ProfileService {
  static const _fileName = 'farmer_profile.json';

  // Get path to local directory
  static Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$_fileName';
  }

  // Save profile to JSON file
  static Future<void> saveProfile(FarmerProfile profile) async {
    final path = await _getFilePath();
    final file = File(path);
    final json = profile.toRawJson();
    await file.writeAsString(json);
  }

  // Load profile from JSON file
  static Future<FarmerProfile?> loadProfile() async {
    try {
      final path = await _getFilePath();
      final file = File(path);
      if (await file.exists()) {
        final contents = await file.readAsString();
        return FarmerProfile.fromRawJson(contents);
      }
      return null;
    } catch (e) {
      print('Error loading profile: $e');
      return null;
    }
  }

  // Delete profile (reset)
  static Future<void> deleteProfile() async {
    final path = await _getFilePath();
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  // Check if a profile exists
  static Future<bool> profileExists() async {
    final path = await _getFilePath();
    return File(path).exists();
  }
}
