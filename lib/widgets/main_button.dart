import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Function onTap;

  const MainButton({Key key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .7,
      height: 45,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          primary: Color(0xff00BFA6),
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
