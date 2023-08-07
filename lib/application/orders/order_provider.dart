import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  Stream<DocumentSnapshot> getProductData(String id) {
    final orderRef = FirebaseFirestore.instance.collection('products');
    final orderDoc = orderRef.doc(id);
    return orderDoc.snapshots();
  }

  Stream<DocumentSnapshot> getAddressData(String id, String userEmail) {
    final addressRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection('address');
    final addressDoc = addressRef.doc(id);
    return addressDoc.snapshots();
  }
}
