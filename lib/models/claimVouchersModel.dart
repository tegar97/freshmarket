class ClaimVouchersModel {
  final String token;
  final String Code;
  ClaimVouchersModel({
    required this.token,
    required this.Code,
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'code': Code,
    };
  }
}
