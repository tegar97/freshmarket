import 'dart:convert';

import 'package:freshmarket/config/api/base_api.dart';
import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/models/VoucherModels.dart';
import 'package:freshmarket/models/api/api_response.dart';
import 'package:freshmarket/models/api/api_result_model.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/categoryProductModels.dart';
import 'package:http/http.dart' as http;

class VoucherService {
  BaseAPI api;
  VoucherService(this.api);

  Future<ApiResultList<VoucherModels>> getAvailableVoucher() async {
    APIResponse response = await api.get(api.endpoint.getVoucher);

    return ApiResultList<VoucherModels>.fromJson(response.data,
        (data) => data.map((e) => VoucherModels.fromJson(e)).toList(), 'data');
  }

  Future<ApiResultList<VoucherModels>> claimVoucher(
      String? token, String? code) async {
    APIResponse response = await api.post(api.endpoint.claimVoucher,
        token: token, useToken: true, data: {'code': code});
    print('Meta ${response.data}');

    return ApiResultList<VoucherModels>.fromJson(response.data,
        (data) => data.map((e) => VoucherModels.fromJson(e)).toList(), 'data');
  }

  Future<ApiResultList<VoucherModels>> myVoucher(String? token) async {
    print(token);
    APIResponse response =
        await api.get(api.endpoint.myVoucher, useToken: true, token: token);

    var getVoucher = response.data;
    print(getVoucher);
    return ApiResultList<VoucherModels>.fromJson(
        getVoucher,
        (data) => data.map((e) => VoucherModels.fromJson(e)).toList(),
        'data');
  }
}
