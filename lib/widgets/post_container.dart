import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hobby_hub_ui/controller/pos_controller.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/models/post.dart';
import 'package:hobby_hub_ui/models/user_model.dart';
import 'package:hobby_hub_ui/screens/post_view.dart';
import 'package:hobby_hub_ui/screens/res/svg_assets.dart';
import 'package:hobby_hub_ui/screens/screens.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'widgets.dart';

class PostContainer extends StatefulWidget {
  final Post post;
  final Function setState;
  final bool navigate;

  PostContainer({
    Key key,
    @required this.post,
    this.setState,
    this.navigate = true,
  }) : super(key: key);

  @override
  _PostContainerState createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  String _getTagsString(List<String> tags) {
    String tagsString = "";
    for (var tag in tags) tagsString += "#$tag";
    return tagsString;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.post.imageUrl);
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(
                            username: widget.post.ownerUsername,
                          ),
                        ),
                      );
                    },
                    child: _PostHeader(post: widget.post)),
                GestureDetector(
                  onTap: () {
                    if (widget.navigate)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostView(
                            post: widget.post,
                            setState: setState,
                          ),
                        ),
                      );
                  },
                  child: Text(
                    widget.post.text == null ? "" : widget.post.text,
                    maxLines: null,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          widget.post.imageUrl != null && widget.post.imageUrl.trim().length > 0
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(
                                child: SpinKitPumpingHeart(
                                    size: 100,
                                    color: Theme.of(context).accentColor),
                              ),
                          errorWidget: (context, url, error) => Center(
                                child: SvgPicture.string(
                                  SvgAssets.notFound,
                                  allowDrawingOutsideViewBox: false,
                                  height: 100,
                                ),
                              ),
                          imageUrl: widget.post.imageUrl)),
                )
              : const SizedBox.shrink(),
          Wrap(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                _getTagsString(widget.post.tags),
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.blueAccent),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
            child: _PostStats(
              post: widget.post,
              setState: widget.setState,
              navigate: widget.navigate,
            ),
          ),
        ],
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
        FutureBuilder(
            future: UserController().getUserByUsername(post.ownerUsername),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                User user = snapshot.data;
                return ProfileAvatar(imageUrl: user?.imgUrl);
              } else
                return Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey, shape: BoxShape.circle));
            }),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: Row(children: [
                  Text(
                    post.ownerUsername,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    '@${post.ownerUsername} • ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.0,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .25,
                    child: Text(
                      timeago.format(DateTime.parse(post.date)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ]),
              ),
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

class _PostStats extends StatefulWidget {
  final Post post;
  final Function setState;
  final navigate;

  const _PostStats({
    Key key,
    @required this.post,
    this.setState,
    this.navigate,
  }) : super(key: key);

  @override
  __PostStatsState createState() => __PostStatsState();
}

class __PostStatsState extends State<_PostStats> {
  @override
  Widget build(BuildContext context) {
    bool liked =
        widget.post.likes.contains(UserController().currentUser.username);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _PostButton(
              icon: Icon(
                Icons.favorite,
                color: liked ? Theme.of(context).accentColor : Colors.grey,
                size: 25.0,
              ),
              onTap: () async {
                if (liked) {
                  setState(() {
                    widget.post.likes
                        .remove(UserController().currentUser.username);
                    widget.post.numberOfLikes--;
                  });
                  if (widget.setState != null) {
                    widget.setState(() {});
                  }
                  await PostController().unlike(widget.post.postId);
                } else {
                  setState(() {
                    widget.post.likes
                        .add(UserController().currentUser.username);
                    widget.post.numberOfLikes++;
                  });
                  if (widget.setState != null) {
                    widget.setState(() {});
                  }
                  await PostController().like(widget.post.postId);
                }
              },
              label: '${widget.post.numberOfLikes}',
            ),
            _PostButton(
              icon: Icon(Icons.textsms_outlined, size: 25.0),
              label: '${widget.post.numberOfComments}',
              onTap: () {
                if (widget.navigate)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostView(
                        post: widget.post,
                        setState: setState,
                      ),
                    ),
                  );
              },
            ),
            _PostButton(
              icon: Icon(Icons.ios_share, size: 25.0),
              onTap: () async {},
              label: '',
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
    return Row(
      children: [
        IconButton(
          icon: widget.icon,
          onPressed: widget.onTap,
        ),
        Text(
          widget.label,
          style: TextStyle(fontSize: 18),
        )
      ],
    );
  }
}
