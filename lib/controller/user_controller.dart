import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:hobby_hub_ui/app_maneger.dart';
import 'package:hobby_hub_ui/controller/pos_controller.dart';
import 'package:hobby_hub_ui/db/token_db.dart';
import 'package:hobby_hub_ui/models/message_model.dart';
import 'package:hobby_hub_ui/models/user_model.dart';
import 'package:hobby_hub_ui/network/user_api.dart';
import 'package:hobby_hub_ui/service/upload_image_service.dart';

class UserController with ChangeNotifier {
  static User _currentUser;

  UserController._internal();

  static final UserController _userController = UserController._internal();

  factory UserController() {
    return _userController;
  }

  List<Message> messages = [];

  Future<bool> signUp(User user, File image) async {
    try {
      if (image != null)
        user.imgUrl =
            await UploadImageService.uploadImage(user.username, image.path);
      Map<String, dynamic> response = await UserApi().signUp(user);
      print(response);
      String token = response["token"];
      if (token != null && token.isNotEmpty) {
        saveUserToken(token);
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateUser(User user, File image) async {
    try {
      if (image != null)
        user.imgUrl =
            await UploadImageService.uploadImage(user.username, image.path);
      return UserApi().updateUser(user);
    } catch (e) {
      print(e);
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
      print(e);
      return false;
    }
  }

  String getUserToken() {
    try {
      return TokenDB().getUserToken();
    } catch (e) {
      print(e);
      return null;
    }
  }

  void saveUserToken(String token) {
    try {
      TokenDB().saveUserToken(token);
    } catch (e) {
      print(e);
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

  void setCurrentUser(User user) {
    _currentUser = user;
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

  Future<List<User>> getUserFollowing() async {
    try {
      return _parseUsers(await UserApi().getUserFollowing());
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

  List<Message> _parseMessages(String res) {
    try {
      Iterable itr = json.decode(res);
      return List<Message>.from(itr.map((model) => Message.fromJson(model)));
    } catch (e) {
      print("JsonParser _parseUsers error");
      print(e.toString());
      return [];
    }
  }

  Future<void> getChatMessages(String receiverId) async {
    messages = _parseMessages(
        await UserApi().getMessages(_currentUser.username, receiverId));
    notifyListeners();
    return;
  }

  void listenToNewMessages() {
    if (true) {
      ApplicationManager().socketService.socket.on("newPrivateMessage", (v) {
        Map<String, dynamic> json = v as Map<String, dynamic>;
        print('value:$v');
        messages.add(Message.fromJson(json));
        notifyListeners();
      });
    }
  }

  void sendMessage(String body, String senderId, String receiverId) {
    print('send');
    ApplicationManager()
        .socketService
        .sendTextMessage(body, senderId, receiverId);
    notifyListeners();
  }

  void joinPrivate(String receiverId) {
    ApplicationManager()
        .socketService
        .joinPrivate(_currentUser.username, receiverId);
  }

  bool isFollowing(String username) {
    return _currentUser.following.contains(username);
  }
}
