import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hobby_hub_ui/models/hobby_model.dart';
import 'package:hobby_hub_ui/network/hobby_api.dart';

class HobbyController with ChangeNotifier{
  static List<Hobby> hobbies = [];

  HobbyController._internal();

  static final HobbyController _hobbyController = HobbyController._internal();

  factory HobbyController() {
    return _hobbyController;
  }
  List<Hobby> parseHobbies(String res) {
    Iterable itr = json.decode(res);
    return List<Hobby>.from(itr.map((model) => Hobby.fromJson(model)));
  }

  Future<List<Hobby>> getAllHobbies() async {
    String res = await HobbyApi().getAllHobbies();
    hobbies = parseHobbies(res);
    return hobbies;
  }
}
