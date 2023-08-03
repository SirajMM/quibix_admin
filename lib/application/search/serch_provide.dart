import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  String productName = '';
  filterUsers(String query) {
    productName = query;
    notifyListeners();
  }
}
