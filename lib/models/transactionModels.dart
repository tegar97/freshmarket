class TransactionModels {
  int? id;
  String? invoice;
  int? amount;
  int? status;

  TransactionModels({this.invoice, this.id, this.amount,this.status});
  TransactionModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoice = json['invoice'];
    amount = json['amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'invoice': invoice, 'amount': amount,'status' : status};
  }
}
