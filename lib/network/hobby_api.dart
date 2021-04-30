import 'dart:developer';

import 'package:hobby_hub_ui/network/res/endpoints.dart';
import 'package:http/http.dart' as http;

class HobbyApi {
  Future<String> getAllHobbies() async {
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${Endpoints.host}${Endpoints.hobbyEndpoint}${Endpoints.getAllHobbies}'));
      request.headers.addAll(Endpoints.authorizedHeaders);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        return await response.stream.bytesToString();
      } else {
        return "";
      }
    } catch (e) {
      print(e);
      return "";
    }
  }
}
