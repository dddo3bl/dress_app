import 'package:http/http.dart' as http;
import 'package:flutter_app/moduls/storyoneuser.dart';
import 'dart:convert';

class FetchOneApi {
  Future<List<StoryoneModuel>> fetch_one_user() async {
    http.Response response = await http.get('http://10.0.2.2:4999');
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // print(body);
      List<StoryoneModuel> clint = [];
      for (var one in body) {
        clint.add(StoryoneModuel.fromJson(one));
        // print(one);
      }

      return clint;
    }
    return null;
  }
}
