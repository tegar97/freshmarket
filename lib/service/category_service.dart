import 'dart:convert';
import 'package:freshmarket/config/api/base_api.dart';
import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/models/api/api_response.dart';
import 'package:freshmarket/models/api/api_result_model.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class CategoryService {
  BaseAPI api;
  CategoryService(this.api);

  Future<ApiResultList<CategoryModels>> getCategory() async {
    APIResponse response = await api.get(api.endpoint.getCategory);

    return ApiResultList<CategoryModels>.fromJson(
        response.data,
        (data) => data.map((e) => CategoryModels.fromJson(e)).toList(),
        'data');

    // var headers = {'Content-Type': 'application/json'};

    // var url =  Uri.http(baseUrl, '/freshmarket/public/api/v1/category', {'q': '{http}'});
    // var response = await http.get(url);

    // if (response.statusCode == 200) {
    //   List data = jsonDecode(response.body)['data'];

    //   List<CategoryModels> categories = [];

    //   for (var item in data) {
    //     categories.add(CategoryModels.fromJson(item));
    //   }
    //   return categories;
    // } else {
    //   throw Exception('gagal mendapatkan category');
    // }
  }
}
