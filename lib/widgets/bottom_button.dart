import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String text;
  final Function onTap;

  const BottomButton({Key key, this.text, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          alignment: Alignment.center,
          color: Theme.of(context).primaryColor,
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
