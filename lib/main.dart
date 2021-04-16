import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/config/palette.dart';
import 'package:hobby_hub_ui/screens/hobbies_screen.dart';
import 'package:hobby_hub_ui/screens/screens.dart';
import 'package:hobby_hub_ui/view_models/hobbies_list_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HobbiesListViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,
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
      },
      title: 'Flutter Project, Graduation Project two.',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Color(0xFFFEF9EB),
        primaryColor: Palette.hobbyHubPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Palette.scaffold,
      ),
      home: LoginScreen(),
    );
  }
}
