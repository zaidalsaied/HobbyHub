import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/screens/login_screen.dart';
import 'package:hobby_hub_ui/widgets/widgets.dart';

class SignupScreen extends StatefulWidget {
  static const String id = 'signup_screen';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              TextFieldName(name: 'First Name'),
              CustomTextField(
                hintText: 'John',
                icon: Icons.person,
                onChange: (value) {},
              ),
              TextFieldName(name: 'Last Name'),
              CustomTextField(
                hintText: 'doe',
                icon: Icons.person,
                onChange: (value) {},
              ),
              TextFieldName(name: 'Email'),
              CustomTextField(
                hintText: 'me@email.com',
                icon: Icons.email,
                onChange: (value) {},
              ),
              TextFieldName(name: 'Password'),
              CustomTextField(
                hintText: 'your password',
                icon: Icons.lock,
                onChange: (value) {},
                obscureText: true,
              ),
              TextFieldName(name: 'Confirm Password'),
              CustomTextField(
                hintText: 're-enter your password',
                icon: Icons.lock,
                onChange: (value) {},
                obscureText: true,
              ),
              SizedBox(
                height: 40,
              ),
              MainButton(
                text: 'Signup',
                onTap: () {},
              ),
              BottomButton(
                text: 'Already have an account? Login!',
                onTap: () => Navigator.pushNamed(context, LoginScreen.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
