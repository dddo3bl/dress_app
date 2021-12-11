import 'package:http/http.dart' as http;
import 'package:flutter_app/moduls/storyanything.dart';
import 'dart:convert';

class FetchApi {
  Future<List<StoryModuel>> fetchStory() async {
    http.Response response = await http.get('http://10.0.2.2:4998');
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // print(body.runtimeType);
      List<StoryModuel> stories = [];
      for (var item in body) {
        stories.add(StoryModuel.fromJson(item));
        // print(item);
      }
      return stories;
    }
    return null;
  }
}
