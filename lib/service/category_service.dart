import 'dart:convert';

import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  String baseUrl = apiUrl;

  Future<List<CategoryModels>> getCategory() async {
    var headers = {'Content-Type': 'application/json'};

    var url =  Uri.http(baseUrl, '/freshmarket/public/api/v1/category', {'q': '{http}'});
    var response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];

      List<CategoryModels> categories = [];

      for (var item in data) {
        categories.add(CategoryModels.fromJson(item));
      }
      return categories;
    } else {
      throw Exception('gagal mendapatkan category');
    }
  }
}
