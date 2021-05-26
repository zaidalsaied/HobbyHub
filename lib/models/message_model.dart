

class Message {
  final String receiverId;
  final String senderId;
  final String time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool isLiked;
  final bool unread;

  Message({
    this.receiverId,
    this.senderId,
    this.time,
    this.text,
    this.isLiked,
    this.unread,
  });
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      receiverId: json["receiverId"],
      senderId: json["senderId"],
      time: json["createdAt"],
      text: json["body"],
    );
  }
}
