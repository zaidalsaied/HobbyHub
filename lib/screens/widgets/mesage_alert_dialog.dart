import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/config/palette.dart';

class MessageAlertDialog extends StatelessWidget {
  final String message;
  final String title;

  const MessageAlertDialog({Key key, this.message, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: Text(message),
      actions: [
        Container(
          width: 100,
          child: ElevatedButton(
            child: Text(
              "OK",
            ),
            style:
                ElevatedButton.styleFrom(primary: Palette.hobbyHubPrimaryColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
