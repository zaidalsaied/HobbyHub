import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hobby_hub_ui/controller/pos_controller.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/models/post.dart';
import 'package:hobby_hub_ui/models/user_model.dart';
import 'package:hobby_hub_ui/screens/edit_profile_screen.dart';
import 'package:hobby_hub_ui/screens/following_screen.dart';
import 'package:hobby_hub_ui/widgets/post_container.dart';
import 'package:hobby_hub_ui/widgets/profile_avatar.dart';

import 'followers_screen.dart';

class UserProfileScreen extends StatefulWidget {
  static const String id = 'user_profile_screen';
  final String username;

  const UserProfileScreen({Key key, @required this.username}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  User user;
  List<Post> posts = [];

  void _follow() async {
    setState(() {
      UserController().currentUser.following.add(widget.username);
      user.followers.add(widget.username);
    });
    await UserController().followUser(widget.username);
  }

  void _unfollow() async {
    setState(() {
      UserController().currentUser.following.remove(widget.username);
      user.followers.remove(widget.username);
    });
    await UserController().unfollowUser(widget.username);
  }

  Future _deleteImageFromCache() async {
    try {
      String url = user.imgUrl;
      await CachedNetworkImage.evictFromCache(url);
    } catch (e) {
      print(e);
    }
  }

  Widget _getButton() {
    final style = ElevatedButton.styleFrom(
      primary: Theme.of(context).primaryColor,
    );
    if (UserController().currentUser.username == widget.username) {
      return ElevatedButton.icon(
        label: Text("Edit Profile"),
        style: style,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => EditProfileScreen(state: setState)));
        },
        icon: Icon(Icons.edit),
      );
    } else {
      bool following =
          UserController().currentUser.following.contains(widget.username);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              child: ElevatedButton(
                  onPressed: following ? _unfollow : _follow,
                  style: style,
                  child: following ? Text("Following") : Text("Follow"))),
          SizedBox(
            width: 15,
          ),
          Expanded(
              child: ElevatedButton(
                  style: style, onPressed: () {}, child: Text("Message"))),
        ],
      );
    }
  }

  _profileHeader() {
    print("ok");
    return ListView(children: [
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileAvatar(
                  imageUrl: user.imgUrl,
                  radius: 50,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FollowingScreen(user: user)));
                  },
                  child: Column(
                    children: [
                      Text('Following',
                          style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(height: 2),
                      Text(
                        user.following.length.toString(),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FollowersScreen(user: user)));
                  },
                  child: Column(
                    children: [
                      Text(
                        'Followers',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        user.followers.length.toString(),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Hobbies',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(height: 2),
                    Text(
                      user?.hobbies?.length.toString() ?? "",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                width: MediaQuery.of(context).size.width,
                child: _getButton()),
            if (posts.isEmpty)
              for (var post in user.posts)
                FutureBuilder(
                  initialData: posts,
                  future: PostController().getPostByPostId(post),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      Post post = snapshot.data;
                      int index = PostController.feed.indexWhere(
                          (element) => element.postId == post.postId);
                      if (index >= 0) post = PostController.feed[index];
                      posts.add(post);
                      return PostContainer(
                        post: post,
                      );
                    }
                    return Container(
                      height: 80,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 15),
                      color: Colors.grey.withOpacity(0.5),
                      child: SpinKitThreeBounce(
                          color: Theme.of(context).primaryColor, size: 50.0),
                    );
                  },
                ),
            if (posts.isNotEmpty)
              for (var post in posts)
                PostContainer(
                  post: post,
                  setState: setState,
                )
          ])
        ],
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    _deleteImageFromCache();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          widget.username ?? "",
        ),
      ),
      body: Container(
        child: user == null
            ? FutureBuilder(
                future: UserController().getUserByUsername(widget.username),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data != null) user = snapshot.data;

                    return _profileHeader();
                  }
                  return Center(
                    child: SpinKitCircle(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                })
            : _profileHeader(),
      ),
    );
  }
}
