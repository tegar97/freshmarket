import 'package:flutter/material.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/storeModels.dart';
import 'package:freshmarket/models/transactionModels.dart';
import 'package:freshmarket/service/category_service.dart';
import 'package:freshmarket/service/store_service.dart';
import 'package:freshmarket/service/transaction_service.dart';

class TransactionProviders with ChangeNotifier {
  List<TransactionModels>? transactions = [];

  Future<void> getTransactions() async {
    try {
      List<TransactionModels> transaction =
          await transactionService().getAllTransaction();
      transactions = transaction;
    } catch (e) {
      print(e);
    }
  }

 
 
}
