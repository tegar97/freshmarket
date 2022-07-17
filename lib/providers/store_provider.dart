import 'package:flutter/material.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/storeModels.dart';
import 'package:freshmarket/service/category_service.dart';
import 'package:freshmarket/service/store_service.dart';

class StoreProvider with ChangeNotifier {
  storeModels? _store = storeModels(
    name: '',
    distance: 0,
    id:0,
  );

  storeModels get store => _store!;
  set store(storeModels store) {
    _store = store;
    notifyListeners();
  }

  Future<void> getNearStore() async {
    try {
      storeModels store = await StoreService().getNearArea();
      _store = store;
    } catch (e) {
      print(e);
    }
  }
}
