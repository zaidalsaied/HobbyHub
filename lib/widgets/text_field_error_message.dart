import 'package:flutter/material.dart';

class TextFieldErrorMessage extends StatelessWidget {
  final String errorMessage;

  const TextFieldErrorMessage({Key key, this.errorMessage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Text(
        errorMessage,
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
