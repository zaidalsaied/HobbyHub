import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/screens/login_screen.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function onChange;
  final bool obscureText;
  final TextInputType inputType;

  const CustomTextField(
      {Key key,
      this.hintText,
      this.icon,
      this.onChange,
      this.obscureText = false,
      this.inputType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
          keyboardType: inputType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 15.0),
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            prefixIcon: Icon(
              icon,
              size: 30,
            ),
          ),
          obscureText: obscureText,
          onChanged: onChange),
    );
  }
}
