import 'dart:convert';
import 'package:hobby_hub_ui/models/comment_model.dart';
import 'package:http/http.dart';
import 'package:hobby_hub_ui/models/post.dart';

class PostService {
  Future<List<Post>> getPosts() async {
    final url = "http://www.hobbyHub.com?/posts";
    final response = await get(url);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final Iterable json = body["posts"];
      return json.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception("Unable to get user posts!");
    }
  }

  Future<bool> createPost(Post userPost) async {
    final url = "http://www.hobbyHub.com?/posts";
    Map<String, String> headers = {"Content-type": "application/json"};
    Response response = await post(url, headers: headers, body: userPost);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Unable to create new post!");
    }
  }

  Future<bool> updatePost(Post userPost) async {
    final url = "http://www.hobbyHub.com?/posts";
    Map<String, String> headers = {"Content-type": "application/json"};
    Response response = await put(url, headers: headers, body: userPost);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Unable to update post!");
    }
  }
}
