// ignore_for_file: unnecessary_null_comparison
import 'dart:io';
import 'package:admin/domain/models/product_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddProductProvider extends ChangeNotifier {
  final List<String> _imageModels = [];
  String? _errorMessage;

  List<String> get imageModels => _imageModels;
  String? get errorMessage => _errorMessage;

  void deletePickedImage(int index) {
    imageModels.isNotEmpty ? imageModels.removeAt(index) : null;
    notifyListeners();
  }

  void editeScreenDeletePickedImage(List imageList, int index) {
    imageList.isNotEmpty ? imageList.removeAt(index) : null;
    notifyListeners();
  }

  Future<void> pickImage(context) async {
    try {
      final pickedImages = await ImagePicker().pickMultiImage(
        maxWidth: 800,
        maxHeight: 800,
      );
      if (pickedImages.isEmpty || pickedImages == null) {
        return;
      }
      if (pickedImages != null) {
        final List<String> imagePaths =
            pickedImages.map((pickedImage) => pickedImage.path).toList();
        // _imageModels.addAll(imagePaths);
        await uploadImagesToFirebase(imagePaths, context);
        _errorMessage = null;
        notifyListeners();
      }
    } catch (error) {
      _errorMessage = 'Failed to pick images.';
      notifyListeners();
    }
  }

  Future<void> uploadImagesToFirebase(
      List<String> imagePaths, BuildContext context) async {
    final firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    final firebase_storage.Reference storageRef = storage.ref();

    for (String imagePath in imagePaths) {
      final file = File(imagePath);
      final fileName = path.basename(file.path);
      final firebase_storage.Reference imageRef = storageRef.child(fileName);

      try {
        await imageRef.putFile(file);
        final downloadURL = await imageRef.getDownloadURL();
        _imageModels.add(downloadURL);
      } catch (error) {
        final snackBar =
            SnackBar(content: Text('Failed to upload image: $error'));
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    notifyListeners();
  }

  Future<void> editProduct(Products products, details) async {
    final collection = FirebaseFirestore.instance.collection('products');
    final reference = collection.doc(details.id);
    await reference.update({
      'productname': products.productName,
      'subname': products.subname,
      'category': products.category,
      'quantity': products.quantity,
      'price': products.price,
      'color': products.color,
      'description': products.description,
      'imageList': _imageModels,
      'searchField': products.productName.toLowerCase().trim()
    });
    notifyListeners();
  }
}
