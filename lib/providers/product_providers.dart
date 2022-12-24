import 'package:flutter/material.dart';
import 'package:freshmarket/injection.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/productModels.dart';
import 'package:freshmarket/providers/maps_provider.dart';
import 'package:freshmarket/service/category_service.dart';
import 'package:freshmarket/service/product_service.dart';
import 'package:provider/provider.dart';

class ProductProvider with ChangeNotifier {
  // List<ProductModels> _products = [];
  List<ProductModels> _productsCategory = [];

  // List<ProductModels> get products => _products;

  /// List of voucher products
  List<ProductModels>? _product;
  List<ProductModels>? get product => _product;

  List<ProductModels> get productsCategory => _productsCategory;

  List<ProductModels>? _searchProducts;
  List<ProductModels>? get searchProducts => _searchProducts;

  String? _latestKeyword;
  String? get latestKeyword => _latestKeyword;

  /// Property to check mounted before notify
  bool isDisposed = false;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  /// Dependency injection
  final productService = locator<ProductService>();

  /// Instance provider
  static ProductProvider instance(BuildContext context) =>
      Provider.of(context, listen: false);
  set products(List<ProductModels> products) {
    _product = product;
    notifyListeners();
  }

  set productsCategory(List<ProductModels> productsCategory) {
    _productsCategory = productsCategory;
    notifyListeners();
  }

  /// Get voucher products
  Future<void> getProduct({int? categoryId, String? cityName}) async {
    print('product provider cityname ${cityName}');
    await Future.delayed(const Duration(milliseconds: 500));

    setOnSearch(true);

    try {
      final result = await productService.getProducts(categoryId, cityName);
      print(
        'data now ==>  ${result.data}',
      );

      if (result.meta.code == 200) {
        _product = result.data;
        print('product $_product');
        notifyListeners();
      } else {
        _product = [];
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _product = [];
    }
    setOnSearch(false);
  }

  // Future<void> getProduct({int? id}) async {
  //   try {
  //     List<ProductModels> products = await productService.getProducts(id);
  //     _products = products;
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  // Future<void> getProductCategory({int? id}) async {
  //   try {
  //     List<ProductModels> products = await products.pr
  //     _productsCategory = productsCategory;
  //   } catch (e) {
  //     print(e);
  //   }
  // }
// Search restaurant by keywords
  void search(String keyword) async {
    _searchProducts = null;
    if (keyword.isEmpty) {
      _searchProducts = null;
      setOnSearch(false);
    } else {
      await Future.delayed(const Duration(milliseconds: 100));
      setOnSearch(true);
      _latestKeyword = keyword;
      try {
        final result = await productService.searchProducts(keyword);
        if (result.meta.code == 200) {
          _searchProducts = result.data;
        } else {
          _searchProducts = [];
        }
      } catch (e) {
        debugPrint("Error: ${e.toString()}");
        _searchProducts = [];
      }
      setOnSearch(false);
    }
  }

  void clearSearch() {
    _searchProducts = null;
    _latestKeyword = null;
    setOnSearch(false);
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
