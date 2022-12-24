import 'package:freshmarket/models/api/api_result_model.dart';
import 'package:freshmarket/models/productModels.dart';

class CategoryProductModels  extends Serializable{
  int? id;
  String? title;
  // String? icon;
  List<ProductModels>? products;

  CategoryProductModels({this.title, this.id, this.products});
  CategoryProductModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    products = List<ProductModels>.from(
        json["products"].map((x) => ProductModels.fromJson(x)));
   
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title,         "products": List<dynamic>.from(products!.map((x) => x.toJson())),
    };
  }
}
