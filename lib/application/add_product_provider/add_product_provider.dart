// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductProvider extends ChangeNotifier {
  final List<String> _imageModels = [];
  String? _errorMessage;

  List<String> get imageModels => _imageModels;
  String? get errorMessage => _errorMessage;

  Future<void> pickImage() async {
    try {
      final pickedImages = await ImagePicker().pickMultiImage(
        maxWidth: 800,
        maxHeight: 800,
      );
      if (pickedImages != null) {
        final List<String> imagePaths =
            pickedImages.map((pickedImage) => pickedImage.path).toList();
        _imageModels.addAll(imagePaths);
        _errorMessage = null;
        notifyListeners();
      }
    } catch (error) {
      _errorMessage = 'Failed to pick images.';
      notifyListeners();
    }
  }
}
