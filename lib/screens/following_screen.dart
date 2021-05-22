import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/models/user_model.dart';
import 'package:hobby_hub_ui/screens/user_profile.dart';
import 'package:hobby_hub_ui/widgets/profile_avatar.dart';

class FollowingScreen extends StatefulWidget {
  static const String id = 'following_screen';
  User user;

  FollowingScreen({Key key, this.user}) : super(key: key);

  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  void _unfollow(String username) async {
    await UserController().unfollowUser(username);
    setState(() {
      UserController().currentUser.following.remove(username);
    });
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
            'Following',
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
                UserController().currentUser.following.isEmpty)
              Center(
                heightFactor: 8,
                child: Text("You are not following anyone yet!"),
              ),
            for (var username in widget.user.following)
              FutureBuilder(
                  future: UserController().getUserByUsername(username),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
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
                              border: Border.all(
                                  width: 1.0, color: Colors.grey[200]),
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
                                    Text(username ?? ""),
                                  ],
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () {
                                      _unfollow(username);
                                    },
                                    child: Text("Following"))
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
                  })
          ],
        ));
  }
}
