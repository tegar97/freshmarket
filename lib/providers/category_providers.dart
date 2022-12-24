import 'package:flutter/material.dart';
import 'package:freshmarket/injection.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/service/category_service.dart';
import 'package:provider/provider.dart';

class CategoryProvider extends ChangeNotifier {
  /// Property to check mounted before notify
  bool isDisposed = false;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  /// List of category
  List<CategoryModels>? _categories;
  List<CategoryModels>? get categories => _categories;
  // List<CategoryModels> get categories => _categories;
  // set categories(List<CategoryModels> categories) {
  //   _categories = categories;
  //   notifyListeners();
  // }
  final categoryService = locator<CategoryService>();

  /// Instance provider
  static CategoryProvider instance(BuildContext context) =>
      Provider.of(context, listen: false);

  Future<void> getCategory() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setOnSearch(true);

    try {
      final result = await categoryService.getCategory();
      print(
        'data now ==>  ${result.data}',
      );

      if (result.meta.code == 200) {
        _categories = result.data;
        notifyListeners();
      } else {
        _categories = [];
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _categories = [];
    }
    setOnSearch(false);
  }


  void clearCategories() {
    _categories = null;
    notifyListeners();
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
