import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/models/post.dart';
import 'widgets.dart';

class PostContainer extends StatefulWidget {
  final Post post;

  const PostContainer({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  _PostContainerState createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PostHeader(post: widget.post),
                  Text(
                    widget.post.text == null ? "" : widget.post.text,
                    maxLines: null,
                    style: TextStyle(fontSize: 18),
                  ),
                  widget.post.imageUrl == null
                      ? const SizedBox(height: 6.0)
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            widget.post.imageUrl != null &&
                    widget.post.imageUrl.trim().length > 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 10.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                            imageUrl:
                                "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg")),
                  )
                : const SizedBox.shrink(),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: _PostStats(post: widget.post),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;

  const _PostHeader({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(
            imageUrl:
                "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg"),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(
                  post.ownerUsername,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  '@${post.ownerUsername} • ',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  post.date.substring(0, 10),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12.0,
                  ),
                ),
              ]),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () => print('More'),
        ),
      ],
    );
  }
}

class _PostStats extends StatelessWidget {
  final Post post;

  const _PostStats({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _PostButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.grey,
                size: 20.0,
              ),
              label: '${post.numberOfLikes}',
            ),
            Container(
              width: 1,
              height: 20.0,
              color: Colors.grey,
            ),
            _PostButton(
              icon: Icon(
                Icons.textsms_outlined,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: '${post.numberOfComments}',
              onTap: () => print('Comment'),
            ),
          ],
        ),
      ],
    );
  }
}

class _PostButton extends StatefulWidget {
  final Icon icon;
  final String label;
  final Function onTap;

  _PostButton({
    Key key,
    @required this.icon,
    @required this.label,
    this.onTap,
  }) : super(key: key);

  @override
  __PostButtonState createState() => __PostButtonState();
}

class __PostButtonState extends State<_PostButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.icon,
                const SizedBox(width: 4.0),
                Text(widget.label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
