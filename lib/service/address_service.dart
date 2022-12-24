import 'dart:convert';

import 'package:freshmarket/config/api/base_api.dart';
import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/models/addressModels.dart';
import 'package:freshmarket/models/api/api_response.dart';
import 'package:freshmarket/models/api/api_result_model.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddressService {
  BaseAPI api;
  AddressService(this.api);

  Future<ApiResultList<AddressModels>> addAddress(
      String? token, AddressModels? data) async {
    APIResponse response = await api.post(api.endpoint.address,
        token: token, useToken: true, data: data);
    print('Meta ${response.data}');

    return ApiResultList<AddressModels>.fromJson(response.data,
        (data) => data.map((e) => AddressModels.fromJson(e)).toList(), 'data');
  }

  Future<ApiResultList<AddressModels>> getAllAddress() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    APIResponse response =
        await api.get(api.endpoint.address, token: token, useToken: true);
    print('all address ${response.data}');
    return ApiResultList<AddressModels>.fromJson(response.data,
        (data) => data.map((e) => AddressModels.fromJson(e)).toList(), 'data');
  }

  Future<ApiResult<AddressModels>> getSelectedAddress() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    APIResponse response = await api.get(api.endpoint.selectedAddress,
        token: token, useToken: true);
    print('alamat ${response.data}');

    if (response.data == null) {
      return ApiResult<AddressModels>.fromJson(
          response.data, (data) => AddressModels.fromJson({}), 'data');
    }
    return ApiResult<AddressModels>.fromJson(
        response.data, (data) => AddressModels.fromJson(data), 'data');
  }

  Future<APIResponse> checkAddress(String? cityName) async {
   
    APIResponse response =
        await api.get(api.endpoint.checkCity, param: {'city_name': cityName});

    return response;
  }

  // Future<AddressModels> getSelectedAddress() async {
  //   var url = Uri.http(
  //       baseUrl, '/freshmarket/public/api/v1/mainAddress', {'q': '{http}'});
  //   final prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('token');
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': '$token'
  //   };

  //   var response = await http.get(url, headers: headers);
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);

  //     AddressModels address = AddressModels.fromJson(data['data']);

  //     return address;
  //   } else {
  //     throw Exception('gagal mendapatkan alamat');
  //   }
}

  // Future<AddressModels> changeMainAddress(int? id) async {
  //   var url = Uri.http(baseUrl, '/freshmarket/public/api/v1/ChangeMainAddress',
  //       {'q': '{http}'});
  //   final prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('token');
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': '${token}'
  //   };
  //   var body = jsonEncode({
  //     'newAddress': id,
  //   });

  //   var response = await http.post(url, body: body, headers: headers);
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);

  //     AddressModels address = AddressModels.fromJson(data['data']);

  //     return address;
  //   } else {
  //     throw Exception('gagal mendapatkan alamat');
  //   }
  // }

