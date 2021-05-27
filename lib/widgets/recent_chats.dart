import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/models/user_model.dart';
import 'package:hobby_hub_ui/screens/chat_screen.dart';
import 'package:hobby_hub_ui/screens/side_bar_screen.dart';
import 'package:hobby_hub_ui/widgets/profile_avatar.dart';

class RecentChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chats'),
        ),
        drawer: MainSideBar(
          currentUser: UserController().currentUser,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: ListView.builder(
            itemCount: UserController().currentUser.following.length,
            itemBuilder: (BuildContext context, int index) {
              final String username =
                  UserController().currentUser.following.toList()[index];

              return GestureDetector(
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreen(
                            receiverId: username,
                          ),
                        ),
                      ),
                  child: FutureBuilder(
                    future: UserController().getUserByUsername(username),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        User user = snapshot.data;
                        return Container(
                          margin: EdgeInsets.only(
                              top: 5.0, bottom: 5.0, right: 20.0),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .color)
                            ],
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  ProfileAvatar(
                                    imageUrl: user.imgUrl,
                                  ),
                                  SizedBox(width: 10.0),
                                  Text(
                                    user.username,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(Icons.send),
                                  SizedBox(height: 5.0),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else
                        return SpinKitCircle(
                          color: Theme.of(context).primaryColor,
                        );
                    },
                  ));
            },
          ),
        ));
  }
}
