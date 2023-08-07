import 'dart:developer';

import 'package:admin/domain/models/product_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> addProduct(Products products, BuildContext context) async {
  final collection = FirebaseFirestore.instance.collection('products');
  final reference = collection.doc();
  try {
    await reference.set({
      'productname': products.productName,
      'subname': products.subname,
      'category': products.category,
      'quantity': products.quantity,
      'price': products.price,
      'color': products.color,
      'id': reference.id,
      'imageList': products.imageList,
      'description': products.description,
      'searchField': products.productName.toLowerCase().trim(),
    }).then(
      (value) => Navigator.pop(context),
    );
  } catch (e) {
    log(e.toString());
  }
}

Future<void> updateProduct(DocumentReference<Map<String, dynamic>> reference,
    List<dynamic> imageList, Products products) {
  return reference.update({
    'productname': products.productName,
    'subname': products.subname,
    'category': products.category,
    'quantity': products.quantity,
    'price': products.price,
    'color': products.color,
    'description': products.description,
    'imageList': imageList,
  });
}
