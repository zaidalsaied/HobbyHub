import 'package:flutter/cupertino.dart';

import 'package:hobby_hub_ui/models/post.dart';

class PostListViewModel extends ChangeNotifier {
  List<PostViewModel> posts = new List<PostViewModel>();

  Future<void> getPosts() async {}
}

class PostViewModel extends ChangeNotifier {
  Post _post;

  Post get post => _post;

  PostViewModel(this._post);

  Future<void> createPost(Post post) async {}

  Future<void> updatePost(Post post) async {}
}
