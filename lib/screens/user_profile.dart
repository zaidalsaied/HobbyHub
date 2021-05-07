import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/controller/pos_controller.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/models/post.dart';
import 'package:hobby_hub_ui/models/user_model.dart';
import 'package:hobby_hub_ui/screens/home_screen.dart';
import 'package:hobby_hub_ui/screens/nav_screen.dart';
import 'package:hobby_hub_ui/widgets/widgets.dart';

class UserProfileScreen extends StatefulWidget {
  final String username;
  static const String id = 'user_profile_screen';

  const UserProfileScreen({Key key, @required this.username}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  User user;

  @override
  Widget build(BuildContext context) {
    print(widget.username);
    return Scaffold(
      backgroundColor: ThemeData.light().scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, NavScreen.id),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.username ?? "",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              letterSpacing: -1),
        ),
      ),
      body: FutureBuilder(
          future: UserController().getUserByUsername(widget.username),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) user = snapshot.data;
              return ListView(children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ProfileAvatar(
                            imageUrl:
                                "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
                            radius: 50,
                          ),
                          Column(
                            children: [
                              Text(
                                'Following',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                user?.following?.length.toString() ?? "0",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Followers',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                user?.followers?.length.toString() ?? "0",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Hobbies',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                user?.hobbies?.length.toString() ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(children: [
                      FutureBuilder(
                        initialData: [],
                        future: PostController()
                            .getOwnedPostsByUsername(user.username),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            List<Post> posts = snapshot.data;
                            return Container(
                              child: Column(
                                children: [
                                  for (var post in posts)
                                    PostContainer(post: post)
                                ],
                              ),
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          );
                        },
                      ),
                    ])
                  ],
                ),
              ]);
            }
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          }),
    );
  }
}
