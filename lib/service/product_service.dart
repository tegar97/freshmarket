import 'dart:convert';

import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/productModels.dart';
import 'package:http/http.dart' as http;

class ProductService {
  String baseUrl = "192.168.1.5";

  Future<List<ProductModels>> getProduct() async {
    var headers = {'Content-Type': 'application/json'};

    var url = Uri.http(
        baseUrl, '/freshmarket/public/api/v1/product', {'q': '{http}'});
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];

      List<ProductModels> product = [];

      for (var item in data) {
      print(item);
        product.add(ProductModels.fromJson(item));
      }
      return product;
    } else {
      throw Exception('gagal mendapatkan data product');
    }
  }
}
