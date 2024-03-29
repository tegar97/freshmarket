import 'package:flutter/widgets.dart';
import 'package:freshmarket/models/VoucherModels.dart';
import 'package:freshmarket/models/cartModels.dart';
import 'package:freshmarket/models/productModels.dart';

class CartProvider with ChangeNotifier {
  List<CartModels> _carts = [];
  List<CartModels> get carts => _carts;

  bool? isUseVoucher = false;
  int? discountValue;
  int? price;
  int? TotalPrice;

  VoucherModels voucher = VoucherModels();

  set carts(List<CartModels> carts) {
    _carts = carts;
    notifyListeners();
  }

  addCart(ProductModels? product, int? qty) {
    print(qty);
    if (productExist(product!)) {
      print("data sama");
      int index =
          _carts.indexWhere((element) => element.product?.id == product.id);
      _carts[index].quantity = (_carts[index].quantity ?? 0) + (qty ?? 1);
      _carts[index].total =
          (_carts[index].quantity ?? 0) * (carts[index].product!.price ?? 0);
    } else {
      _carts.add(CartModels(
          id: _carts.length,
          product: product,
          quantity: qty,
          total: (product.price ?? 0) * (qty ?? 1)));
    }

    notifyListeners();
  }

  removeCart(int id) {
    _carts.removeAt(id);
    notifyListeners();
  }

  clearCart() {
    _carts.clear();
    isUseVoucher = false;
    voucher = VoucherModels();
    discountValue = 0;
    notifyListeners();
  }

  addQuantity(int id) {
    _carts[id].quantity = _carts[id].quantity! + 1;
    _carts[id].total = _carts[id].quantity! * (_carts[id].product!.price ?? 0);
    if (_carts[id].quantity == 0) {
      _carts.removeAt(id);
    }
    notifyListeners();
  }

  reduceQuantity(int id) {
    _carts[id].quantity = _carts[id].quantity! - 1;

    if (_carts[id].quantity == 0) {
      _carts.removeAt(id);
    }
    notifyListeners();
  }

  totalItem() {
    int total = 0;
    for (var item in _carts) {
      total += (item.quantity ?? 0);
    }
    return total;
  }

  totalPriceProduct() {
    double total = 0;
    for (var item in _carts) {
      total += ((item.quantity ?? 0) * (item?.product?.price ?? 0));
    }

    return total;
  }

  totalPrice() {
    double total = 0;
    for (var item in _carts) {
      total += ((item.quantity ?? 0) * (item?.product?.price ?? 0));
    }
    print('Voucher ID => ${voucher.id}');
    if (isUseVoucher == true) {
      total = total - discountValue!;
      print(total * discountValue!);
    }
    return total;
  }

  productExist(ProductModels product) {
    print('yo');
    if (_carts.indexWhere((element) => element.product!.id == product.id) ==
        -1) {
      return false;
    } else {
      return true;
    }
  }

  usePromo() {
    isUseVoucher = true;
    notifyListeners();
  }

  unusedPromo() {
    isUseVoucher = false;
    notifyListeners();
  }

  getVoucherInfo(VoucherModels voucherData) {
    voucher = voucherData;
    notifyListeners();
  }

  getDiscountvalue(double discountPercetange) {
    double total = 0;
    for (var item in _carts) {
      total += ((item.quantity ?? 0) * (item?.product?.price ?? 0));
    }
    discountValue = (total * discountPercetange / 100).round();

    notifyListeners();
  }
}
