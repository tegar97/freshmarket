import 'package:flutter/material.dart';
import 'package:freshmarket/models/addressModels.dart';
import 'package:freshmarket/service/address_service.dart';

class AddressProvider with ChangeNotifier {
  AddressModels? _address = AddressModels(
     id: 0,
      label : '',
      districts : '',
      usersId: 0,
      fullAddress: '',
      province : '',
      city : '',
      phoneNumber : "",
      isMainAddress : 0,
      createdAt :"",
      updatedAt : ""
    
  );
  List<AddressModels> _listAddress = [];

  AddressModels get address => _address!;
  AddressModels get myAddress => _address!;
  List<AddressModels> get listAddress => _listAddress;
  set address(AddressModels address) {
    _address = address;
    notifyListeners();
  }

  set listAddress(List<AddressModels> listAddress) {
    _listAddress = listAddress;
    notifyListeners();
  }

  set myAddress(AddressModels myAddress) {
    _address = myAddress;
    notifyListeners();
  }

  Future<bool> addAddress(
      {String? label,
      String? province,
      String? city,
      String? districts,
      String? phoneNumber,
      bool? isMainAddress,
      String? street,
      String? longitude,
      String? latitude,
      String? fullAddress}) async {
    try {
      bool address = await AddressService().addAddress(
          province: province,
          phoneNumber: phoneNumber,
          districts: districts,
          city: city,
          isMainAddress: isMainAddress,
          fullAddress: fullAddress,
          label: label,
          latitude: latitude,
          longitude: longitude,
          street: street,);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getMyAddress() async {
    try {
      AddressModels myAddress = await AddressService().getMainAddress();
      _address = myAddress;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> getAllAddress() async {
    try {
      List<AddressModels> listAddress = await AddressService().getAllAddress();
      _listAddress = listAddress;
      print(_listAddress);
    } catch (e) {
      print(e);
    }
  }

  changeMainAaddress(AddressModels address) {
    try {
      myAddress = address;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> changeToDabase(int? id) async {
    try {
      AddressModels myAddress = await AddressService().changeMainAddress(id);
      _address = myAddress;

      return true;
    } catch (e) {
      return false;
    }
  }
}
