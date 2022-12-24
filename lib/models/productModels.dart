import 'api/api_result_model.dart';

class ProductModels  extends Serializable {
  int? id;
  String? name;
  String? description;
  int? price;
  int? categoriesId;
  int? weight;
  String? productType;
  String? productExp;
  String? productCalori;
  String? image;
  String? createdAt;
  String? updatedAt;

  ProductModels(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.weight,
      this.productType,
      this.categoriesId,
      this.productExp,
      this.productCalori,
      this.createdAt,
      this.updatedAt,
      this.image});
  ProductModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    categoriesId = json['categories_id'];
    description = json['description'];
    weight = json['weight'];
    productType = json['product_type'];
    productExp = json['product_exp'];
    productCalori = json['product_calori'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'weight': weight,
      'product_type': productType,
      'product_exp': productExp,
      'product_calori': productCalori,
      'image': image,
      'created_at' : createdAt,
      'updated_at' : updatedAt
    };
  }
}
