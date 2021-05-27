import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/models/message_model.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  final String receiverId;

  const ChatScreen({Key key, @required this.receiverId}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  void startListening() {
    try {
      Provider.of<UserController>(context, listen: false)
          .setCurrentUser(UserController().currentUser);
      Provider.of<UserController>(context, listen: false)
          .joinPrivate(widget.receiverId);
      Provider.of<UserController>(context, listen: false)
          .getChatMessages(widget.receiverId);
      Provider.of<UserController>(context, listen: false).listenToNewMessages();
    } catch (e) {
      print(e);
    }
  }

  final controller = TextEditingController();
  bool isListening = false;

  Widget _buildMessage(Message message, bool isMe) {
    final Align msg = Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
            left: isMe ? 80 : 0,
            right: isMe ? 0 : 80,
          ),
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: isMe
                ? Theme.of(context).accentColor
                : Theme.of(context).bottomAppBarColor,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(message.text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: isMe ? Colors.white : null)),
              Text(timeago.format(DateTime.parse(message.time)),
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 10, color: isMe ? Colors.white : null)),
            ],
          ),
        ));
    if (isMe) {
      return msg;
    }
    return Wrap(
      children: <Widget>[
        msg,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isListening) {
      startListening();
      isListening = true;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.receiverId,
          ),
        ),
        body: Provider.of<UserController>(context).messages != null
            ? GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        padding: EdgeInsets.only(top: 15.0),
                        itemCount: UserController().messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          final userController =
                              Provider.of<UserController>(context);
                          final Message message = userController.messages[
                              userController.messages.length - (index + 1)];
                          final bool isMe = message.senderId ==
                              userController.currentUser.username;
                          return _buildMessage(message, isMe);
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      height: 70.0,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: controller,
                              textCapitalization: TextCapitalization.sentences,
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                hintText: 'Send a message...',
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send),
                            iconSize: 25.0,
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              Provider.of<UserController>(context,
                                      listen: false)
                                  .sendMessage(
                                      controller.text,
                                      UserController().currentUser.username,
                                      widget.receiverId);
                              controller.clear();
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : CircularProgressIndicator());
  }
}
