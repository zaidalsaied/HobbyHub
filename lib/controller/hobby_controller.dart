import 'dart:convert';
import 'dart:developer';

import 'package:hobby_hub_ui/models/hobby_model.dart';
import 'package:hobby_hub_ui/network/hobby_api.dart';

class HobbyController {
  List<Hobby> parseHobbies(String res) {
    Iterable itr = json.decode(res);
    return List<Hobby>.from(itr.map((model) => Hobby.fromJson(model)));
  }

  Future<List<Hobby>> getAllHobbies() async {
    String res = await HobbyApi().getAllHobbies();
    return parseHobbies(res);
  }
}
