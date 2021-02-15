import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/Services/hobby_service.dart';
import 'package:hobby_hub_ui/config/palette.dart';
import 'package:hobby_hub_ui/screens/hobbies_screen.dart';
import 'package:hobby_hub_ui/screens/screens.dart';

void main() {
  runApp(MyApp());
}

void getHobbies() async {
  await HobbyService().fetchHobbies();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getHobbies();
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
