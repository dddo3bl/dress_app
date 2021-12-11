import 'dart:convert';
import 'package:flutter_app/moduls/storecategory.dart';
import 'package:http/http.dart' as http;

class FetchFabrics {
  Future<List<StoreCategory>> fetc_fabrics() async {
    print("ok");
    http.Response response = await http
        .get('http://10.0.2.2:3000/newclint/fabrics', headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      print(body);
      List<StoreCategory> clint = [];
      for (var one in body) {
        clint.add(StoreCategory.fromJson(one));
        print(one);
      }
      return clint;
    }
    return null;
  }
}
