import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/screens/drawer_screen.dart';
import 'package:hobby_hub_ui/screens/widgets/recent_chats.dart';

class ChatListScreen extends StatefulWidget {
  static const String id = 'chat_list_screen';

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerScreen(
        currentUser: UserController().currentUser,
      ),
      appBar: AppBar(
        title: Text(
          'Chats',
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  RecentChats(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
