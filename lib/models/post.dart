import 'package:hobby_hub_ui/models/comment_status_model.dart';
import 'package:hobby_hub_ui/models/like_status_model.dart';

class Post {
  String _postId;
  String _text;
  String _imageUrl;
  String _videoUrl;
  String _location;
  List<String> _tags;
  LikeStatus _likeStatus;
  CommentStatus _commentStatus;

  String get postId => _postId;

  Post(this._postId, this._text, this._imageUrl, this._videoUrl, this._location,
      this._tags, this._likeStatus, this._commentStatus);

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      json["postId"],
      json["text"],
      json["imageUrl"],
      json["videoUrl"],
      json["location"],
      List<String>.from(json["tags"]),
      LikeStatus.fromJson(json["likeStatus"]),
      CommentStatus.fromJson(json["commentStatus"]),
    );
  }

  String get text => _text;

  String get imageUrl => _imageUrl;

  String get videoUrl => _videoUrl;

  String get location => _location;

  List<String> get tags => _tags;

  LikeStatus get likeStatus => _likeStatus;

  CommentStatus get commentStatus => _commentStatus;

  set text(String value) {
    _text = value;
  }

  set imageUrl(String value) {
    _imageUrl = value;
  }

  set videoUrl(String value) {
    _videoUrl = value;
  }

  set location(String value) {
    _location = value;
  }

  set tags(List<String> value) {
    _tags = value;
  }

  addTag(String value) {
    _tags.add(value);
  }

  removeTag(String value) {
    _tags.remove(value);
  }
}
