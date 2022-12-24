import 'package:freshmarket/models/api/meta_models.dart';

class APIResponse {
  final MetaResponse meta;
  final Map<String, dynamic>? data;

  APIResponse({
    required this.meta,
    required this.data,
  });

  factory APIResponse.fromJson(Map<String, dynamic> json) {
    return APIResponse(
      meta:  MetaResponse.fromJson(json['meta']),
      data: json['data'],
    );
  }

  factory APIResponse.failure(int code,String message,String status) => APIResponse(meta: MetaResponse(code: code,message: message,status: status) , data: {});
}
