import 'package:flutter/material.dart';
import 'package:freshmarket/injection.dart';
import 'package:freshmarket/models/addressModels.dart';
import 'package:freshmarket/service/address_service.dart';
import 'package:provider/provider.dart';

class AddressProvider with ChangeNotifier {
  AddressModels? _address = AddressModels();
  bool isDisposed = false;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  /// List of category
  List<AddressModels>? _listAddress;
  List<AddressModels>? get listAddress => _listAddress;

  /// List of category
  bool? _isAvailable;
  bool? get isAvailable => _isAvailable;

  //Selected Address
  AddressModels? _selectedAddress;
  AddressModels? get selectedAddress => _selectedAddress;

  final addressService = locator<AddressService>();

  static AddressProvider instance(BuildContext context) =>
      Provider.of(context, listen: false);

  Future<void> getListAddress() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setOnSearch(true);

    try {
      print('cuakkssss');
      final result = await addressService.getAllAddress();
      print(
        'data now list address ==>  ${result.data}',
      );

      if (result.meta.code == 200) {
        _listAddress = result.data;
        notifyListeners();
      } else {
        _listAddress = null;
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _listAddress = null;
    }
    setOnSearch(false);
  }

  Future<void> getSelectedAddress() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setOnSearch(true);

    try {
      final result = await addressService.getSelectedAddress();
      print(
        'data now ==>  ${result.data}',
      );

      if (result.meta.code == 200) {
        _selectedAddress = result.data;
        notifyListeners();
      } else {
        _selectedAddress = null;
      }
    } catch (e, stacktrace) {
      _selectedAddress = null;
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
    }
    setOnSearch(false);
  }

  Future<void> addAddress(String? token, AddressModels? data) async {
    await Future.delayed(const Duration(milliseconds: 500));
    setOnSearch(true);

    try {
      setOnSearch(true);
      final result = await addressService.addAddress(token, data);
      print(
        'data now ==>  ${result.data}',
      );

      // if (result.meta.code == 200) {
      //   _listAddress = result.data;
      //   notifyListeners();
      // } else {
      //   _listAddress = [];
      // }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _listAddress = [];
    }
    setOnSearch(false);
  }

  Future<void> CheckCity(String? cityName) async {
    await Future.delayed(const Duration(milliseconds: 500));
    setOnSearch(true);

    try {
      setOnSearch(true);
      final result = await addressService.checkAddress(cityName);
      print(
        'data now new ==>  ${result.data?['data']}',
      );

      if (result.data?['data'] == true) {
        _isAvailable = true;
        notifyListeners();
      } else {
          _isAvailable = false;
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
    }
    setOnSearch(false);
  }

  void clearAddress() {
    _address = null;
    _listAddress = null;
    notifyListeners();
  }

  /// Set event search
  void setOnSearch(bool value) {
    _onSearch = value;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
