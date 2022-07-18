import 'dart:convert';

import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/productModels.dart';
import 'package:http/http.dart' as http;

class ProductService {
  String baseUrl = apiUrl;

  Future<List<ProductModels>> getProduct({int? id}) async {
    var headers = {'Content-Type': 'application/json'};

   
    var queryParameters = {'q': '{http}', 'category_id': '$id'};
    var url = Uri.http(
        baseUrl, '/freshmarket/public/api/v1/product',  id != null ? queryParameters : {'q': '{http}'} );
    var response = await http.get(url);

    print(response.body);
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
