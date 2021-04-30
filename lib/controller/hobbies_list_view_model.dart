import 'package:flutter/cupertino.dart';

import 'package:hobby_hub_ui/models/hobby.dart';

class HobbiesListViewModel extends ChangeNotifier {
  List<HobbyViewModel> hobbies = new List<HobbyViewModel>();
  Future<void> getHobbies() async {}
}

class HobbyViewModel {
  Hobby _hobby;

  HobbyViewModel(hobby) {
    this._hobby = hobby;
  }
  String get imageUrl {
    return _hobby.imageUrl;
  }

  String get description {
    return _hobby.description;
  }

  String get hobbyName {
    return _hobby.hobbyName;
  }

  List<String> get followers {
    return _hobby.followers;
  }

  String get hobbyId {
    return _hobby.hobbyId;
  }

  Hobby get hobby => _hobby;
}
