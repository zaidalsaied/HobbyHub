import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/screens/nav_screen.dart';
import 'package:hobby_hub_ui/widgets/widgets.dart';
import 'screens.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = "";
  String _password = "";
  String _emailError = "";
  String _passwordError = "";

  void loginValidator() {
    if (_email.isEmpty) {
      setState(() {
        _emailError = 'please enter your email';
      });
    }
    if (_password.isEmpty) {
      setState(() {
        _passwordError = 'please enter your password';
      });
    } else {
      Navigator.pushReplacementNamed(context, NavScreen.id);
    }
  }

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
                height: MediaQuery.of(context).size.height * .3,
              ),
              TextFieldName(
                name: 'Email',
              ),
              CustomTextField(
                icon: Icons.email,
                hintText: 'john@mail.com',
                inputType: TextInputType.emailAddress,
                onChange: (value) {
                  _email = value;
                  _emailError = "";
                },
              ),
              TextFieldErrorMessage(
                errorMessage: _emailError,
              ),
              SizedBox(
                height: 10,
              ),
              TextFieldName(
                name: 'Password',
              ),
              CustomTextField(
                icon: Icons.lock,
                hintText: 'your password',
                obscureText: true,
                onChange: (value) {
                  _password = value;
                  _passwordError = "";
                },
              ),
              TextFieldErrorMessage(
                errorMessage: _passwordError,
              ),
              SizedBox(
                height: 40,
              ),
              MainButton(
                text: 'Login',
                onTap: loginValidator,
              ),
              BottomButton(
                text: 'Don\'t have an account? Sign up!',
                onTap: () => Navigator.pushNamed(context, SignupScreen.id),
              )
            ],
          ),
        ),
      ),
    );
  }
}
