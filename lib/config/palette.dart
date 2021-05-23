import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/db/app_color_db.dart';

class Palette {
  static const Color signInColor = Color(0xff00BFA6);
  static const Color signUpColor = Color(0xff00BFA6);
  static Color scaffold = Color(0xFFF0F2F5);
  static Color accentColor = Color(0xFFFEF9EB);
  static Map<int, Color> color = {
    50: Palette.hobbyHubPrimaryColor,
    100: Palette.hobbyHubPrimaryColor,
    200: Palette.hobbyHubPrimaryColor,
    300: Palette.hobbyHubPrimaryColor,
    400: Palette.hobbyHubPrimaryColor,
    500: Palette.hobbyHubPrimaryColor,
    600: Palette.hobbyHubPrimaryColor,
    700: Palette.hobbyHubPrimaryColor,
    800: Palette.hobbyHubPrimaryColor,
    900: Palette.hobbyHubPrimaryColor
  };
  static Map<int, Color> colorDark = {
    50: Palette.hobbyHubPrimaryColor,
    100: Palette.hobbyHubPrimaryColor,
    200: Palette.hobbyHubPrimaryColor,
    300: Palette.hobbyHubPrimaryColor,
    400: Palette.hobbyHubPrimaryColor,
    500: Palette.hobbyHubPrimaryColor,
    600: Palette.hobbyHubPrimaryColor,
    700: Palette.hobbyHubPrimaryColor,
    800: Palette.hobbyHubPrimaryColor,
    900: Palette.hobbyHubPrimaryColor
  };
  static ThemeData get lightTheme {
    MaterialColor primaryAppColor =
        MaterialColor(Palette.hobbyHubPrimaryColor.value, color);
    return ThemeData(
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            filled: true,
            fillColor: Colors.white,
            suffixStyle: TextStyle(color: Colors.black),
            contentPadding: EdgeInsets.symmetric(horizontal: 10)),
        brightness: Brightness.light,
        buttonTheme: ButtonThemeData(buttonColor: Palette.hobbyHubPrimaryColor),
        textTheme: TextTheme(
            headline6: TextStyle(
                color: Palette.hobbyHubPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            headline1: TextStyle(
                color: Palette.hobbyHubPrimaryColor,
                fontSize: 28,
                fontWeight: FontWeight.bold),
            bodyText2: TextStyle(color: Colors.black, fontSize: 16),
            bodyText1: TextStyle(color: Colors.black, fontSize: 18)),
        cupertinoOverrideTheme: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
                textStyle: TextStyle(color: Colors.black))),
        primarySwatch: primaryAppColor,
        accentColor: primaryAppColor);
  }
  static ThemeData get darkTheme {
    MaterialColor primaryAppColor =
        MaterialColor(Palette.hobbyHubPrimaryColor.value, color);
    MaterialColor primaryAppColorDark =
        MaterialColor(Palette.hobbyHubPrimaryColor.value, colorDark);
    return ThemeData(
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            focusColor: Palette.hobbyHubPrimaryColor,
            filled: true,
            fillColor: Colors.grey[600],
            suffixStyle: TextStyle(color: Colors.white),
            contentPadding: EdgeInsets.symmetric(horizontal: 10)),
        buttonTheme: ButtonThemeData(buttonColor: Palette.hobbyHubPrimaryColor),
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
            headline6: TextStyle(
                color: Palette.hobbyHubPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            headline1: TextStyle(
                color: Palette.hobbyHubPrimaryColor,
                fontSize: 28,
                fontWeight: FontWeight.bold),
            bodyText2: TextStyle(color: Colors.white, fontSize: 16),
            bodyText1: TextStyle(color: Colors.white, fontSize: 18)),
        cupertinoOverrideTheme: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
                textStyle: TextStyle(color: Colors.white))),
        primarySwatch: primaryAppColorDark,
        accentColor: primaryAppColor,
        appBarTheme: AppBarTheme(color: Palette.hobbyHubPrimaryColor),
        scaffoldBackgroundColor: Colors.grey[700]);
  }

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
}
