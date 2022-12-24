import 'package:freshmarket/models/api/api_result_model.dart';

class VoucherModels extends Serializable {
  int? id;
  String? code;
  String? voucherDescription;
  int? discountPercetange;
  int? minOrder;
  int? maxDiscount;
  int? maxUse;
  String? voucherType;
  int? useCount;
  String? expiredAt;
  String? createdAt;
  String? updatedAt;

  VoucherModels(
      {this.id,
      this.code,
      this.voucherDescription,
      this.discountPercetange,
      this.minOrder,
      this.maxDiscount,
      this.maxUse,
      this.voucherType,
      this.useCount,
      this.expiredAt,
      this.createdAt,
      this.updatedAt});

  VoucherModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    voucherDescription = json['voucher_description'];
    discountPercetange = json['discount_percetange'];
    minOrder = json['min_order'];
    maxDiscount = json['max_discount'];
    maxUse = json['max_use'];
    voucherType = json['voucher_type'];
    useCount = json['use_count'];
    expiredAt = json['expired_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['voucher_description'] = this.voucherDescription;
    data['discount_percetange'] = this.discountPercetange;
    data['min_order'] = this.minOrder;
    data['max_discount'] = this.maxDiscount;
    data['max_use'] = this.maxUse;
    data['voucher_type'] = this.voucherType;
    data['use_count'] = this.useCount;
    data['expired_at'] = this.expiredAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
