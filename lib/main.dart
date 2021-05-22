import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hobby_hub_ui/config/palette.dart';
import 'package:hobby_hub_ui/controller/hobby_controller.dart';
import 'package:hobby_hub_ui/controller/pos_controller.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/db/app_color_db.dart';
import 'package:hobby_hub_ui/db/token_db.dart';
import 'package:hobby_hub_ui/screens/create_post_screen.dart';
import 'package:hobby_hub_ui/screens/following_screen.dart';
import 'package:hobby_hub_ui/screens/hobbies_screen.dart';
import 'package:hobby_hub_ui/screens/post_view.dart';
import 'package:hobby_hub_ui/screens/screens.dart';
import 'package:hobby_hub_ui/screens/settings_screen.dart';
import 'package:hobby_hub_ui/screens/trending_screen.dart';
import 'package:hobby_hub_ui/service/upload_image_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  runApp(Phoenix(child: MyApp()));
}

bool isAuth = false;

initApp() async {
  try {
    await Hive.initFlutter();
    await TokenDB().openTokenBox();
    await AppColorDB().openAppColorDbBox();
    isAuth = await UserController().authenticateToken();
    if (isAuth) {
      await PostController().getUserFeed();
      await PostController().getUserTrending();
      await HobbyController().getAllHobbies();
    }
  } catch (e) {
    print(e);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
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
    MaterialColor primaryAppColor = MaterialColor(Palette.hobbyHubPrimaryColor.value, color);
    Map<int, Color> colorDark = {
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
    MaterialColor primaryAppColorDark = MaterialColor(Palette.hobbyHubPrimaryColor.value, colorDark);
    return AdaptiveTheme(
      initial: AdaptiveThemeMode.system,
      dark: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              focusColor: Palette.hobbyHubPrimaryColor,
              filled: true,
              fillColor: Colors.grey[600],
              suffixStyle: TextStyle(color: Colors.white),
              contentPadding: EdgeInsets.symmetric(horizontal: 10)),
          buttonTheme: ButtonThemeData(buttonColor: Palette.hobbyHubPrimaryColor),
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: TextTheme(
              headline6: TextStyle(color: Palette.hobbyHubPrimaryColor, fontSize: 20, fontWeight: FontWeight.bold),
              headline1: TextStyle(color: Palette.hobbyHubPrimaryColor, fontSize: 28, fontWeight: FontWeight.bold),
              bodyText2: TextStyle(color: Colors.white, fontSize: 16),
              bodyText1: TextStyle(color: Colors.white, fontSize: 18)),
          cupertinoOverrideTheme: CupertinoThemeData(textTheme: CupertinoTextThemeData(textStyle: TextStyle(color: Colors.white))),
          primarySwatch: primaryAppColorDark,
          accentColor: primaryAppColor,
          appBarTheme: AppBarTheme(color: Palette.hobbyHubPrimaryColor),
          scaffoldBackgroundColor: Colors.grey[700]),
      light: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              filled: true,
              fillColor: Colors.white,
              suffixStyle: TextStyle(color: Colors.black),
              contentPadding: EdgeInsets.symmetric(horizontal: 10)),
          brightness: Brightness.light,
          buttonTheme: ButtonThemeData(buttonColor: Palette.hobbyHubPrimaryColor),
          textTheme: TextTheme(
            headline6: TextStyle(color: Palette.hobbyHubPrimaryColor, fontSize: 20, fontWeight: FontWeight.bold),
            headline1: TextStyle(color: Palette.hobbyHubPrimaryColor, fontSize: 28, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(color: Colors.black, fontSize: 16),
            bodyText1: TextStyle(color: Colors.black, fontSize: 18),
          ),
          cupertinoOverrideTheme: CupertinoThemeData(textTheme: CupertinoTextThemeData(textStyle: TextStyle(color: Colors.black))),
          primarySwatch: primaryAppColor,
          accentColor: primaryAppColor),
      builder: (ThemeData light, ThemeData dark) => MaterialApp(
          initialRoute: isAuth ? NavScreen.id : LoginScreen.id,
          routes: {
            LoginScreen.id: (context) => LoginScreen(),
            SignupScreen.id: (context) => SignupScreen(),
            HomeScreen.id: (context) => HomeScreen(),
            NavScreen.id: (context) => NavScreen(),
            MainSideBar.id: (context) =>
                MainSideBar(currentUser: UserController().currentUser),
            ChatListScreen.id: (context) => ChatListScreen(),
            ChatScreen.id: (context) => ChatScreen(),
            SettingScreen.id: (context) => SettingScreen(),
            HobbiesScreen.id: (context) => HobbiesScreen(),
            UserProfileScreen.id: (context) => UserProfileScreen(),
            FollowersScreen.id: (context) => FollowersScreen(),
            FollowingScreen.id: (context) => FollowingScreen(),
            CreatePostScreen.id: (context) => CreatePostScreen(),
            PostView.id: (context) => PostView(),
            TrendingScreen.id: (context) => TrendingScreen(),
          },
          debugShowCheckedModeBanner: false,
          title: 'Flutter Project, Graduation Project two.',
          theme: light, darkTheme: dark),
    );
  }
}
