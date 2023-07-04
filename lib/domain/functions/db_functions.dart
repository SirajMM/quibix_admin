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
      'description': products.description
    }).then(
      (value) => Navigator.pop(context),
    );
  } catch (e) {}
}
