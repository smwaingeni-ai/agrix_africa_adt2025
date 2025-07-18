import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/farmer_profile.dart';

class FarmerProfileService {
  static const String _key = 'active_farmer_profile';

  /// Save the FarmerProfile as a JSON string in shared preferences
  static Future<void> saveProfile(FarmerProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(profile.toJson());
    await prefs.setString(_key, jsonString);
  }

  /// Load the FarmerProfile from shared preferences
  static Future<FarmerProfile?> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString != null) {
      return FarmerProfile.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  /// Clear the saved FarmerProfile
  static Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  /// Pick an image using image_picker and return its path
  static Future<String?> pickImageAndGetPath() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile?.path;
  }

  /// Get Base64 of image file (only for mobile/desktop, not web)
  static Future<String?> getProfileImageBase64(String? filePath) async {
    if (filePath == null || kIsWeb) {
      debugPrint("⚠️ File reading is not supported on web: $filePath");
      return null;
    }

    try {
      final file = Uri.parse(filePath).toFilePath();
      final bytes = await File(file).readAsBytes();
      return base64Encode(bytes);
    } catch (e) {
      debugPrint("❌ Error reading file for base64: $e");
      return null;
    }
  }

  /// Platform-aware image display from path (URI for web, File for mobile)
  static Widget getImageWidget(String path, {BoxFit fit = BoxFit.cover}) {
    if (kIsWeb) {
      return Image.network(path, fit: fit);
    } else {
      try {
        final file = Uri.parse(path).toFilePath();
        return Image.file(File(file), fit: fit);
      } catch (e) {
        return const Text("Image not available");
      }
    }
  }
}
