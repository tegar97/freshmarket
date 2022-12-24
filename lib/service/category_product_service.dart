import 'dart:convert';

import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/models/api/api_response.dart';
import 'package:freshmarket/models/api/api_result_model.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/categoryProductModels.dart';
import 'package:http/http.dart' as http;
import 'package:freshmarket/config/api/base_api.dart';

class CategoryProductService {
  BaseAPI api;
  CategoryProductService(this.api);


  Future<ApiResultList<CategoryProductModels>> getCategoriesProduct(String? CityName) async {
      print('Response now == ${CityName}');

    APIResponse response = await api.get(api.endpoint.getTagProduct,
        param: {"name": CityName});
  
    return ApiResultList<CategoryProductModels>.fromJson(response.data,
        (data) => data.map((e) => CategoryProductModels.fromJson(e)).toList(), 'data');
  }
  // Future<List<CategoryProductModels>> getCategory() async {
  //   var headers = {'Content-Type': 'application/json'};

  //   var url = Uri.http(
  //       baseUrl, '/freshmarket/public/api/v1/showCategoryWithProduct', {'q': '{http}'});
  //   var response = await http.get(url);
  //   print(response.body);

  //   if (response.statusCode == 200) {
  //     List data = jsonDecode(response.body)['data'];

  //     List<CategoryProductModels> categories = [];

  //     for (var item in data) {
  //       categories.add(CategoryProductModels.fromJson(item));
  //     }
  //     return categories;
  //   } else {
  //     throw Exception('gagal mendapatkan category');
  //   }
  // }
}
