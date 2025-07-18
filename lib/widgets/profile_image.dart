import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 🔲 Widget to build a circular or square profile image from file or network
Widget buildProfileImage(String? imagePath, {
  double width = 150,
  double height = 150,
  BoxShape shape = BoxShape.rectangle,
}) {
  final decoration = BoxDecoration(
    color: Colors.grey[300],
    shape: shape,
  );

  if (imagePath == null || imagePath.isEmpty) {
    return Container(
      width: width,
      height: height,
      decoration: decoration,
      child: const Icon(Icons.person, size: 50, color: Colors.white),
    );
  }

  final imageWidget = kIsWeb
      ? Image.network(imagePath, width: width, height: height, fit: BoxFit.cover)
      : Image.file(File(imagePath), width: width, height: height, fit: BoxFit.cover);

  return ClipRRect(
    borderRadius: shape == BoxShape.circle
        ? BorderRadius.circular(width / 2)
        : BorderRadius.circular(8),
    child: imageWidget,
  );
}
