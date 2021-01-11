import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Function onTap;

  const MainButton({Key key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 60),
        alignment: Alignment.center,
        height: 45.0,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5),
        ),
      ),
    );
  }
}
