import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/db/app_color_db.dart';

class Palette {
  static const Color signInColor=Color(0xff00BFA6);
  static const Color signUpColor=Color(0xff00BFA6);
  static Color scaffold = Color(0xFFF0F2F5);
  static Color accentColor = Color(0xFFFEF9EB);

  static Color get hobbyHubPrimaryColor {
    int index = AppColorDB().getAppColor();
    return colors.toList()[index ?? 0];
  }

  static Set<Color> get colors {
    return {
      Colors.cyan[800],
      Colors.red[800],
      Colors.blueAccent,
      Colors.orangeAccent,
      Colors.deepPurpleAccent,
      Colors.pink,
      Colors.purpleAccent,
      Colors.green,
      Colors.pinkAccent,
      Colors.red,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.lightGreen,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
      Colors.green[900],
      Colors.black,
      Color(0xFF40e0d0),
      Color(0xFFff8c00),
      Color(0xFFff0080),
      Color(0xFF7f7fd5),
      Color(0xFF86a8e7),
      Color(0xFF00416A),
      Color(0xFF4286f4),
      Color.fromRGBO(240, 19, 77, 1),
      Color.fromRGBO(228, 0, 124, 1),
      Color.fromRGBO(31, 179, 237, 1),
      Color(0xFFb92b27),
      Color(0xFF1565C0),
      Colors.redAccent,
    };
  }
// static const LinearGradient createRoomGradient = LinearGradient(
//   colors: [Color(0xFF496AE1),, Color(0xFFCE48B1),],
// ),;

// static const Color online = Color(0xFF4BCB1F),;

// static const LinearGradient storyGradient = LinearGradient(
//   begin: Alignment.topCenter,
//   end: Alignment.bottomCenter,
//   colors: [Colors.transparent, Colors.black26],
// ),;
}
