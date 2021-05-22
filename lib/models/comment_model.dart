class Comment {
  String commentId;
  String text;
  String imageUrl;
  String creatorUsername;

  Comment({this.commentId, this.text, this.imageUrl, this.creatorUsername});

  factory Comment.fromJson(Map<String, dynamic> json) {
    Comment comment = Comment(
        commentId: json['id'], creatorUsername: json['creatorUsername']);
    _populateCommentContent(json['contentList'], comment);
    return comment;
  }
}

void _populateCommentContent(json, Comment comment) {
  try {
    for (var content in json) {
      if (content["contentType"] == "TEXT") {
        print("comValue:${content["value"]}");
        comment.text = content["value"];
      } else if (content["contentType"] == "IMAGE") {
        comment.imageUrl = content["value"];
      }
    }
  } catch (e) {
    print(e);
  }
}
