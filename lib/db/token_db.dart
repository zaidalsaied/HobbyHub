import 'package:hive/hive.dart';

class TokenDB {
  static var tokenDb;

  void openTokenBox() async {
    try {
      tokenDb = await Hive.openBox<String>("tokenDb");
    } on Exception catch (e) {
      print("UserDB openTokenBox ERROR:$e");
      return;
    }
  }

  void saveUserToken(String token) {
    try {
      tokenDb.put('token', token);
    } on Exception catch (e) {
      print(e);
      print("UserDB saveUserToken ERROR:$e");
    }
  }

  String getUserToken() {
    try {
      return tokenDb.get('token');
    } on Exception catch (e) {
      print("UserDB getUserToken ERROR:$e");
      return null;
    }
  }

  void clearUserToken() {
    try {
      return tokenDb.put('token', null);
    } on Exception catch (e) {
      print("UserDB clearUserToken ERROR:$e");
      return null;
    }
  }
}
