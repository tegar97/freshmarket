import 'dart:convert';

import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/userModels.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  String baseUrl = apiUrl;

  Future<UserModels> register(
      {String? name, String? email, String? password}) async {
    var headers = {'Content-Type': 'application/json'};
    final prefs = await SharedPreferences.getInstance();

    var url = Uri.http(
        baseUrl, '/api/v1/register', {'q': '{http}'});

    var body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    });

    var response = await http.post(url, body: body, headers: headers);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      UserModels user = UserModels.fromJson(data['user']);
      user.token = 'Bearer ${data['token']['token']}';
      // user.token = 'Bearer ${UserModels.fromJson(data['token']['token'])}';
      prefs.setString('token', 'Bearer ${data['token']['token']}');
      prefs.setString('user', json.encode(data['user']));

      return user;
    } else {
      print("Error");

      throw Exception('Gagal register');
    }
  }
  Future<UserModels> login(
      {String? email, String? password}) async {
    var headers = {'Content-Type': 'application/json'};
    final prefs = await SharedPreferences.getInstance();

    var url = Uri.http(
        baseUrl, '/api/v1/login', {'q': '{http}'});

    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(url, body: body, headers: headers);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      UserModels user = UserModels.fromJson(data['user']);
      user.token = 'Bearer ${data['token']['token']}';
      // user.token = 'Bearer ${UserModels.fromJson(data['token']['token'])}';
      prefs.setString('token', 'Bearer ${data['token']['token']}');
      prefs.setString('user', json.encode(data['user']));

      return user;
    } else {
      print("Error");

      throw Exception('Gagal register');
    }
  }

  Future<UserModels> getMe() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var headers = {'Content-Type': 'application/json', 'Authorization': '${token}'};

    var url =
        Uri.http(baseUrl, '/api/v1/getMe', {'q': '{http}'});
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      UserModels user = UserModels.fromJson(data['user']);
      user.token = token;
      // user.token = 'Bearer ${UserModels.fromJson(data['token']['token'])}';
      prefs.setString('user', json.encode(data['user']));

      return user;
    } else {
      print("Error");

      throw Exception('Gagal register');
    }
  }
}
