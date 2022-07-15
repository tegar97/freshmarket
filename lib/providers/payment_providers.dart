import 'package:flutter/material.dart';
import 'package:freshmarket/models/cartModels.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/paymentModels.dart';
import 'package:freshmarket/models/userModels.dart';
import 'package:freshmarket/service/category_service.dart';
import 'package:freshmarket/service/payment_service.dart';
import 'package:freshmarket/service/user_service.dart';

class PaymentProvider with ChangeNotifier {
  PaymentModels? _payment;

  PaymentModels get payment => _payment!;
  set users(PaymentModels payment) {
    _payment = payment;
    notifyListeners();
  }

  Future<String> pay({List<CartModels>? carts, double? amount}) async {
    try {
      var transactionId = PaymentService().pay(carts: carts, amount: amount) ;
      return transactionId;
    } catch (e) {
      throw Exception("Error");
    }
  }
}
