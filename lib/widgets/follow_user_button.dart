import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/models/models.dart';
import 'package:hobby_hub_ui/data/data.dart';

class FollowUserButton extends StatefulWidget {
  final User otherUser;

  const FollowUserButton({Key key, this.otherUser}) : super(key: key);

  @override
  _FollowUserButtonState createState() => _FollowUserButtonState(otherUser);
}

class _FollowUserButtonState extends State<FollowUserButton> {
  final User otherUser;

  _FollowUserButtonState(this.otherUser);
  onPress() {
    if (currentUser.following.contains(otherUser)) {
      setState(() {
        currentUser.following.remove(otherUser);
      });
    } else {
      setState(() {
        currentUser.following.add(otherUser);
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
        currentUser.following.contains(otherUser) ? 'FOLLOWING' : 'FOLLOW',
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
