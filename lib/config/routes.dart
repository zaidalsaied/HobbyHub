import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/screens/create_post_screen.dart';
import 'package:hobby_hub_ui/screens/following_screen.dart';
import 'package:hobby_hub_ui/screens/hobbies_screen.dart';
import 'package:hobby_hub_ui/screens/post_view.dart';
import 'package:hobby_hub_ui/screens/screens.dart';
import 'package:hobby_hub_ui/screens/settings_screen.dart';
import 'package:hobby_hub_ui/screens/trending_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> get routes {
    return {
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
    };
  }
}
