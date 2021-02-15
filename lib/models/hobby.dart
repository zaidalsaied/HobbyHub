class Hobby {
  String _hobbyId;
  String _hobbyName;
  String _imageUrl;
  List<String> _followers;
  String _description;

  Hobby(this._hobbyId, this._hobbyName, this._imageUrl, this._description,
      this._followers);

  String get hobbyId => _hobbyId;

  factory Hobby.fromJson(Map<String, dynamic> json) {
    return Hobby(
      json["id"],
      json["hobbyName"],
      json["imageUrl"],
      json["description"],
      List<String>.from(json["followers"]),
    );
  }

  String get hobbyName => _hobbyName;

  String get description => _description;

  List<String> get followers {
    List<String> followersList = [];
    for (String user in _followers) followersList.add(user);
    return followersList;
  }

  String get imageUrl => _imageUrl;
}
