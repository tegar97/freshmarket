import 'dart:convert';

import 'package:freshmarket/config/api/base_api.dart';
import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/models/api/api_response.dart';
import 'package:freshmarket/models/api/api_result_model.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/productModels.dart';
import 'package:http/http.dart' as http;

class ProductService {
    BaseAPI api;
  ProductService(this.api);
  String baseUrl = apiUrl;

  // Future<List<ProductModels>> getProduct({int? id}) async {
  //   var headers = {'Content-Type': 'application/json'};

   
  //   var queryParameters = {'q': '{http}', 'category_id': '$id'};
  //   var url = Uri.http(
  //       baseUrl, '/freshmarket/public/api/v1/product',  id != null ? queryParameters : {'q': '{http}'} );
  //   var response = await http.get(url);

  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     List data = jsonDecode(response.body)['data'];

  //     List<ProductModels> product = [];

  //     for (var item in data) {
  //       print(item);
  //       product.add(ProductModels.fromJson(item));
  //     }
  //     return product;
  //   } else {
  //     throw Exception('gagal mendapatkan data product');
  //   }
  // }
  Future<ApiResultList<ProductModels>> getProducts(int? categoryId,String? CityName) async {
   
    APIResponse response =
        await api.get(api.endpoint.products, param: {"category_id": categoryId,"city_name" : CityName});
    return ApiResultList<ProductModels>.fromJson(response.data,
        (data) => data.map((e) => ProductModels.fromJson(e)).toList(), "data");
  }



    Future<ApiResultList<ProductModels>> searchProducts(
      String keyword) async {
    APIResponse response =
        await api.get(api.endpoint.productSearch, param: {"q": keyword});
    return ApiResultList<ProductModels>.fromJson(
        response.data,
        (data) => data.map((e) => ProductModels.fromJson(e)).toList(),
        "data");
  }

}
