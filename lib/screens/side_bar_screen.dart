import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hobby_hub_ui/models/user_model.dart';
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
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.zero,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            ),
            accountName: Text(
              currentUser.username,
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              currentUser.username,
              style: TextStyle(color: Colors.black),
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
            onTap: () =>
                Navigator.pushReplacementNamed(context, LoginScreen.id),
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
      ),
      onTap: onTap,
    );
  }
}
