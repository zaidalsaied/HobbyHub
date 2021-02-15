class User {
  String _userId;
  String _username;
  String _firstName;
  String _lastName;
  String _email;
  String _profileImage;
  String _location;
  List<String> _posts;
  List<String> _followers;
  List<String> _following;
  List<String> _hobbies;
  String _gender;
  DateTime _birthdate;

  User();

  User.fromServer(
      this._userId,
      this._username,
      this._firstName,
      this._lastName,
      this._email,
      this._profileImage,
      this._location,
      this._posts,
      this._followers,
      this._following,
      this._hobbies,
      this._gender,
      this._birthdate);

  factory User.fromJson(Map<String, dynamic> json) {
    return User.fromServer(
      json["userId"],
      json["username"],
      json["firstName"],
      json["lastName"],
      json["email"],
      json["profileImage"],
      json["location"],
      List<String>.from(json["ownedPosts"]),
      List<String>.from(json["followers"]),
      List<String>.from(json["following"]),
      List<String>.from(json["hobbyFollowing"]),
      json["gender"],
      json["birthdate"],
    );
  }

  set location(String value) {
    if (value.isNotEmpty) _location = value;
  }

  set username(String value) {
    if (value.isNotEmpty) _username = value;
  }

  set firstName(String value) {
    if (value.isNotEmpty) _firstName = value;
  }

  set lastName(String value) {
    if (value.isNotEmpty) _lastName = value;
  }

  set email(String value) {
    if (value.isNotEmpty) _email = value;
  }

  set profileImage(String value) {
    if (value.isNotEmpty) _profileImage = value;
  }

  set gender(String value) {
    if (value.isNotEmpty) _gender = value;
  }

  set birthdate(DateTime value) {
    _birthdate = value;
  }

  String get userId => _userId;

  String get username => _username;

  String get firstName => _firstName;

  String get lastName => _lastName;

  String get email => _email;

  String get profileImage => _profileImage;

  String get location => _location;

  List<String> get ownedPosts => _posts;

  List<String> get followers => _followers;

  List<String> get following => _following;

  List<String> get hobbyFollowing => _hobbies;

  DateTime get birthdate => _birthdate;

  String get gender => _gender;
}
