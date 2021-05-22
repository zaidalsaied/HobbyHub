import 'like_model.dart';

class LikeStatus {
  Set<Like> _likeSet;

  LikeStatus(this._likeSet);

  factory LikeStatus.fromJson(Map<String, dynamic> json) {
    return LikeStatus(Set.from(json["likes"]));
  }
  addLike(Like like) {
    _likeSet.add(like);
  }

  removeLike(Like like) {
    _likeSet.remove(like);
  }

  List<Like> getLikes() {
    List<Like> likesList = [];
    for (Like like in _likeSet) likesList.add(like);
    return likesList;
  }
}
