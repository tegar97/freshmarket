import 'package:flutter/material.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/productModels.dart';
import 'package:freshmarket/service/category_service.dart';
import 'package:freshmarket/service/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModels> _products = [];
  List<ProductModels> _productsCategory = [];

  List<ProductModels> get products => _products;
  List<ProductModels> get productsCategory => _productsCategory;
  set products(List<ProductModels> products) {
    _products = products;
    notifyListeners();
  }
  set productsCategory(List<ProductModels> productsCategory) {
    _productsCategory = productsCategory;
    notifyListeners();
  }

  Future<void> getProduct({int? id}) async {
    try {
      List<ProductModels> products = await ProductService().getProduct(id: id);
      _products = products;
    } catch (e) {
      print(e);
    }
  }
  Future<void> getProductCategory({int? id}) async {
    try {
      List<ProductModels> products = await ProductService().getProduct(id: id);
      _productsCategory = products;
    } catch (e) {
      print(e);
    }
  }
}
