import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/screens/signup_screen.dart';
import 'package:hobby_hub_ui/widgets/mesage_alert_dialog.dart';
import 'package:hobby_hub_ui/widgets/widgets.dart';
import 'screens.dart';
import 'package:form_field_validator/form_field_validator.dart' as validator;

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final requiredValidator =
      validator.RequiredValidator(errorText: 'this field is required');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomButton(
        text: 'Don\'t have an account? Sign up!',
        onTap: () => Navigator.pushReplacementNamed(context, SignupScreen.id),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .3,
                    ),
                    CustomTextField(
                      icon: Icons.person,
                      hintText: 'Username',
                      inputType: TextInputType.emailAddress,
                      controller: _email,
                      validator: requiredValidator,
                      onChange: (value) {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      icon: Icons.lock,
                      hintText: 'Password',
                      validator: requiredValidator,
                      controller: _password,
                      obscureText: true,
                      onChange: (value) {},
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: MainButton(
                          text: 'Login',
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              bool isUser = await UserController().signIn(
                                  _email.text.trim(), _password.text.trim());
                              setState(() {
                                _isLoading = false;
                              });
                              if (isUser) {
                                print("user is user");
                                Navigator.pushReplacementNamed(
                                    context, NavScreen.id);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return MessageAlertDialog(
                                      title: "Incorrect Password",
                                      message:
                                          "email or password is incorrect please try again.",
                                    );
                                  },
                                );
                              }
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.5),
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  ))
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}
