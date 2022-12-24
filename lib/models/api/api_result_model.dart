class ApiResult<T extends Serializable> {
  final MetaResponse meta;
  final T data;

  ApiResult({
    required this.meta,
    required this.data,
  });

  factory ApiResult.fromJson(
      Map<String, dynamic>? json, Function(Map<String, dynamic>) create, String field) {
    return ApiResult<T>(
      meta: MetaResponse.fromJson(json?['meta']),
         data: json?[field] != null && json?[field] is Map
          ? create(json?[field] ?? {})
          : create({}),
    );
  }

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": data.toJson(),
      };
}

class ApiResultList<T extends Serializable> {
  final MetaResponse meta;
  final List<T>? data;

  ApiResultList({
    required this.meta,
    required this.data,
  });

  factory ApiResultList.fromJson(
      Map<String, dynamic>? json , Function(List<dynamic>) build, String field) {
    print(json);
    if (json == null) {
      return ApiResultList<T>(
        meta: MetaResponse.fromJson(json?['meta']),
        data: [],
      );
    }
    return ApiResultList<T>(
      meta: MetaResponse.fromJson(json['meta']),
      data: json[field] != null && json[field] is List
          ? build(json?[field])
          : build([]),
    );
  }

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": data?.toList(),
      };
}

class MetaResponse {
  final int code;
  final String status;
  final String? message;

  MetaResponse({
    required this.code,
    required this.status,
    this.message,
  });

  factory MetaResponse.fromJson(Map<String, dynamic> json) {
    return MetaResponse(
      code: json['code'],
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
      };
}

abstract class Serializable {
  Map<String, dynamic> toJson();
}
