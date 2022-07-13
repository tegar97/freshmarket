import 'package:flutter/material.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/service/category_service.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModels> _categories = [];

  List<CategoryModels> get categories => _categories;
  set categories(List<CategoryModels> categories) {
    _categories = categories;
    notifyListeners();
  }

  Future<void> getCategory() async {
    try {
      List<CategoryModels> categories = await CategoryService().getCategory();
      _categories = categories;
    } catch (e) {
      print(e);
    }
  }
}
