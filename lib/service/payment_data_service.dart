import 'dart:convert';

import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/paymentDataModels.dart';
import 'package:freshmarket/models/paymentModels.dart';
import 'package:http/http.dart' as http;

class PaymentDataService {
  String baseUrl = apiUrl;

  Future<PaymentDataModels> getPaymentData(String? paymentId) async {
    var headers = {'Content-Type': 'application/json'};

    var url = Uri.http(baseUrl, '/freshmarket/public/api/v1/payment-code',
        {'q': '{http}', 'transaction_id': "${paymentId}"});
    var response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      PaymentDataModels payment = PaymentDataModels.fromJson(data['data']);
      ;
      return payment;
    } else {
      throw Exception('gagal mendapatkan kode pembayaran');
    }
  }
}
