import 'dart:convert';

import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/models/VoucherModels.dart';
import 'package:freshmarket/models/cartModels.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/paymentModels.dart';
import 'package:freshmarket/models/userModels.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PaymentService {
  String baseUrl = apiUrl;

  Future<String> pay(
      {List<CartModels>? carts,
      double? amount,
      String? api,
      String? deliveryType,
      VoucherModels? promo}) async {
    print(promo?.code);
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '$token'
    };


    var url = Uri.http(
        baseUrl, '/api/v1/order/${api}', {'q': '{http}'});
    var body;
    print('promo nih ${promo?.code}');
    if (promo?.code == null) {
      body =
          jsonEncode({'item_list': carts, 'amount': amount, 'promo': null, 'deliveryType' : deliveryType
      });
    } else {
      body = jsonEncode({
        'item_list': carts,
        'amount': amount,
        'deliveryType' : deliveryType,
        'promo': {
          'id': promo?.id,
          'discount_percetange': promo?.discountPercetange,
          'voucher_description': promo?.voucherDescription
        }
      });
    }

    print(body);
    var response = await http.post(url, body: body, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      String data = jsonDecode(response.body)['data']['transaction_id'];

      return data;
    } else {
      print("Error");

      throw Exception('Gagal mendapatkan kode pembayaran');
    }
  }
}
