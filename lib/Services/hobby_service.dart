import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hobby_hub_ui/models/hobby.dart';
import 'package:http/http.dart';

class HobbyService extends ChangeNotifier {
  Future<List<Hobby>> fetchHobbies() async {
    final url = "http://10.0.2.2:8080/api/hobbies";
    final response = await get(url);
    if (response.statusCode == 200) {
      List<Hobby> hobbiesList = [];
      final body = jsonDecode(response.body);
      for (var hobby in body) hobbiesList.add(Hobby.fromJson(hobby));

      return hobbiesList;
    } else {
      throw Exception("Unable to get hobbies!");
    }
  }

  Future<Hobby> fetchHobby(String hobbyName) async {
    final url = "http://10.0.2.2:8080/api/hobbies/$hobbyName";
    final response = await get(url);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return Hobby.fromJson(body);
    } else {
      throw Exception("Unable to get hobby!");
    }
  }
}
