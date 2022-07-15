import 'dart:convert';

import 'package:freshmarket/models/cartModels.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/paymentModels.dart';
import 'package:freshmarket/models/userModels.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PaymentService {
  String baseUrl = "192.168.1.5";

  Future<String> pay({List<CartModels>? carts, double? amount}) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '$token'
    };

    var url =
        Uri.http(baseUrl, '/freshmarket/public/api/v1/order', {'q': '{http}'});

    var body = jsonEncode({'item_list': carts, 'amount': amount});

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
