class User {
  final String id;
  String username;
  String email;
  String password;
  String firstName;
  String lastName;
  String gender;
  String location;
  Set<String> posts = {};
  Set<String> hobbies = {};
  String imgUrl;
  Set<String> followers = {};
  Set<String> following = {};

  User(
      {this.id,
      this.email,
      this.firstName,
      this.username,
      this.lastName,
      this.gender,
      this.location,
      this.hobbies,
      this.imgUrl,
      this.followers,
      this.posts,
      this.following});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      imgUrl: json["imageUrl"],
      username: json["username"],
      location: json["currentLocation"],
      followers: Set<String>.from(json['followers']),
      following: Set<String>.from(json['usersFollowing']),
      email: json["email"],
      gender: json["gender"],
      hobbies: Set<String>.from(json["hobbiesFollowing"]),
      posts: Set<String>.from(json["posts"]),
    );
  }
}
