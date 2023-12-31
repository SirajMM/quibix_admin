// import 'dart:developer';
// import 'package:admin/presentation/home_screen/home_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'models/product_models.dart';

// Future<void> addProduct(Products productsModel, BuildContext context) async {
//   final product = FirebaseFirestore.instance.collection('products');
//   final reference = product.doc();
//   try {
//     showSnackbar(context, "Product was added");
//     await reference.set({
//       'category': productsModel.category,
//       'description': productsModel.description,
//       'id': reference.id,
//       'image': productsModel.imageList,
//       'name': productsModel.productName,
//       'price': productsModel.price,
//       'subname': productsModel.subname,
//       'quantity': productsModel.quantity,
//       'color': productsModel.color,
//     }).then((value) {
//       Navigator.of(context).pop();
//     });
//   } catch (error) {
//     showSnackbar(context, "Failed To Add Product: $error");
//     log("Failed to add product: $error");
//   }
// }

// Future<void> updateProduct(
//     {required Products productsModel,
//     required String id,
//     required BuildContext context}) async {
//   final products = FirebaseFirestore.instance.collection('products');
//   final productRef = products.doc(id);

//   try {
//     showSnackbar(context, "Product was updated");
//     await productRef.update({
//       'category': productsModel.category,
//       'description': productsModel.description,
//       'image': productsModel.imageList,
//       'name': productsModel.productName,
//       'price': productsModel.price,
//       'subname': productsModel.subname,
//       'quantity': productsModel.quantity,
//       'color': productsModel.color,
//     }).then((value) {
//       showSnackbar(context, 'Product Updated');
//       Navigator.push(context, MaterialPageRoute(
//         builder: (context) {
//           return const ScreenHome();
//         },
//       ));
//     });
//     log("Product Updated");
//   } catch (error) {
//     showSnackbar(context, "Failed to update product: $error");
//     log("Failed to update product: $error");
//   }
// }

// void showSnackbar(BuildContext context, String message) {
//   final snackBar = SnackBar(
//     behavior: SnackBarBehavior.floating,
//     margin: const EdgeInsets.only(bottom: 100.0),
//     content: Text(message),
//     action: SnackBarAction(
//       label: 'Dismiss',
//       onPressed: () {
//         ScaffoldMessenger.of(context).hideCurrentSnackBar();
//       },
//     ),
//   );

//   ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }

// Future<void> deleteProduct(String id, BuildContext context) {
//   CollectionReference products =
//       FirebaseFirestore.instance.collection('products');

//   return products.doc(id).delete().then((value) {
//     log("Product Deleted");
//     showSnackbar(context, "Product was deleted");
//   }).catchError((error) {
//     log("Failed to delete product: $error");
//     showSnackbar(context, "Failed to delete product");
//   });
// }

// Future<void> addMoreImage(List imageList, String id) async {
//   final products = FirebaseFirestore.instance.collection('products');
//   final productRef = products.doc(id);
//   try {
//     // showSnackbar(context, "Product was updated");
//     await productRef.update({
//       'image': imageList,
//     });
//     log("Product Updated");
//   } catch (error) {
//     // showSnackbar(context, "Failed to update product: $error");
//     log("Failed to update product: $error");
//   }
// }
