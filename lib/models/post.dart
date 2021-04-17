import 'package:hobby_hub_ui/models/comment_status_model.dart';
import 'package:hobby_hub_ui/models/like_status_model.dart';

class Post {
  String postId;
  String text;
  String imageUrl;
  String videoUrl;
  String location;
  List<String> tags;
  LikeStatus likeStatus;
  CommentStatus commentStatus;

  Post(
      {this.postId,
      this.text,
      this.imageUrl,
      this.videoUrl,
      this.location,
      this.tags,
      this.likeStatus,
      this.commentStatus});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json["postId"],
      text: json["text"],
      imageUrl: json["imageUrl"],
      videoUrl: json["videoUrl"],
      location: json["location"],
      tags: List<String>.from(json["tags"]),
      likeStatus: LikeStatus.fromJson(json["likeStatus"]),
      commentStatus: CommentStatus.fromJson(json["commentStatus"]),
    );
  }
}
