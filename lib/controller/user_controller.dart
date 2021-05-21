import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:hobby_hub_ui/controller/pos_controller.dart';
import 'package:hobby_hub_ui/db/token_db.dart';
import 'package:hobby_hub_ui/helper/stack_trace_helper.dart';
import 'package:hobby_hub_ui/models/user_model.dart';
import 'package:hobby_hub_ui/network/user_api.dart';
import 'package:hobby_hub_ui/service/upload_image_service.dart';

class UserController {
  static User _currentUser;

  UserController._internal();

  static final UserController _userController = UserController._internal();

  factory UserController() {
    return _userController;
  }

  Future<bool> signUp(User user, File image) async {
    try {
      if (image != null)
        user.imgUrl = await UploadImageService.uploadImage(
            user.firstName + user.lastName, image.path);
      Map<String, dynamic> response = await UserApi().signUp(user);
      print(response);
      String token = response["token"];
      if (response != null && token.isNotEmpty) {
        saveUserToken(token);
        return true;
      }
      return false;
    } catch (e) {
      print(LoggerStackTrace.from(StackTrace.current).print(e.toString()));
      return false;
    }
  }

  Future<bool> signIn(String email, password) async {
    try {
      Map<String, dynamic> response = await UserApi().signIn(email, password);
      print(response);
      String token = response["token"];
      if (token != null && token.isNotEmpty) {
        _currentUser = User.fromJson(response["userModel"]);
        saveUserToken(token);
        return true;
      }
      return false;
    } catch (e) {
      print(LoggerStackTrace.from(StackTrace.current).print(e.toString()));
      return false;
    }
  }

  String getUserToken() {
    try {
      return TokenDB().getUserToken();
    } catch (e) {
      print(LoggerStackTrace.from(StackTrace.current).print(e.toString()));
      return null;
    }
  }

  void saveUserToken(String token) {
    try {
      TokenDB().saveUserToken(token);
    } catch (e) {
      print(LoggerStackTrace.from(StackTrace.current).print(e.toString()));
      return;
    }
  }

  Future<bool> authenticateToken() async {
    try {
      Map<String, dynamic> res = await UserApi().authenticateClient();
      if (res != null && res["userModel"] != null) {
        _currentUser = User.fromJson(res["userModel"]);
        log(_currentUser.toString());
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  User get currentUser {
    return _currentUser;
  }

  Future<void> getCurrentUser() async {
    _currentUser = await UserApi().getUser(_currentUser.username);
  }

  Future<User> getUserByUsername(String username) async {
    return await UserApi().getUser(username);
  }

  Future<bool> followHobby(String hobbyName) async {
    try {
      return await UserApi().followHobby(hobbyName);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> unfollowHobby(String hobbyName) async {
    try {
      return await UserApi().unFollowHobby(hobbyName);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> followUser(String username) async {
    try {
      await UserApi().followUser(username);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> unfollowUser(String username) async {
    try {
      await UserApi().unFollowUser(username);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updateUserLocation(String lat, String long) async {
    await UserApi().updateUserLocation(lat, long);
  }

  Future<List<String>> getUserFollowingLocation() async {
    try {
      List<User> users = _parseUsers(await UserApi().getUserFollowing());
      List<String> locations = [];
      for (User user in users)
        if (user.location != null) locations.add(user.location);
      return locations;
    } catch (e) {
      return [];
    }
  }

  void logout() {
    PostController.feed = [];
    PostController.trending = [];
    TokenDB().clearUserToken();
  }

  List<User> _parseUsers(String res) {
    try {
      Iterable itr = json.decode(res);
      return List<User>.from(itr.map((model) => User.fromJson(model)));
    } catch (e) {
      print("JsonParser _parseUsers error");
      print(e.toString());
      return [];
    }
  }
}
