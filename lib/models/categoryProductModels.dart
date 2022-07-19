import 'package:freshmarket/models/productModels.dart';

class CategoryProductModels {
  int? id;
  String? name;
  String? icon;
  List<ProductModels>? products;

  CategoryProductModels({this.name, this.id, this.products, this.icon});
  CategoryProductModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    products = List<ProductModels>.from(
        json["products"].map((x) => ProductModels.fromJson(x)));
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'icon': icon,         "products": List<dynamic>.from(products!.map((x) => x.toJson())),
    };
  }
}
