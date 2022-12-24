import 'package:flutter/material.dart';
import 'package:freshmarket/models/VoucherModels.dart';
import 'package:freshmarket/models/cartModels.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/paymentModels.dart';
import 'package:freshmarket/models/userModels.dart';
import 'package:freshmarket/service/category_service.dart';
import 'package:freshmarket/service/payment_service.dart';
import 'package:freshmarket/service/user_service.dart';

enum DeliveryType { courir, pickup }

class PaymentProvider with ChangeNotifier {
  PaymentModels? _payment;
  DeliveryType? _deliveryType;
  DeliveryType? get deliveryType => _deliveryType;

  PaymentModels get payment => _payment!;
  set users(PaymentModels payment) {
    _payment = payment;
    notifyListeners();
  }

  void changeDeliveryType(DeliveryType? deliveryType) {
    print(deliveryType);
    _deliveryType = deliveryType;
    notifyListeners();
  }

  Future<String> pay(
      {List<CartModels>? carts,
      double? amount,
      String? api,
      VoucherModels? promo}) async {
    try {
      String? newDeliveryType;
      if (deliveryType == DeliveryType.courir) {
        newDeliveryType = 'kurir';
      } else {
        newDeliveryType = 'pickup';
      }
      print(newDeliveryType);
      var transactionId = PaymentService().pay(
          carts: carts,
          amount: amount,
          api: api,
          deliveryType: newDeliveryType,
          promo: promo);
      return transactionId;
      return 'a';
    } catch (e) {
      throw Exception("Error");
    }
  }
}
