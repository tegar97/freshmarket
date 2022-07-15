import 'package:flutter/material.dart';
import 'package:freshmarket/models/cartModels.dart';
import 'package:freshmarket/models/paymentDataModels.dart';
import 'package:freshmarket/models/paymentModels.dart';
import 'package:freshmarket/service/payment_data_service.dart';
import 'package:freshmarket/service/payment_service.dart';

class PaymentDataProvider with ChangeNotifier {
  PaymentDataModels? _payment;

  PaymentDataModels get payment => _payment!;
  set users(PaymentDataModels payment) {
    _payment = payment;
    notifyListeners();
  }

  Future<void> getPaymentCode({String? paymentId}) async {
    try {
      PaymentDataModels payment = await PaymentDataService().getPaymentData(paymentId);
      _payment = payment;
    } catch (e) {
      throw Exception("Error");
    }
  }
}
