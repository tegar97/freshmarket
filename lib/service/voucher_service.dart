import 'dart:convert';

import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/models/VoucherModels.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/categoryProductModels.dart';
import 'package:http/http.dart' as http;

class VoucherService {
  String baseUrl = apiUrl;

  Future<List<VoucherModels>> getVouchers() async {
    var headers = {'Content-Type': 'application/json'};

    var url = Uri.http(baseUrl,
        '/freshmarket/public/api/v1/getAvailableVoucher', {'q': '{http}'});
    var response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];

      List<VoucherModels> vouchers = [];

      for (var item in data) {
        vouchers.add(VoucherModels.fromJson(item));
      }
      return vouchers;
    } else {
      throw Exception('gagal mendapatkan vouchers');
    }
  }
}
