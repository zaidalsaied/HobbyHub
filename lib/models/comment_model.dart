class Comment {
  String _commentId;
  String _text;
  String _imageUrl;
  Comment();
  Comment.fromServer(this._commentId, this._text, this._imageUrl);
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment.fromServer(
        json["commentId"], json["text"], json["imageUrl"]);
  }
  String get commentId => _commentId;

  String get text => _text;

  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }

  set text(String value) {
    _text = value;
  }
}
