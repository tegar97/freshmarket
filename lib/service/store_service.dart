import 'dart:convert';

import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/storeModels.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StoreService {
  String baseUrl = "192.168.1.5";

  Future<storeModels> getNearArea() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '${token}'
    };
    var queryParameters = {'q': '{http}'};

    var url = Uri.http(
        baseUrl, '/freshmarket/public/api/v1/getNearOutlet', queryParameters);
    var response = await http.get(url,headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      storeModels store = storeModels.fromJson(data);

    
      return store;
    } else {
      throw Exception('gagal mendapatkan category');
    }
  }
}
