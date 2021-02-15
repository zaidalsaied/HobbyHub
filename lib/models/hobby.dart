class Hobby {
  String hobbyId;
  String hobbyName;
  String imageUrl;
  List<String> followers;
  String description;

  Hobby(this.hobbyId, this.hobbyName, this.imageUrl, this.description,
      this.followers);

  factory Hobby.fromJson(Map<String, dynamic> json) {
    return Hobby(
      json["id"],
      json["hobbyName"],
      json["imageUrl"],
      json["description"],
      List<String>.from(json["followers"]),
    );
  }
}
