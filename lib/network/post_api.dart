import 'dart:convert';
import 'package:hobby_hub_ui/models/comment_model.dart';
import 'package:hobby_hub_ui/models/post_model.dart';
import 'package:hobby_hub_ui/network/res/endpoints.dart';
import 'package:http/http.dart' as http;

class PostApi {
  void post(Post post) async {
    try {
      var request = http.Request(
          'POST', Uri.parse('${Endpoints.host}${Endpoints.postEndPoint}'));
      request.body = jsonEncode(post);
      request.headers.addAll(Endpoints.headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  void deletePost(String postId) async {
    try {
      var request = http.Request('DELETE',
          Uri.parse('${Endpoints.host}${Endpoints.postEndPoint}$postId)'));
      request.headers.addAll(Endpoints.headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  Future<Post> getPost(String postId) async {
    try {
      var request = http.Request('GET',
          Uri.parse('${Endpoints.host}${Endpoints.postEndPoint}$postId'));
      request.headers.addAll(Endpoints.headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  Future<void> addComment(String postId, Comment comment) async {
    try {
      var request = http.Request(
          'POST',
          Uri.parse(
              '${Endpoints.host}${Endpoints.postEndPoint}${Endpoints.commentEndPoint}'));
      request.body = jsonEncode({
        "postId": postId,
        "contentList": [
          {"contentType": "TEXT", "value": "new comment"}
        ]
      });
      request.headers.addAll(Endpoints.headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  Future<void> removeComment(String commentId) async {
    try {
      var request = http.Request(
          'DELETE',
          Uri.parse(
              '${Endpoints.host}${Endpoints.postEndPoint}${Endpoints.commentEndPoint}$commentId'));

      request.headers.addAll(Endpoints.headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  Future<void> like(String userId) async {
    try {
      var request = http.Request(
          'POST',
          Uri.parse(
              '${Endpoints.host}${Endpoints.postEndPoint}${Endpoints.likeEndPoint}'));
      request.body = jsonEncode({"id": userId});
      request.headers.addAll(Endpoints.headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  Future<void> removeLike(String userId) async {
    try {
      var request = http.Request(
          'DELETE',
          Uri.parse(
              '${Endpoints.host}${Endpoints.postEndPoint}${Endpoints.likeEndPoint}$userId'));
      request.headers.addAll(Endpoints.headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }
}
