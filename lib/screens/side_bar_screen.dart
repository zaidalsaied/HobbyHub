import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/models/user_model.dart';
import 'package:hobby_hub_ui/screens/following_screen.dart';
import 'package:hobby_hub_ui/screens/settings_screen.dart';
import 'package:hobby_hub_ui/widgets/profile_avatar.dart';
import 'screens.dart';

class MainSideBar extends StatelessWidget {
  final User currentUser;
  static const String id = 'main_sidebar_screen';

  const MainSideBar({Key key, @required this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      UserProfileScreen(username: currentUser.username),
                ),
              );
            },
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              currentAccountPicture: ProfileAvatar(
                radius: 35,
              ),
              accountName: Text(
                currentUser.username,
                style: TextStyle(color: Colors.black),
              ),
              accountEmail: Text(
                '@ ${currentUser.username}',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          SideBarItem(
            icon: Icons.person,
            text: 'Profile',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          UserProfileScreen(username: currentUser.username)));
            },
          ),
          SideBarItem(
            icon: Icons.favorite,
            text: 'Hobbies',
            onTap: () {
              Navigator.pushNamed(context, HobbiesScreen.id);
            },
          ),
          SideBarItem(
            icon: Icons.group,
            text: 'Following',
            onTap: () {
              Navigator.pushNamed(context, FollowingScreen.id);
            },
          ),
          SideBarItem(
            icon: Icons.group_add,
            text: 'Followers',
            onTap: () {
              Navigator.pushNamed(context, FollowersScreen.id);
            },
          ),
          SideBarItem(
            icon: Icons.settings,
            text: 'Settings',
            onTap: () {
              Navigator.pushNamed(context, SettingScreen.id);
            },
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          SideBarItem(
            icon: Icons.help,
            text: 'About us',
          ),
          SideBarItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              UserController().logout();
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            },
          ),
        ],
      ),
    );
  }
}

class SideBarItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  const SideBarItem(
      {Key key, @required this.icon, @required this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 15,
        backgroundColor: Colors.white,
        child: Icon(
          icon,
          color: Colors.grey[600],
          size: 20.0,
        ),
      ),
      title: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
      onTap: onTap,
    );
  }
}
