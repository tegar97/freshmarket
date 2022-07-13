import 'package:flutter/material.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/productModels.dart';
import 'package:freshmarket/service/category_service.dart';
import 'package:freshmarket/service/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModels> _products = [];

  List<ProductModels> get products => _products;
  set products(List<ProductModels> products) {
    _products = products;
    notifyListeners();
  }

  Future<void> getProduct() async {
    try {
      List<ProductModels> products = await ProductService().getProduct();
      _products = products;
    } catch (e) {
      print(e);
    }
  }
}
