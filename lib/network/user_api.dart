import 'dart:convert';
import 'dart:developer';
import 'package:hobby_hub_ui/models/user_model.dart';
import 'package:hobby_hub_ui/network/res/endpoints.dart';
import 'package:http/http.dart' as http;

class UserApi {
  Future<User> getUser(String username) async {
    try {
      print(username);
      var request = http.Request('GET',
          Uri.parse('${Endpoints.host}${Endpoints.userEndpoint}/$username'));
      request.headers.addAll(Endpoints.authorizedHeaders);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(await response.stream.bytesToString()));
      } else {
        print(response.reasonPhrase);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>> signUp(User user) async {
    try {
      http.Request request = http.Request(
          'POST', Uri.parse("${Endpoints.host}${Endpoints.signUp}"));

      Map<String, String> body = {
        "username": user.username.trim(),
        "password": user.password.trim(),
        "email": user.email.trim(),
        "imageUrl": user.imgUrl.trim(),
        "firstName": user.firstName.trim(),
        "lastName": user.lastName.trim(),
        "gender": "male",
      };
      request.body = jsonEncode(body);
      request.headers.addAll(Endpoints.headers);

      http.StreamedResponse response = await request.send();
      return jsonDecode(await response.stream.bytesToString());
    } on Exception catch (e) {
      print("UserApi signUp ERROR:$e");
      return null;
    }
  }

  Future<Map<String, dynamic>> signIn(String username, String password) async {
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
      return jsonDecode(await response.stream.bytesToString());
    } on Exception catch (e) {
      print("UserApi signIn ERROR: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>> authenticateClient() async {
    try {
      var request = http.Request(
          'GET', Uri.parse('${Endpoints.host}${Endpoints.authenticateClient}'));

      request.headers.addAll(Endpoints.authorizedHeaders);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        return jsonDecode(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> followUser(String username) async {
    try {
      http.Request request = http.Request(
          'PUT',
          Uri.parse(
              '${Endpoints.host}${Endpoints.userEndpoint}${Endpoints.followUser}'));
      request.body = jsonEncode({"username": username});
      request.headers.addAll(Endpoints.authorizedHeaders);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> unFollowUser(String username) async {
    try {
      http.Request request = http.Request(
          'PUT',
          Uri.parse(
              '${Endpoints.host}${Endpoints.userEndpoint}${Endpoints.unFollowUser}'));
      request.body = jsonEncode({"username": username});
      request.headers.addAll(Endpoints.authorizedHeaders);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> followHobby(String hobbyName) async {
    try {
      var request = http.Request(
          'PUT',
          Uri.parse(
              '${Endpoints.host}${Endpoints.userEndpoint}${Endpoints.followHobby}'));
      request.body = jsonEncode({"name": hobbyName});
      request.headers.addAll(Endpoints.authorizedHeaders);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> unFollowHobby(String hobbyName) async {
    try {
      var request = http.Request(
          'PUT',
          Uri.parse(
              '${Endpoints.host}${Endpoints.userEndpoint}${Endpoints.unFollowHobby}'));
      request.body = jsonEncode({"name": hobbyName});
      request.headers.addAll(Endpoints.authorizedHeaders);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updateUserLocation(String lat, String long) async {
    try {
      var request = http.Request(
          'PUT',
          Uri.parse(
              '${Endpoints.host}${Endpoints.userEndpoint}${Endpoints.location}'));
      request.body = '$lat,$long';
      request.headers.addAll(Endpoints.authorizedHeaders);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print("hello");
        print(await response.stream.bytesToString());
      } else {
        print("no");
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getUserFollowing() async {
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${Endpoints.host}${Endpoints.userEndpoint}/${Endpoints.following}'));
      request.headers.addAll(Endpoints.authorizedHeaders);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print("ok");
        return await response.stream.bytesToString();
      } else {
        print("no");
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
