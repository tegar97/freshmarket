import 'dart:convert';

import 'package:freshmarket/models/addressModels.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddressService {
  String baseUrl = "192.168.1.5";

  Future<bool> addAddress(
      {String? label,
      String? province,
      String? city,
      String? districts,
      String? phoneNumber,
      bool? isMainAddress,
      String? street,
      String? latitude,
      String? longitude,
      String? fullAddress}) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '$token'
    };

    var url = Uri.http(
        baseUrl, '/freshmarket/public/api/v1/address', {'q': '{http}'});
    print(isMainAddress);
    var body = jsonEncode({
      'label': label,
      'fullAddress': fullAddress,
      'province': province,
      'city': city,
      'districts': districts,
      'phoneNumber': phoneNumber,
      'isMainAddress': isMainAddress,
      'street' : street,
      'latitude' : latitude,
      'longitude' : longitude
    });
    print(body);

    var response = await http.post(url, body: body, headers: headers);
    print(response);
    if (response.statusCode == 200) {
      return true;
    } else {
      print("Error");

      return false;
    }
  }

  Future<List<AddressModels>> getAllAddress() async {
    var url = Uri.http(
        baseUrl, '/freshmarket/public/api/v1/address', {'q': '{http}'});
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '$token'
    };

    var response = await http.get(url, headers: headers);
    print(response);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];

      List<AddressModels> address = [];

      for (var item in data) {
        address.add(AddressModels.fromJson(item));
      }
      print(address.length);
      return address;
    } else {
      throw Exception('gagal mendapatkan category');
    }
  }

  Future<AddressModels> getMainAddress() async {
    print('yay');
    var url = Uri.http(
        baseUrl, '/freshmarket/public/api/v1/mainAddress', {'q': '{http}'});
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '$token'
    };

    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      AddressModels address = AddressModels.fromJson(data['data']);

      return address;
    } else {
      throw Exception('gagal mendapatkan alamat');
    }
  }

  Future<AddressModels> changeMainAddress(int? id) async {
    print(id);
    var url = Uri.http(baseUrl, '/freshmarket/public/api/v1/ChangeMainAddress',
        {'q': '{http}'});
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '${token}'
    };
    var body = jsonEncode({
      'newAddress': id,
    });
    print(body);

    print('TES');
    var response = await http.post(url, body: body, headers: headers);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      AddressModels address = AddressModels.fromJson(data['data']);

      return address;
    } else {
      throw Exception('gagal mendapatkan alamat');
    }
  }
}
