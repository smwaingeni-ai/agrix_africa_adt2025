import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  static final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery
  static Future<String?> pickImage() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    return file?.path;
  }

  /// Pick image from camera
  static Future<String?> captureImage() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.camera);
    return file?.path;
  }

  /// Platform-safe widget to display image from path
  static Widget displayImage(String imagePath, {double? width, double? height}) {
    if (kIsWeb) {
      return Image.network(imagePath, width: width, height: height, fit: BoxFit.cover);
    } else {
      return Image.asset(imagePath, width: width, height: height, fit: BoxFit.cover);
      // You may replace Image.asset with Image.file if using File objects on mobile
    }
  }

  /// Placeholder if no image is available
  static Widget placeholder({double? width, double? height}) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: const Icon(Icons.image, color: Colors.grey),
    );
  }
}
