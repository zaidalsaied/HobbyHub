import 'dart:convert';
import 'package:hobby_hub_ui/models/comment_model.dart';
import 'package:hobby_hub_ui/models/post.dart';
import 'package:hobby_hub_ui/network/res/endpoints.dart';
import 'package:http/http.dart' as http;

class PostApi {
  Future<bool> post(Post post) async {
    try {
      var request = http.Request(
          'POST', Uri.parse('${Endpoints.host}${Endpoints.postEndPoint}'));
      request.body = _getPostBodyRequest(post);
      request.headers.addAll(Endpoints.authorizedHeaders);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  String _getPostBodyRequest(Post post) {
    Map body = {};
    if (post.text.length > 0) {
      body.addAll({
        "contentList": [
          {"contentType": "TEXT", "value": post.text}
        ],
        "categories": post.tags
      });
    }
    print(jsonEncode(body));
    return jsonEncode(body);
  }

  Future<String> getFeed() async {
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${Endpoints.host}${Endpoints.userEndpoint}${Endpoints.feed}'));
      request.headers.addAll(Endpoints.authorizedHeaders);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        return (await response.stream.bytesToString());
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> getTrending() async {
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${Endpoints.host}${Endpoints.postEndPoint}${Endpoints.trending}'));
      request.headers.addAll(Endpoints.authorizedHeaders);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        return (await response.stream.bytesToString());
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
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

  Future<String> getPost(String postId) async {
    try {
      var request = http.Request('GET',
          Uri.parse('${Endpoints.host}${Endpoints.postEndPoint}/$postId'));
      request.headers.addAll(Endpoints.authorizedHeaders);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        return await response.stream.bytesToString();
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addComment(String postId, Comment comment) async {
    try {
      var request = http.Request(
          'POST',
          Uri.parse(
              '${Endpoints.host}${Endpoints.postEndPoint}${Endpoints.commentEndPoint}'));
      request.body = jsonEncode({
        "postId": postId,
        "contentList": [
          {"contentType": "TEXT", "value": "${comment.text}"}
        ]
      });
      request.headers.addAll(Endpoints.authorizedHeaders);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
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
    } catch (e) {
      print(e);
    }
  }

  Future<bool> like(String postId) async {
    try {
      var request = http.Request(
          'POST',
          Uri.parse(
              '${Endpoints.host}${Endpoints.postEndPoint}${Endpoints.likeEndPoint}'));
      request.body = jsonEncode({"id": postId});
      request.headers.addAll(Endpoints.authorizedHeaders);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> removeLike(String postId) async {
    try {
      var request = http.Request(
          'DELETE',
          Uri.parse(
              '${Endpoints.host}${Endpoints.postEndPoint}${Endpoints.likeEndPoint}/$postId'));
      request.headers.addAll(Endpoints.authorizedHeaders);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) return true;

      return false;
    } catch (e) {
      print(e);
      print("error");
      return false;
    }
  }
}
