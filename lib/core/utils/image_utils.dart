import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ImageUtils {
  ImageUtils._();

  static final ImagePicker _picker = ImagePicker();

  /// Lets the user pick an image from camera or gallery.
  /// Returns a saved [File] inside the app documents directory, or null if cancelled.
  static Future<File?> pickAndSaveImage({required bool fromCamera}) async {
    final XFile? picked = await _picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 1600,
      maxHeight: 1600,
      imageQuality: 85,
    );
    if (picked == null) return null;
    return _saveToAppDir(File(picked.path));
  }

  /// Copies the image [source] into the app's private documents directory and returns the new file.
  static Future<File> _saveToAppDir(File source) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String imagesDirPath = p.join(appDir.path, 'images');
    final Directory imagesDir = Directory(imagesDirPath);
    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }

    final String ext = p.extension(source.path).toLowerCase();
    final String fileName = 'meal_${DateTime.now().millisecondsSinceEpoch}$ext';
    final String destPath = p.join(imagesDir.path, fileName);
    final File saved = await source.copy(destPath);
    if (kDebugMode) {
      // ignore: avoid_print
      print('Saved image to: ${saved.path}');
    }
    return saved;
  }
}
