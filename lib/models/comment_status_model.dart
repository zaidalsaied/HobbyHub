import 'package:hobby_hub_ui/models/comment_model.dart';

class CommentStatus {
  Set<Comment> _commentSet;

  CommentStatus(this._commentSet);

  factory CommentStatus.fromJson(Map<String, dynamic> json) {
    return CommentStatus(Set.from(json["comments"]));
  }
  addComment(Comment comment) {
    _commentSet.add(comment);
  }

  removeComment(Comment comment) {
    _commentSet.remove(comment);
  }

  List<Comment> getComments() {
    List<Comment> commentsList = [];
    for (Comment comment in _commentSet) commentsList.add(comment);
    return commentsList;
  }
}
