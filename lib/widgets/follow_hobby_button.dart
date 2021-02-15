import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/models/models.dart';
import 'package:hobby_hub_ui/data/data.dart';

class FollowHobbyButton extends StatefulWidget {
  final Hobby hobby;
  final User user;

  const FollowHobbyButton({Key key, this.hobby, this.user}) : super(key: key);

  @override
  _FollowHobbyButtonState createState() => _FollowHobbyButtonState(hobby, user);
}

class _FollowHobbyButtonState extends State<FollowHobbyButton> {
  final Hobby hobby;
  final User user;

  _FollowHobbyButtonState(this.hobby, this.user);
  onPress() {
    if (hobby.followers.contains(currentUser)) {
      setState(() {
        hobby.followers.remove(currentUser);
      });
    } else {
      setState(() {
        hobby.followers.add(currentUser);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            return Theme.of(context).primaryColor;
          },
        ),
      ),
      onPressed: onPress,
      child: Text(
        hobby.followers.contains(currentUser) ? 'FOLLOWING' : 'FOLLOW',
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
