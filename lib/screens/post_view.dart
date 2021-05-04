import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/controller/pos_controller.dart';
import 'package:hobby_hub_ui/models/comment_model.dart';
import 'package:hobby_hub_ui/models/post.dart';
import 'package:hobby_hub_ui/widgets/post_container.dart';
import 'package:hobby_hub_ui/widgets/profile_avatar.dart';

class PostView extends StatefulWidget {
  static const String id = "post_view";
  final Post post;

  const PostView({Key key, this.post}) : super(key: key);

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
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
            "${widget.post.ownerUsername[0].toUpperCase()}${widget.post.ownerUsername.substring(1)}'s Post"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 100,
              child: ListView(
                children: [
                  PostContainer(post: widget.post),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 15, bottom: 5, top: 5),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: .5),
                      ],
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            width: MediaQuery.of(context).size.width,
                            child: TextField(
                              style: TextStyle(fontSize: 22),
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              onChanged: (value) {
                                setState(() {});
                              },
                              controller: _commentController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  )),
                                  hintText: "Write a comment..",
                                  hintStyle: TextStyle(fontSize: 18)),
                            ),
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.send,
                              size: 25,
                              color: _commentController.text.trim().length > 0
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                            ),
                            onPressed: _commentController.text.trim().length > 0
                                ? () async {
                                    comment.text = _commentController.text;
                                    await PostController()
                                        .comment(widget.post.postId, comment);
                                  }
                                : () {})
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  for (var com in widget.post.comments)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _CommentHeader(
                            comment: com,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              margin: EdgeInsets.only(left: 15, top: 4),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                  )),
                              child: Text(
                                com.text,
                                style: TextStyle(fontSize: 18),
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
    return Row(
      children: [
        ProfileAvatar(
            imageUrl:
                "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg"),
        SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text(
                comment.creatorUsername,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '@${comment.creatorUsername} • ',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12.0,
                ),
              ),
            ]),
          ],
        ),
      ],
    );
  }
}
