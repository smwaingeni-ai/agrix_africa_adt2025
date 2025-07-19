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
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(profile.toJson());
      await prefs.setString(_storageKey, jsonString);
      debugPrint('✅ Farmer profile saved successfully.');
    } catch (e) {
      debugPrint('❌ Error saving farmer profile: $e');
    }
  }

  /// Load the farmer profile from SharedPreferences
  static Future<FarmerProfile?> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString != null) {
      try {
        return FarmerProfile.fromJson(jsonDecode(jsonString));
      } catch (e) {
        debugPrint('❌ Failed to decode farmer profile: $e');
      }
    }
    return null;
  }

  /// Check if a profile is saved
  static Future<bool> isProfileSaved() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_storageKey);
  }

  /// Remove the profile from local storage
  static Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
    debugPrint('🗑️ Farmer profile cleared from storage.');
  }

  /// Aliases for consistency across screens
  static Future<void> saveActiveProfile(FarmerProfile profile) => saveProfile(profile);
  static Future<FarmerProfile?> loadActiveProfile() => loadProfile();
  static Future<void> clearActiveProfile() => clearProfile();

  /// Pick an image from gallery and return its path
  static Future<String?> pickImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      return pickedFile?.path;
    } catch (e) {
      debugPrint('❌ Error picking image from gallery: $e');
      return null;
    }
  }

  /// Pick an image from camera and return its path
  static Future<String?> pickImageFromCamera() async {
    try {
      final picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
      return pickedFile?.path;
    } catch (e) {
      debugPrint('❌ Error capturing image from camera: $e');
      return null;
    }
  }

  /// Convert file to base64 (Mobile/Desktop only)
  static Future<String?> getProfileImageBase64(String? filePath) async {
    if (filePath == null || kIsWeb) {
      debugPrint("⚠️ Image path is null or unsupported on web.");
      return null;
    }

    try {
      final bytes = await File(filePath).readAsBytes();
      return base64Encode(bytes);
    } catch (e) {
      debugPrint("❌ Error reading file for base64 conversion: $e");
      return null;
    }
  }

  /// Render image safely across platforms
  static Widget getImageWidget(String path, {BoxFit fit = BoxFit.cover}) {
    if (kIsWeb) {
      return Image.network(path, fit: fit);
    } else {
      return Image.file(File(path), fit: fit);
    }
  }

  /// Optional: Save QR image to disk and return file path
  static Future<String?> saveQRImageToFile(Uint8List imageBytes, String filename) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/$filename';
      final file = File(filePath);
      await file.writeAsBytes(imageBytes);
      debugPrint('✅ QR image saved at: $filePath');
      return filePath;
    } catch (e) {
      debugPrint('❌ Error saving QR image: $e');
      return null;
    }
  }
}
