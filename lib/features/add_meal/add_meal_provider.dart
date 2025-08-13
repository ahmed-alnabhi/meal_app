import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/image_utils.dart';

class AddMealProvider extends ChangeNotifier {
  String? _imagePath;

  String? get imagePath => _imagePath;

  Future<void> pickImage(BuildContext context) async {
    final bool? fromCamera = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Camera'),
                onTap: () => Navigator.of(context).pop(true),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Gallery'),
                onTap: () => Navigator.of(context).pop(false),
              ),
            ],
          ),
        );
      },
    );
    if (fromCamera == null) return;
    final file = await ImageUtils.pickAndSaveImage(fromCamera: fromCamera);
    if (file != null) {
      _imagePath = file.path;
      notifyListeners();
    }
  }

  void clearImage() {
    _imagePath = null;
    notifyListeners();
  }
}
