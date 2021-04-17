import 'dart:convert';
import 'package:hobby_hub_ui/models/user.dart';
import 'package:hobby_hub_ui/network/res/endpoints.dart';
import 'package:http/http.dart' as http;

class UserApi {
  Future<User> getUser(String username) async {
    var request =
        http.Request('GET', Uri.parse('${Endpoints.userEndpoint}/$username'));
    request.headers.addAll(Endpoints.headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> signUp(User user) async {
    try {
      http.Request request = http.Request(
          'POST', Uri.parse("${Endpoints.host}${Endpoints.signUp}"));

      Map<String, String> body = {
        "username": user.firstName.trim() + user.lastName.trim(),
        "password": user.password.trim(),
        "email": user.email.trim(),
        "firstName": user.firstName.trim(),
        "lastName": user.lastName.trim(),
        "gender": "male",
      };
      request.body = jsonEncode(body);
      request.headers.addAll(Endpoints.headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (e) {
      print("UserApi signUp ERROR:$e");
      return;
    }
  }

  Future<bool> signIn(String username, String password) async {
    try {
      var request = http.Request(
          'POST', Uri.parse("${Endpoints.host}${Endpoints.signIn}"));
      Map<String, String> body = {
        "username": username.trim(),
        "password": password.trim()
      };
      request.body = jsonEncode(body);
      request.headers.addAll(Endpoints.headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        return false;
      }
    } on Exception catch (e) {
      print("UserApi signIn ERROR: $e");
      return false;
    }
  }

  Future<void> authenticateClient() async {
    try {
      var request = http.Request(
          'GET', Uri.parse('${Endpoints.host}${Endpoints.authenticateClient}'));
      request.headers.addAll(Endpoints.headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  void followUser(String username) async {
    try {
      http.Request request = http.Request(
          'PUT',
          Uri.parse(
              '${Endpoints.host}${Endpoints.userEndpoint}${Endpoints.followUser}'));
      request.body = jsonEncode({"username": username});
      request.headers.addAll(Endpoints.headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  void unFollowUser(String username) async {
    try {
      http.Request request = http.Request(
          'PUT',
          Uri.parse(
              '${Endpoints.host}${Endpoints.userEndpoint}${Endpoints.unFollowUser}'));
      request.body = jsonEncode({"username": username});
      request.headers.addAll(Endpoints.headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  void followHobby(String hobbyName) async {
    try {
      var request = http.Request(
          'PUT',
          Uri.parse(
              '${Endpoints.host}${Endpoints.userEndpoint}${Endpoints.followHobby}'));
      request.body = jsonEncode({"name": hobbyName});
      request.headers.addAll(Endpoints.headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  void unFollowHobby(String hobbyName) async {
    try {
      var request = http.Request(
          'PUT',
          Uri.parse(
              '${Endpoints.host}${Endpoints.userEndpoint}${Endpoints.unFollowHobby}'));
      request.body = jsonEncode({"name": hobbyName});
      request.headers.addAll(Endpoints.headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }
}
