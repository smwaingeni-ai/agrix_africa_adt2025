import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditableProfileImage extends StatelessWidget {
  final String? imagePath;
  final double width;
  final double height;
  final BoxShape shape;
  final ValueChanged<String?> onImageChanged;

  const EditableProfileImage({
    super.key,
    required this.imagePath,
    required this.onImageChanged,
    this.width = 120,
    this.height = 120,
    this.shape = BoxShape.circle,
  });

  void _showImageSourceDialog(BuildContext context) async {
    final picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Pick from Gallery'),
              onTap: () async {
                final file = await picker.pickImage(source: ImageSource.gallery);
                Navigator.pop(context);
                onImageChanged(file?.path);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: () async {
                final file = await picker.pickImage(source: ImageSource.camera);
                Navigator.pop(context);
                onImageChanged(file?.path);
              },
            ),
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text('Cancel'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageZoomDialog(BuildContext context, ImageProvider imageProvider) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(16),
        child: InteractiveViewer(
          child: Image(image: imageProvider),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        shape: shape,
      ),
      child: const Icon(Icons.person, size: 50, color: Colors.white),
    );

    final imageWidget = (imagePath == null || imagePath!.isEmpty)
        ? placeholder
        : (kIsWeb
            ? Image.network(imagePath!, width: width, height: height, fit: BoxFit.cover)
            : Image.file(File(imagePath!), width: width, height: height, fit: BoxFit.cover));

    final clipped = ClipRRect(
      borderRadius: shape == BoxShape.circle
          ? BorderRadius.circular(width / 2)
          : BorderRadius.circular(8),
      child: imageWidget,
    );

    return GestureDetector(
      onTap: () {
        if (imagePath != null && imagePath!.isNotEmpty) {
          final provider = kIsWeb
              ? NetworkImage(imagePath!)
              : FileImage(File(imagePath!)) as ImageProvider;
          _showImageZoomDialog(context, provider);
        } else {
          _showImageSourceDialog(context);
        }
      },
      onLongPress: () => _showImageSourceDialog(context),
      child: clipped,
    );
  }
}
