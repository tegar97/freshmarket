import 'package:freshmarket/models/api/api_result_model.dart';

class AddressModels  extends Serializable {
  int? id;
  int? usersId;
  String? fullAddress;
  String? province;
  String? label;
  String? city;
  String? districts;
  String? phoneNumber;
  String? street;
  String? latitude;
  String? longitude;
  int? isMainAddress;

  String? createdAt;
  String? updatedAt;

  AddressModels(
      {this.id,
      this.usersId,
      this.fullAddress,
      this.province,
      this.label,
      this.city,
      this.districts,
      this.phoneNumber,
      this.isMainAddress,
      this.street,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt});
  AddressModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    label = json['label'];
    fullAddress = json['fullAddress'];
    province = json['province'];
    city = json['city'];
    districts = json['districts'];
    phoneNumber = json['phoneNumber'];
    isMainAddress = json['isMainAddress'];
    street = json['street'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'districts': districts,
      'users_id': usersId,
      'fullAddress': fullAddress,
      'province': province,
      'city': city,
      'phoneNumber': phoneNumber,
      'isMainAddress': isMainAddress,
      'street' : street,
      'latitude' : latitude,
      'longitude' : longitude,
      'created_at': createdAt,
      'update_at': updatedAt
    };
  }
}
