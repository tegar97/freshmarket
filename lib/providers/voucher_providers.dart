import 'package:flutter/material.dart';
import 'package:freshmarket/injection.dart';
import 'package:freshmarket/models/VoucherModels.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/categoryProductModels.dart';
import 'package:freshmarket/navigation/navigation_utils.dart';
import 'package:freshmarket/service/category_product_service.dart';
import 'package:freshmarket/service/category_service.dart';

import 'package:flutter/widgets.dart';
import 'package:freshmarket/service/voucher_service.dart';
import 'package:freshmarket/ui/Widget/snackbar/snackbar_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VoucherProvider extends ChangeNotifier {
  /// Property to check mounted before notify
  bool isDisposed = false;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  /// List of voucher products
  List<VoucherModels>? _vouchers;
  List<VoucherModels>? get voucher => _vouchers;

  List<VoucherModels>? _myVouchers;
  List<VoucherModels>? get myVouchers => _myVouchers;

  /// Instance provider
  static VoucherProvider instance(BuildContext context) =>
      Provider.of(context, listen: false);

  final voucherProductService = locator<VoucherService>();

  /// Get voucher products
  Future<void> getAvailableVoucher() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setOnSearch(true);

    try {
      final result = await voucherProductService.getAvailableVoucher();
      print(
        'data now ==>  ${result.data}',
      );

      if (result.meta.code == 200) {
        _vouchers = result.data;
        notifyListeners();
      } else {
        _vouchers = [];
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _vouchers = [];
    }
    setOnSearch(false);
  }

  Future<void> getMyVoucher() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    await Future.delayed(const Duration(milliseconds: 500));
    setOnSearch(true);

    try {
      final result = await voucherProductService.myVoucher(token);
      print(
        'data now ==>  ${result.data}',
      );

      if (result.meta.code == 200) {
        _myVouchers = result.data;
        print('my voucher $_myVouchers.');
        notifyListeners();
      } else {
        _myVouchers = [];
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _myVouchers = [];
    }
    setOnSearch(false);
  }

  void claimVoucher(String? token, String? code) async {
    try {
      print('Provider $token');
      final result = await voucherProductService.claimVoucher(token, code);
      print('Providerrrr ${result.meta.code}');
      if (result.meta.code == 200 && result.data != null) {
        showSnackbar(title: "Successfully claim vouchers", color: Colors.green);

        navigate.pop();
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      showSnackbar(
          floating: true,
          title: "Failed claim vouchers",
          color: Colors.red,
          isError: true);
      navigate.pop();
    }
    notifyListeners();
  }

  void clearVouchers() {
    _vouchers = null;
    _myVouchers = null;
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
