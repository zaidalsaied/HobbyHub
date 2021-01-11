import 'package:meta/meta.dart';

class User {
  final int id;
  final String name;
  final String imageUrl;
  List<User> followers;
  List<User> following;
  User({this.id, this.name, this.imageUrl, this.followers, this.following});
}
