import 'package:freshmarket/models/productModels.dart';

class Recipe {
  Recipe({
    this.id,
    this.title,
    this.description,
    this.image,
    this.calori,
    this.level,
    this.estimateTime,
    this.step,

    this.recipeItem,
  });

  int? id;
  String? title;
  String? description;
  String? image;
  String? calori;
  String? level;
  String? estimateTime;
  String? step;

  List<RecipeItem>? recipeItem;

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        calori: json["calori"],
        level: json["level"],
        estimateTime: json["estimateTime"],
        step: json["step"],

        recipeItem: List<RecipeItem>.from(
            json["recipe_item"].map((x) => RecipeItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "calori": calori,
        "level": level,
        "estimateTime": estimateTime,
        'step' : step,
        "recipe_item": List<dynamic>.from(recipeItem!.map((x) => x.toJson())),
      };
}

class RecipeItem {
  RecipeItem({
    this.id,
    this.qty,
    this.productsId,

    this.product,
  });

  int? id;
  int? qty;
  int? productsId;

  ProductModels? product;

  factory RecipeItem.fromJson(Map<String, dynamic> json) => RecipeItem(
        id: json["id"],
        qty: json["qty"],
        productsId: json["products_id"],
        product: ProductModels.fromJson(json['product'])
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "qty": qty,
        "products_id": productsId,
        "product": product!.toJson(),
      };
}
