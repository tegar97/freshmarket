import 'package:freshmarket/models/productModels.dart';

class CategoryProductModels {
  int? id;
  String? name;
  String? icon;
  ProductModels? products;

  CategoryProductModels({this.name, this.id, this.products, this.icon});
  CategoryProductModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    products = json['bgColor'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'icon': icon, 'products': products};
  }
}
