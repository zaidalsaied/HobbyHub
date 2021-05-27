import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/controller/post_controller.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/models/comment_model.dart';
import 'package:hobby_hub_ui/models/post_model.dart';
import 'package:hobby_hub_ui/models/user_model.dart';
import 'package:hobby_hub_ui/screens/user_profile.dart';
import 'package:hobby_hub_ui/screens/widgets/post_container.dart';
import 'package:hobby_hub_ui/screens/widgets/profile_avatar.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostView extends StatefulWidget {
  static const String id = "post_view";
  final Post post;
  final Function setState;

  const PostView({Key key, this.post, this.setState}) : super(key: key);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  TextEditingController _commentController = TextEditingController();
  Comment comment = Comment();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.post.ownerUsername[0].toUpperCase()}${widget.post.ownerUsername.substring(1)}'s Post"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            PostContainer(
              post: widget.post,
              setState: widget.setState,
              canNavigate: false,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 15, bottom: 5, top: 5),
              decoration: BoxDecoration(),
              child: Row(
                children: [
                  ProfileAvatar(
                    imageUrl: UserController().currentUser.imgUrl,
                  ),
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        style: TextStyle(fontSize: 16),
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: _commentController,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          hintText: "Write a comment..",
                          hintStyle: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.send, size: 25),
                      onPressed: _commentController.text.trim().length > 0
                          ? () async {
                              comment.creatorUsername =
                                  UserController().currentUser.username;
                              widget.post.comments.add(comment);
                              widget.post.numberOfComments++;
                              comment.text = _commentController.text;
                              comment.dateCreated = DateTime.now().toString();
                              _commentController.clear();
                              setState(() {});
                              await PostController()
                                  .comment(widget.post.postId, comment);
                            }
                          : null)
                ],
              ),
            ),
            SizedBox(height: 15),
            for (int i = widget.post.numberOfComments - 1; i >= 0; i--)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CommentHeader(comment: widget.post.comments[i]),
                    Container(
                        width: MediaQuery.of(context).size.width - 75,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        margin: EdgeInsets.only(left: 15, top: 4),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text(
                                widget.post.comments[i].creatorUsername == null
                                    ? ''
                                    : widget.post.comments[i].creatorUsername,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '@${widget.post.comments[i].creatorUsername} • ',
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              Text(
                                timeago.format(DateTime.parse(
                                    widget.post.comments[i].dateCreated)),
                                maxLines: 1,
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ]),
                            Text(
                              widget.post.comments[i].text,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentHeader extends StatelessWidget {
  final Comment comment;

  const _CommentHeader({
    Key key,
    @required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserProfileScreen(
            username: comment.creatorUsername,
          ),
        ),
      ),
      child: FutureBuilder(
          future: UserController().getUserByUsername(comment.creatorUsername),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              User user = snapshot.data;
              return ProfileAvatar(imageUrl: user?.imgUrl);
            } else
              return Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(shape: BoxShape.circle));
          }),
    );
  }
}
