class PaymentDataModels {
  int? amount;
  int? expireUnix;
  String? expireStr;
  String? serviceName;
  String? paymentKey;
  String? paymentCode;
  int? status;

  PaymentDataModels({
    this.amount,
    this.expireStr,
    this.expireUnix,
    this.paymentKey,
    this.paymentCode,
    this.status,
  });
  PaymentDataModels.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    expireUnix = json['expire_time_unix'];
    expireStr = json['expire_time_str'];
    serviceName = json['service_name'];
    status = json['payment_status'];
    paymentKey = json['payment_key'];
    paymentCode = json['payment_code'];
  }
  Map<String, dynamic> toJson() {
    return {
        "amount": amount,
      "expire_time_unix": expireUnix,
      "expire_time_str": expireStr,
      "service_name": serviceName,
      "payment_status": status,
      "payment_key": paymentKey ,
      "payment_code": paymentCode
    };
  }
}
