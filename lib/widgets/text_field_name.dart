import 'package:flutter/material.dart';

class TextFieldName extends StatelessWidget {
  final String name;

  const TextFieldName({Key key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Text(
        name,
      ),
    );
  }
}
