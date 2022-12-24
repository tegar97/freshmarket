import 'dart:convert';

import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/productModels.dart';
import 'package:freshmarket/models/recipeModels.dart';
import 'package:http/http.dart' as http;

class RecipeService {
  String baseUrl = apiUrl;

  Future<List<Recipe>> getRecipe({int? id}) async {
    var headers = {'Content-Type': 'application/json'};

    var url =
        Uri.http(baseUrl, '/api/v1/recipe', {'q': '{http}'});
    var response = await http.get(url);

    if (response.statusCode == 200) {
     var data = jsonDecode(response.body)['data'];

      List<Recipe> recipe = [];

      for (var item in data) {
        recipe.add(Recipe.fromJson(item));
      }
      return recipe;
    } else {
      throw Exception('gagal mendapatkan data recipe');
    }
  }
}
