import 'dart:convert';

import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/storeModels.dart';
import 'package:freshmarket/models/transactionModels.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class transactionService {
  String baseUrl = apiUrl;

 

  Future<List<TransactionModels>> getAllTransaction() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '${token}'
    };
    var queryParameters = {'q': '{http}'};

    var url = Uri.http(
        baseUrl, '/api/v1/transaction', queryParameters);
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      List<TransactionModels> transactions = [];

      for (var item in data) {
        transactions.add(TransactionModels.fromJson(item));
      }

      return transactions;
    } else {
      throw Exception('gagal mendapatkan transaksi');
    }
  }
}
