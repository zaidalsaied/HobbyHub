import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hobby_hub_ui/config/palette.dart';
import 'package:hobby_hub_ui/controller/hobby_controller.dart';
import 'package:hobby_hub_ui/controller/pos_controller.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/db/token_db.dart';
import 'package:hobby_hub_ui/screens/create_post_screen.dart';
import 'package:hobby_hub_ui/screens/hobbies_screen.dart';
import 'package:hobby_hub_ui/screens/post_view.dart';
import 'package:hobby_hub_ui/screens/screens.dart';
import 'package:hobby_hub_ui/controller/hobbies_list_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => HobbiesListViewModel(),
      child: MyApp(),
    ),
  );
}

bool isAuth = false;

initApp() async {
  try {
    await Hive.initFlutter();
    await TokenDB().openTokenBox();
    isAuth = await UserController().authenticateToken();
    if (isAuth) {
      await PostController().getUserFeed();
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
    print("isAuth:$isAuth");
    return MaterialApp(
      initialRoute: isAuth ? NavScreen.id : LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        NavScreen.id: (context) => NavScreen(),
        MainSideBar.id: (context) => MainSideBar(),
        ChatListScreen.id: (context) => ChatListScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        HobbiesScreen.id: (context) => HobbiesScreen(),
        UserProfileScreen.id: (context) => UserProfileScreen(),
        FollowersScreen.id: (context) => FollowersScreen(),
        FollowingScreen.id: (context) => FollowingScreen(),
        CreatePostScreen.id: (context) => CreatePostScreen(),
        PostView.id: (context) => PostView(),
      },
      title: 'Flutter Project, Graduation Project two.',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Color(0xFFFEF9EB),
        primaryColor: Palette.hobbyHubPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Palette.scaffold,
      ),
    );
  }
}
