import 'package:flutter/material.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/userModels.dart';
import 'package:freshmarket/service/category_service.dart';
import 'package:freshmarket/service/user_service.dart';

class UsersProvider with ChangeNotifier {
  UserModels? _users = UserModels(
    id: 0,
    name: '',
    email: '',
    token: '',
    avatar: '',
    password: ''
  );

  UserModels get users => _users!;
  set users(UserModels categories) {
    _users = users;
    notifyListeners();
  }

  Future<bool> register({String? name, String? email, String? password}) async {
    try {
      UserModels users = await UserService()
          .register(name: name, email: email, password: password);
      _users = users;
      print(_users);
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> login({String? name, String? email, String? password}) async {
    try {
      UserModels users = await UserService()
          .login( email: email, password: password);
      _users = users;
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> getMe() async {
    try {
      UserModels users = await UserService()
          .getMe();
      _users = users;
      print(_users);
      return true;
    } catch (e) {
      return false;
    }
  }
}
