import 'package:flutter/material.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/productModels.dart';
import 'package:freshmarket/models/recipeModels.dart';
import 'package:freshmarket/service/category_service.dart';
import 'package:freshmarket/service/product_service.dart';
import 'package:freshmarket/service/recipe_service.dart';

class RecipeProvider with ChangeNotifier {
  List<Recipe> _recipe = [];

  List<Recipe> get recipe => _recipe;
  set recipe(List<Recipe> recipe) {
    _recipe = recipe;
    notifyListeners();
  }

  Future<void> getRecipe() async {
    try {
      List<Recipe> recipe = await RecipeService().getRecipe();
      _recipe = recipe;
    } catch (e) {
      print(e);
    }
  }
}
