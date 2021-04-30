import 'dart:convert';
import 'dart:developer';

import 'package:hobby_hub_ui/models/hobby_model.dart';

///{"userModel":{"id":"","username":"za","password":"12345678?","email":"zaidalsaid@gmail.com","firstName":"z","lastName":"a","gender":"male","currentLocation":null,"imageUrl":null,"usersFollowing":[],"followers":[],"hobbiesFollowing":[],"posts":[]}}
class User {
  final String id;
  final String name;
  String username;
  String email;
  String password;
  String firstName;
  String lastName;
  String gender;
  String location;
  List<String> hobbies = [];
  final String imgUrl;
  List<User> followers = [];
  List<User> following = [];

  User(
      {this.id,
      this.name,
      this.email,
      this.firstName,
      this.username,
      this.lastName,
      this.gender,
      this.location,
      this.hobbies,
      this.imgUrl,
      this.followers,
      this.following});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      imgUrl: json["image"],
      username: json["username"],
      location: json["location"],
      email: json["email"],
      gender: json["gender"],
      hobbies: List.from(json["hobbiesFollowing"]),
    );
  }
}

List<Hobby> _parseHobbies(String responseBody) {
  try {
    print(responseBody);
    var parseResponse = jsonDecode(responseBody);
    final parsed = parseResponse.cast<Map<String, dynamic>>();
    return parsed.map<Hobby>((json) => Hobby.fromJson(json)).toList();
  } catch (e) {
    print("JsonParser _parseHobbies error");
    print(e.toString());
    return [];
  }
}
