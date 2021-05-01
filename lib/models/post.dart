import 'package:hobby_hub_ui/models/comment_status_model.dart';
import 'package:hobby_hub_ui/models/like_status_model.dart';

class Post {
  String postId;
  String ownerUsername;
  String date;
  int numberOfLikes;
  int numberOfComments;
  String text;
  String imageUrl;
  String videoUrl;
  String location;
  List<String> tags;
  LikeStatus likeStatus;
  CommentStatus commentStatus;

  Post(
      {this.postId = "",
      this.text = "",
      this.imageUrl = "",
      this.videoUrl = "",
      this.location = "",
      this.tags = const [],
      this.ownerUsername = "",
      this.numberOfComments = 0,
      this.numberOfLikes = 0,
      this.date = ""});

  factory Post.fromJson(Map<String, dynamic> json) {
    print("json:$json");

    ///[{"creatorUsername":"za","dateCreated":"2021-04-30T18:09:05.474+00:00","id":"608c47c16260306bba862ec1","numberOfLikes":0,"contentList":[{"contentType":"TEXT","value":"zaid like chess"}],"numberOfContent":1,"categories":["chess"],"numberOfComments":0,"comments":[],"likes":[]},]
    Post post = Post(
      postId: json["id"],
      date: json["dateCreated"],
      numberOfComments: json["numberOfComments"],
      numberOfLikes: json["numberOfLikes"],
      ownerUsername: json["creatorUsername"],
      location: json["location"],
      tags: List<String>.from(json["categories"]),
    );
    _populatePostContent(json["contentList"], post);
    return post;
  }
}

void _populatePostContent(json, Post post) {
  try {
    for (var content in json) {
      if (content["contentType"] == "TEXT") {
        post.text = content["value"];
      } else if (content["contentType"] == "IMAGE") {
        post.imageUrl = content["value"];
      }
    }
  } catch (e) {
    print(e);
  }
}
