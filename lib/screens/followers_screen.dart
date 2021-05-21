import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/models/user_model.dart';
import 'package:hobby_hub_ui/screens/user_profile.dart';
import 'package:hobby_hub_ui/widgets/profile_avatar.dart';

class FollowersScreen extends StatefulWidget {
  static const String id = 'followers_screen';
  User user;

  FollowersScreen({Key key, this.user}) : super(key: key);

  @override
  _FollowersScreenState createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  void _unfollow(String username) async {
    await UserController().unfollowUser(username);
    setState(() {
      UserController().currentUser.following.remove(username);
    });
  }

  void _follow(String username) async {
    setState(() {
      UserController().currentUser.followers.add(username);
    });
    await UserController().followUser(username);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user == null) widget.user = UserController().currentUser;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).accentColor,
            size: 20.0,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Followers',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.2,
          ),
        ),
      ),
      body: ListView(
        children: [
          if (widget.user.username == UserController().currentUser.username &&
              UserController().currentUser.followers.isEmpty)
            Center(
              heightFactor: 8,
              child: Text("you don't have followers yet!"),
            ),
          for (var username in widget.user.followers)
            FutureBuilder(
              future: UserController().getUserByUsername(username),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  bool following =
                      UserController().currentUser.followers.contains(username);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  UserProfileScreen(username: username)));
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(width: 1.0, color: Colors.grey[200]),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ProfileAvatar(),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(username),
                              ],
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {
                                  following
                                      ? _unfollow(username)
                                      : _follow(username);
                                },
                                child: following
                                    ? Text("Following")
                                    : Text("Follow"))
                          ],
                        )),
                  );
                } else {
                  return Container(
                    height: 40,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 15),
                    color: Colors.grey.withOpacity(0.5),
                    child: SpinKitThreeBounce(
                        color: Theme.of(context).primaryColor, size: 50.0),
                  );
                }
              },
            ),
        ],
      ),
    );
  }
}
