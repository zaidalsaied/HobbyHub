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
  List<String> posts = [];
  List<String> hobbies = [];
  String imgUrl;
  List<String> followers = [];
  List<String> following = [];

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
      imgUrl: json["image"],
      username: json["username"],
      location: json["location"],
      followers: List<String>.from(json['followers']),
      following: List<String>.from(json['usersFollowing']),
      email: json["email"],
      gender: json["gender"],
      hobbies: List<String>.from(json["hobbiesFollowing"]),
      posts: List<String>.from(json["posts"]),
    );
  }
}
