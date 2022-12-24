class TransactionModels {
  int? id;
  String? invoice;
  String? deliveryType;
  int? amount;
  int? status;

  TransactionModels({this.invoice, this.id, this.amount,this.deliveryType,this.status});
  TransactionModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoice = json['invoice'];
    amount = json['amount'];
    deliveryType = json['delivery_type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'invoice': invoice, 'amount': amount,'delivery_type': deliveryType, 'status' : status};
  }
}
