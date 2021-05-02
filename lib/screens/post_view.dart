import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/models/post.dart';
import 'package:hobby_hub_ui/widgets/post_container.dart';

class PostView extends StatefulWidget {
  static const String id = "post_view";
  final Post post;

  const PostView({Key key, this.post}) : super(key: key);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PostContainer(post: widget.post),
          SizedBox(
            height: MediaQuery.of(context).size.height * .75,
            child: ListView(
              children: [
                for (var comment in widget.post.comments)
                  Text(comment.text == null ? "" : comment.text)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
