import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/screens/chat_list_screen.dart';
import 'package:hobby_hub_ui/screens/chat_screen.dart';
import 'package:hobby_hub_ui/screens/create_post_screen.dart';
import 'package:hobby_hub_ui/screens/edit_post_screen.dart';
import 'package:hobby_hub_ui/screens/edit_profile_screen.dart';
import 'package:hobby_hub_ui/screens/followers_screen.dart';
import 'package:hobby_hub_ui/screens/following_screen.dart';
import 'package:hobby_hub_ui/screens/hobbies_screen.dart';
import 'package:hobby_hub_ui/screens/home_screen.dart';
import 'package:hobby_hub_ui/screens/login_screen.dart';
import 'package:hobby_hub_ui/screens/nav_screen.dart';
import 'package:hobby_hub_ui/screens/post_view.dart';
import 'package:hobby_hub_ui/screens/settings_screen.dart';
import 'package:hobby_hub_ui/screens/side_bar_screen.dart';
import 'package:hobby_hub_ui/screens/signup_screen.dart';
import 'package:hobby_hub_ui/screens/trending_screen.dart';
import 'package:hobby_hub_ui/screens/user_profile.dart';

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
      EditProfileScreen.id: (context) => EditProfileScreen(),
      EditPostScreen.id: (context) => EditPostScreen()
    };
  }
}
