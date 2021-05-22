///{"userModel":{"id":"","username":"za","password":"12345678?","email":"zaidalsaid@gmail.com","firstName":"z","lastName":"a","gender":"male","currentLocation":null,"imageUrl":null,"usersFollowing":[],"followers":[],"hobbiesFollowing":[],"posts":[]}}
class User {
  final String id;
  final String name;
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
      this.name,
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
      name: json["name"],
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
