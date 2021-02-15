import 'dart:convert';
import 'package:hobby_hub_ui/models/user.dart';
import 'package:http/http.dart';

class UserService {
  Future<User> getUserById(String userId) async {
    final url = "http://www.hobbyHub.com/users/$userId";
    Map<String, String> headers = {"Content-type": "application/json"};
    Response response = await get(url);
    final body = jsonDecode(response.body);
    User user = User.fromJson(body);
    if (response.statusCode == 200) {
      return user;
    } else {
      throw Exception("Unable to get user!");
    }
  }

  Future<bool> addUser(User user) async {
    final url = "http://www.hobbyHub.com/users";
    Map<String, String> headers = {"Content-type": "application/json"};
    Response response = await post(url, headers: headers, body: user);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Unable to create new user!");
    }
  }

  Future<bool> updateUser(User user) async {
    final url = "http://www.hobbyHub.com/users";
    Map<String, String> headers = {"Content-type": "application/json"};
    Response response = await put(url, headers: headers, body: user);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Unable to update user!");
    }
  }

  Future<User> getUserByEmail(String userEmail) async {
    final url = "http://www.hobbyHub.com/users/$userEmail";
    final response = await get(url);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final User user = User.fromJson(body);
      return user;
    } else {
      throw Exception("Unable to find user!");
    }
  }
}
