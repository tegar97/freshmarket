import 'package:flutter/material.dart';
import 'package:freshmarket/injection.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/categoryProductModels.dart';
import 'package:freshmarket/service/category_product_service.dart';
import 'package:freshmarket/service/category_service.dart';
import 'package:provider/provider.dart';

class CategoryProductProviders with ChangeNotifier {

    /// Property to check mounted before notify
  bool isDisposed = false;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  /// List of category
  List<CategoryProductModels>? _categoriesProduct;
  List<CategoryProductModels>? get categoriesProduct => _categoriesProduct;
  // List<CategoryModels> get categories => _categories;
  // set categories(List<CategoryModels> categories) {
  //   _categories = categories;
  //   notifyListeners();
  // }

    static CategoryProductProviders instance(BuildContext context) =>
      Provider.of(context, listen: false);
  final categoriesProductService = locator<CategoryProductService>();

  /// Instance provider
Future<void> getCategoriesProduct(String? CityName) async {
    await Future.delayed(const Duration(milliseconds: 500));
    setOnSearch(true);

    try {
      final result = await categoriesProductService.getCategoriesProduct(CityName);
      print(
        'data now ==>  ${result.data}',
      );

      if (result.meta.code == 200) {
        _categoriesProduct = result.data;
        notifyListeners();
      } else {
        _categoriesProduct = [];
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _categoriesProduct = [];
    }
    setOnSearch(false);
  }

  void clearCategories() {
    _categoriesProduct = null;
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
