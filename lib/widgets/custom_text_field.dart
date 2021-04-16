import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function onChange;
  final bool obscureText;
  final TextInputType inputType;
  final Function validator;
  final TextEditingController controller;
  const CustomTextField(
      {Key key,
      this.hintText,
      this.validator,
      this.icon,
      this.onChange,
      this.obscureText = false,
      this.inputType = TextInputType.text,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: inputType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
            fillColor: Colors.white,
            filled: true,
            labelText: hintText,
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
