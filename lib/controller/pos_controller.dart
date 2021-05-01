import 'dart:convert';

import 'package:hobby_hub_ui/models/post.dart';
import 'package:hobby_hub_ui/network/post_api.dart';

class PostController {
  static List<Post> feed;

  Future<List<Post>> getUserFeed() async {
    feed = parsePosts(await PostApi().getFeed());
    return feed;
  }

  Future<bool> post(Post post) async {
    return await PostApi().post(post);
  }

  List<Post> parsePosts(String res) {
    try {
      Iterable itr = json.decode(res);
      return List<Post>.from(itr.map((model) => Post.fromJson(model)));
    } catch (e) {
      print("JsonParser parsePosts error");
      print(e.toString());
      return [];
    }
  }
}
