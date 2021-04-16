import 'package:hobby_hub_ui/models/user.dart';
import 'package:hobby_hub_ui/network/user_api.dart';

class SignUpViewModel {
  Future<bool> signUp(User user) async {
    await UserApi().signUp(user);
    return true;
  }
}
