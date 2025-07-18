import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/farmer_profile.dart';

class FarmerProfileService {
  static const String _storageKey = 'active_farmer_profile';

  /// Save the farmer profile to local storage
  static Future<void> saveProfile(FarmerProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(profile.toJson());
    await prefs.setString(_storageKey, jsonString);
  }

  /// Load the farmer profile from local storage
  static Future<FarmerProfile?> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString != null) {
      return FarmerProfile.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  /// Clear the stored profile
  static Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }

  /// Pick an image and return its path
  static Future<String?> pickImageAndGetPath() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile?.path;
  }

  /// Return base64-encoded image string (Mobile/Desktop only)
  static Future<String?> getProfileImageBase64(String? filePath) async {
    if (filePath == null || kIsWeb) {
      debugPrint("⚠️ Image path is null or unsupported on web.");
      return null;
    }

    try {
      final bytes = await File(filePath).readAsBytes();
      return base64Encode(bytes);
    } catch (e) {
      debugPrint("❌ Error reading file: $e");
      return null;
    }
  }

  /// Render image safely based on platform
  static Widget getImageWidget(String path, {BoxFit fit = BoxFit.cover}) {
    if (kIsWeb) {
      return Image.network(path, fit: fit);
    } else {
      return Image.file(File(path), fit: fit);
    }
  }
}
