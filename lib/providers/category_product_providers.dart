import 'package:flutter/material.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/categoryProductModels.dart';
import 'package:freshmarket/service/category_product_service.dart';
import 'package:freshmarket/service/category_service.dart';

class CategoryProductProviders with ChangeNotifier {
  List<CategoryProductModels> _categories = [];

  List<CategoryProductModels> get categories => _categories;
  set categories(List<CategoryProductModels> categories) {
    _categories = categories;
    notifyListeners();
  }

  Future<void> getCategoryProduct() async {
    try {
      List<CategoryProductModels> categories =
          await CategoryProductService().getCategory();
      _categories = categories;
    } catch (e) {
      print(e);
    }
  }
}
