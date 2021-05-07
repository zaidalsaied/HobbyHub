import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hobby_hub_ui/controller/pos_controller.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/models/post.dart';
import 'package:hobby_hub_ui/models/user_model.dart';
import 'package:hobby_hub_ui/screens/nav_screen.dart';
import 'package:hobby_hub_ui/widgets/widgets.dart';

class UserProfileScreen extends StatefulWidget {
  static const String id = 'user_profile_screen';
  final String username;

  const UserProfileScreen({Key key, @required this.username}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.light().scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context)),
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
                      for (var post in user.posts)
                        FutureBuilder(
                          initialData: [],
                          future: PostController().getPostByPostId(post),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              Post post = snapshot.data;
                              return PostContainer(post: post);
                            }
                            return Container(
                              height: 80,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(vertical: 15),
                              color: Colors.grey.withOpacity(0.5),
                              child: SpinKitThreeBounce(
                                  color: Theme.of(context).primaryColor,
                                  size: 50.0),
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

  List<FutureBuilder> _buildPosts() {}
}
