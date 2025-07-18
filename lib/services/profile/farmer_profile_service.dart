import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/farmer_profile.dart';

class ProfileService {
  static const String _key = 'active_farmer_profile';

  /// Save profile as JSON string
  static Future<void> saveProfile(FarmerProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(profile.toJson());
    await prefs.setString(_key, jsonString);
  }

  /// Load profile from local storage
  static Future<FarmerProfile?> loadActiveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString != null) {
      return FarmerProfile.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  /// Clear saved profile
  static Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  /// Pick image and return path (cross-platform)
  static Future<String?> pickImageAndGetPath() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return pickedFile.path; // Use directly in mobile; on web, this will still be a blob URI
    }

    return null;
  }

  /// Platform-specific safe image rendering: use this in UI
  static Widget getImageWidget(String path) {
    if (kIsWeb) {
      return Image.network(path, fit: BoxFit.cover);
    } else {
      return Image.file(Uri.parse(path).toFilePath() as dynamic, fit: BoxFit.cover);
    }
  }
}
