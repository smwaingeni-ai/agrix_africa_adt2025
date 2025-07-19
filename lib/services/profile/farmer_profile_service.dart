import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/farmer_profile.dart';

class FarmerProfileService {
  static const String _storageKey = 'active_farmer_profile';

  /// Save the farmer profile to SharedPreferences
  static Future<void> saveProfile(FarmerProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(profile.toJson());
    await prefs.setString(_storageKey, jsonString);
  }

  /// Load the farmer profile from SharedPreferences
  static Future<FarmerProfile?> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString != null) {
      try {
        final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        return FarmerProfile.fromJson(jsonMap);
      } catch (e) {
        debugPrint('❌ Failed to decode farmer profile: $e');
      }
    }
    return null;
  }

  /// Clear the stored profile
  static Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }

  /// Aliases for consistent naming
  static Future<void> saveActiveProfile(FarmerProfile profile) => saveProfile(profile);
  static Future<FarmerProfile?> loadActiveProfile() => loadProfile();
  static Future<void> clearActiveProfile() => clearProfile();

  /// Pick image from gallery
  static Future<String?> pickImageAndGetPath() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile?.path;
  }

  /// Convert image to base64 (non-web only)
  static Future<String?> getProfileImageBase64(String? filePath) async {
    if (filePath == null || kIsWeb) {
      debugPrint("⚠️ Image path is null or unsupported on web.");
      return null;
    }

    try {
      final bytes = await File(filePath).readAsBytes();
      return base64Encode(bytes);
    } catch (e) {
      debugPrint("❌ Error reading image file: $e");
      return null;
    }
  }

  /// Display image widget based on platform
  static Widget getImageWidget(String path, {BoxFit fit = BoxFit.cover}) {
    if (kIsWeb) {
      return Image.network(path, fit: fit);
    } else {
      return Image.file(File(path), fit: fit);
    }
  }

  /// Save QR code image to local disk and return file path
  static Future<String?> saveQRImageToFile(Uint8List imageBytes, String filename) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/$filename';
      final file = File(filePath);
      await file.writeAsBytes(imageBytes);
      return filePath;
    } catch (e) {
      debugPrint('❌ Error saving QR image: $e');
      return null;
    }
  }
}
