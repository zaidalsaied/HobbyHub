import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/data/data.dart';
import 'package:hobby_hub_ui/models/models.dart';
import 'package:hobby_hub_ui/widgets/follow_user_button.dart';
import 'package:hobby_hub_ui/widgets/widgets.dart';

class FollowersScreen extends StatefulWidget {
  static const String id = 'followers_screen';
  @override
  _FollowersScreenState createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  // _buildFollowList() {
  //   List<Widget> followList = [];
  //   currentUser.followers.forEach((User otherUser) {
  //     followList.add(
  //       Container(
  //         padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  //         margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(15),
  //           border: Border.all(width: 1.0, color: Colors.grey[200]),
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Row(
  //               children: [
  //                 ProfileAvatar(
  //                   imageUrl: otherUser.imgUrl,
  //                 ),
  //                 SizedBox(
  //                   width: 10,
  //                 ),
  //                 Text(otherUser.name),
  //               ],
  //             ),
  //             FollowUserButton(
  //               otherUser: otherUser,
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   });
  //   return followList;
  // }

  @override
  Widget build(BuildContext context) {
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
          children: [],
        ));
  }
}
