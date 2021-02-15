import 'package:flutter/cupertino.dart';
import 'package:hobby_hub_ui/Services/post_service.dart';
import 'package:hobby_hub_ui/Services/user_service.dart';
import 'package:hobby_hub_ui/models/post.dart';

class PostListViewModel extends ChangeNotifier {
  List<PostViewModel> posts = new List<PostViewModel>();

  Future<void> getPosts() async {
    final results = await PostService().getPosts();
    this.posts = results.map((item) => PostViewModel(item)).toList();
    notifyListeners();
  }
}

class PostViewModel extends ChangeNotifier {
  Post _post;

  Post get post => _post;

  PostViewModel(this._post);

  Future<void> createPost(Post post) async {
    final result = await PostService().createPost(post);
    notifyListeners();
  }

  Future<void> updatePost(Post post) async {
    final result = await PostService().updatePost(post);
    notifyListeners();
  }
}
