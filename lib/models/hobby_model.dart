import 'package:hobby_hub_ui/config/palette.dart';

class Hobby {
  final String id;
  final String name;
  final String imgUrl;
  final String description;

  Hobby({this.id, this.name, this.imgUrl, this.description});

  factory Hobby.fromJson(Map<String, dynamic> json) {
    return Hobby(
      id: json["id"],
      name: json["name"],
      imgUrl: json["image"],
      description: json["description"],
    );
  }
}
