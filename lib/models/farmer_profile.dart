import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:agrix_africa_adt2025/models/farmer_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

/// A platform-aware service for handling farmer profiles and profile images.
class FarmerProfileService {
  static const String _fileName = 'farmer_profiles.json';
  static const String _activeFileName = 'active_farmer_profile.json';

  /// Pick an image from gallery or camera and return a usable path.
  /// On mobile/desktop: returns local file path. On web: returns network blob string.
  static Future<String?> pickProfileImage({bool camera = false}) async {
    final picker = ImagePicker();
    final XFile? file = camera
        ? await picker.pickImage(source: ImageSource.camera)
        : await picker.pickImage(source: ImageSource.gallery);
    return file?.path;
  }

  /// Get platform-safe widget for displaying profile images.
  static Widget buildProfileImage(String? imagePath,
      {double width = 150, double height = 150}) {
    if (imagePath == null || imagePath.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: const Icon(Icons.person, size: 50, color: Colors.white),
      );
    }
    if (kIsWeb) return Image.network(imagePath, width: width, height: height, fit: BoxFit.cover);
    return Image.file(io.File(imagePath), width: width, height: height, fit: BoxFit.cover);
  }

  // ———————————————————— File-based profile storage methods ————————————————————

  static Future<io.File> _getProfileFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return io.File('${dir.path}/$_fileName');
  }

  static Future<io.File> _getActiveFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return io.File('${dir.path}/$_activeFileName');
  }

  static Future<void> saveProfile(FarmerProfile profile) async {
    try {
      final file = await _getProfileFile();
      await file.writeAsString(FarmerProfile.encode([profile]), flush: true);
      debugPrint('✅ Profile saved successfully.');
    } catch (e) {
      debugPrint('❌ Error saving profile: $e');
    }
  }

  static Future<void> saveFarmer(FarmerProfile profile) async {
    try {
      final farmers = await loadProfiles();
      farmers.removeWhere((x) => x.id == profile.id);
      farmers.add(profile);
      final file = await _getProfileFile();
      await file.writeAsString(jsonEncode(farmers.map((f) => f.toJson()).toList()));
      debugPrint('✅ Farmer saved: ${profile.name}');
    } catch (e) {
      debugPrint('❌ Error saving farmer: $e');
    }
  }

  static Future<void> updateFarmer(FarmerProfile profile) async {
    try {
      final farmers = await loadProfiles();
      farmers.removeWhere((p) => p.id == profile.id);
      farmers.add(profile);
      final file = await _getProfileFile();
      await file.writeAsString(FarmerProfile.encode(farmers), flush: true);
      debugPrint('✅ Farmer updated: ${profile.name}');
    } catch (e) {
      debugPrint('❌ Error updating farmer: $e');
    }
  }

  static Future<List<FarmerProfile>> loadProfiles() async {
    try {
      final file = await _getProfileFile();
      if (await file.exists()) {
        final content = await file.readAsString();
        return FarmerProfile.decode(content);
      }
    } catch (e) {
      debugPrint('❌ Error loading profiles: $e');
    }
    return [];
  }

  static Future<FarmerProfile?> loadActiveProfile() async {
    try {
      final file = await _getActiveFile();
      if (await file.exists()) {
        final content = await file.readAsString();
        return FarmerProfile.fromRawJson(content);
      }
    } catch (e) {
      debugPrint('❌ Error loading active profile: $e');
    }
    return null;
  }

  static Future<void> saveActiveProfile(FarmerProfile profile) async {
    try {
      final file = await _getActiveFile();
      await file.writeAsString(jsonEncode(profile.toJson()));
      debugPrint('✅ Active profile saved.');
    } catch (e) {
      debugPrint('❌ Error saving active profile: $e');
    }
  }

  static Future<void> clearActiveProfile() async {
    try {
      final file = await _getActiveFile();
      if (await file.exists()) {
        await file.delete();
        debugPrint('🗑️ Active profile cleared.');
      }
    } catch (e) {
      debugPrint('❌ Error clearing active profile: $e');
    }
  }

  static Future<void> deleteAllProfiles() async {
    try {
      final file = await _getProfileFile();
      if (await file.exists()) {
        await file.writeAsString('[]', flush: true);
        debugPrint('🗑️ All profiles deleted.');
      }
    } catch (e) {
      debugPrint('❌ Error deleting profiles: $e');
    }
  }

  static Future<void> deleteFarmer(String id) async {
    try {
      final farmers = await loadProfiles();
      farmers.removeWhere((f) => f.id == id);
      final file = await _getProfileFile();
      await file.writeAsString(jsonEncode(farmers.map((f) => f.toJson()).toList()));
      debugPrint('🗑️ Farmer deleted: $id');
    } catch (e) {
      debugPrint('❌ Error deleting farmer: $e');
    }
  }

  static Future<FarmerProfile?> getFarmerById(String id) async {
    final farmers = await loadProfiles();
    return farmers.firstWhere((f) => f.id == id, orElse: () => FarmerProfile.empty());
  }

  static Future<bool> profileExists() async {
    final profiles = await loadProfiles();
    return profiles.isNotEmpty;
  }

  static Future<String?> exportProfilesAsJson() async {
    try {
      final profiles = await loadProfiles();
      return FarmerProfile.encode(profiles);
    } catch (e) {
      debugPrint('❌ Error exporting profiles: $e');
      return null;
    }
  }

  static Future<void> importProfilesFromJson(String jsonStr) async {
    try {
      final profiles = FarmerProfile.decode(jsonStr);
      final file = await _getProfileFile();
      await file.writeAsString(FarmerProfile.encode(profiles), flush: true);
      debugPrint('📥 Profiles imported successfully.');
    } catch (e) {
      debugPrint('❌ Error importing profiles: $e');
    }
  }
}
