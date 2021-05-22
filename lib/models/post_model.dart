import 'package:meta/meta.dart';
import 'models.dart';

class Post {
  User user;
  final String caption;
  final String timeAgo;
  final String imageUrl;
  final int likes;
  final int comments;
  final int shares;

  Post({
    @required this.user,
    @required this.caption,
    @required this.timeAgo,
    @required this.imageUrl,
    @required this.likes,
    @required this.comments,
    @required this.shares,
  });
}
