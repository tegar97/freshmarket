import 'package:flutter/material.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/service/category_service.dart';

class CategoryProvider with ChangeNotifier {

    /// Property to check mounted before notify
  bool isDisposed = false;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;


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


  
  /// Set event search
  void setOnSearch(bool value) {
    _onSearch = value;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }
   @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
