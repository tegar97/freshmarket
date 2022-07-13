import 'package:freshmarket/models/productModels.dart';

class CartModels {
  int? id;
  ProductModels? product;
  int? quantity;
  int? total;

  CartModels({this.id, this.product, this.quantity,this.total});
  CartModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductModels.fromJson(json['product']);
    quantity = json['qty'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product,
      'quantity': quantity,
    };
  }

  getTotalPrice() {
    return product!.price !* quantity!;
  }
}
