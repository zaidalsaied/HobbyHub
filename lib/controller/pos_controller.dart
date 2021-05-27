import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/db/token_db.dart';
import 'package:hobby_hub_ui/models/comment_model.dart';
import 'package:hobby_hub_ui/models/post.dart';
import 'package:hobby_hub_ui/models/user_model.dart';
import 'package:hobby_hub_ui/network/post_api.dart';
import 'package:hobby_hub_ui/service/upload_image_service.dart';

class PostController with ChangeNotifier {
  List<Post> feed = [];
  List<Post> trending = [];

  Future<List<Post>> getUserFeed() async {
    print(TokenDB().getUserToken());
    feed = _parsePosts(await PostApi().getFeed());
    notifyListeners();
    print('notify');
    return feed;
  }

  Future<List<Post>> getOwnedPostsByUsername(String username) async {
    User user = await UserController().getUserByUsername(username);
    List<Post> ownedPosts = [];
    for (var postId in user.posts) {
      ownedPosts.add(await getPostByPostId(postId));
    }
    return ownedPosts;
  }

  Future<List<Post>> getUserTrending() async {
    trending = _parsePosts(await PostApi().getTrending());
    return trending;
  }

  Future<bool> post(Post post, File image,
      {String handWritingImagePath}) async {
    try {
      if (image != null || handWritingImagePath != null) {
        String fileName = UserController().currentUser.username +
            (UserController().currentUser.posts.length + 1).toString();
        post.imageUrl = await UploadImageService.uploadImage(
            fileName, image == null ? handWritingImagePath : image.path);
      }
      if (await PostApi().post(post)) {
        feed.add(post);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('PostController post error:$e');
      return false;
    }
  }

  Future<bool> editPost(Post post, File image,
      {String handWritingImagePath}) async {
    try {
      if (image != null || handWritingImagePath != null) {
        String fileName = UserController().currentUser.username +
            (UserController().currentUser.posts.length + 1).toString();
        post.imageUrl = await UploadImageService.uploadImage(
            fileName, image == null ? handWritingImagePath : image.path);
      }
      if (await PostApi().updatePost(post)) {
        int index = feed.indexWhere((element) => element.postId == post.postId);
        if (index >= 0) {
          feed[index] = post;
          notifyListeners();
        }
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Post> getPostByPostId(String postId) async {
    return _parsePost(await PostApi().getPost(postId));
  }

  Future<bool> comment(String postId, Comment comment) async {
    return await PostApi().addComment(postId, comment);
  }

  Future<bool> like(String postId) async {
    return await PostApi().like(postId);
  }

  Future<bool> unlike(String postId) async {
    return await PostApi().removeLike(postId);
  }

  Future<bool> deletePost(String postId) async {
    bool isDeleted = await PostApi().deletePost(postId);
    if (isDeleted) {
      feed.removeWhere((element) => element.postId == postId);
      notifyListeners();
    }
    return isDeleted;
  }

  List<Post> _parsePosts(String res) {
    try {
      Iterable itr = json.decode(res);
      return List<Post>.from(itr.map((model) => Post.fromJson(model)));
    } catch (e) {
      print("JsonParser parsePosts error");
      print(e.toString());
      return [];
    }
  }

  Post _parsePost(String res) {
    try {
      return Post.fromJson(jsonDecode(res));
    } catch (e) {
      print("JsonParser parsePost error");
      print(e.toString());
      return null;
    }
  }
}
