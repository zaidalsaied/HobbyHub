import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/data/data.dart';
import 'package:hobby_hub_ui/models/models.dart';
import 'package:hobby_hub_ui/screens/home_screen.dart';
import 'package:hobby_hub_ui/widgets/widgets.dart';

class UserProfileScreen extends StatefulWidget {
  static const String id = 'user_profile_screen';
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<Widget> _buildPosts() {
    List<PostContainer> postContainerList = [];
    posts.forEach((Post post) {
      post.user = currentUser;
      postContainerList.add(PostContainer(post: post));
    });
    return postContainerList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.light().scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, HomeScreen.id),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          currentUser.name,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              letterSpacing: -1),
        ),
      ),
      body: ListView(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ProfileAvatar(
                    imageUrl: currentUser.imgUrl,
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
                        '15',
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
                        '15',
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
                        '15',
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
            Column(
              children: _buildPosts(),
            )
          ],
        ),
      ]),
    );
  }
}
