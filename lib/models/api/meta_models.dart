class MetaResponse{
  MetaResponse({
    this.status,
    this.message,
    this.code,
  });

  String? status;
  String? message;
  int? code;

  factory MetaResponse.fromJson(Map<String, dynamic> json) => MetaResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": code,
  };
}