import 'package:flutter/material.dart';
import 'package:freshmarket/models/VoucherModels.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/categoryProductModels.dart';
import 'package:freshmarket/service/category_product_service.dart';
import 'package:freshmarket/service/category_service.dart';

import 'package:flutter/widgets.dart';
import 'package:freshmarket/service/voucher_service.dart';

class VoucherProvider extends ChangeNotifier {
  List<VoucherModels> _vouchers = [];

  List<VoucherModels> get vouchers => _vouchers;

  set vouchers(List<VoucherModels> vouchers) {
    _vouchers = vouchers;
    notifyListeners();
  }

  Future<void> getVouchers() async {
    try {
      List<VoucherModels> vouchers =
          await VoucherService().getVouchers();
      _vouchers = vouchers;
    } catch (e) {
      print(e);
    }
  }
}
