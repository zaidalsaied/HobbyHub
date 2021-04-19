import 'package:hobby_hub_ui/models/user_model.dart';

class Hobby {
  final String name;
  final String imgUrl;
  final List<User> followers;
  final String description;

  Hobby({this.name, this.imgUrl, this.followers, this.description});
}
