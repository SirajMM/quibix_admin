import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  Stream<DocumentSnapshot> getProductData(String id) {
    final orderRef = FirebaseFirestore.instance.collection('products');
    final orderDoc = orderRef.doc(id);
    return orderDoc.snapshots();
  }
}
