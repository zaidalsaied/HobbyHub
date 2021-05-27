import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hobby_hub_ui/config/palette.dart';
import 'package:hobby_hub_ui/controller/post_controller.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/screens/res/svg_assets.dart';
import 'package:hobby_hub_ui/screens/signup_screen.dart';
import 'package:form_field_validator/form_field_validator.dart' as validator;
import 'package:hobby_hub_ui/screens/widgets/custom_text_field.dart';
import 'package:hobby_hub_ui/screens/widgets/main_button.dart';
import 'package:hobby_hub_ui/screens/widgets/mesage_alert_dialog.dart';

import 'bottom_bar.dart';

//flip_card: ^0.5.0
class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final requiredValidator =
      validator.RequiredValidator(errorText: 'this field is required');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                SizedBox(
                  height: 100,
                ),
                SvgPicture.string(
                  SvgAssets.loginWelcome,
                  allowDrawingOutsideViewBox: false,
                  height: 150,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  icon: Icons.person,
                  hintText: 'Username',
                  inputType: TextInputType.emailAddress,
                  controller: _username,
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
                              _username.text.trim(), _password.text.trim());

                          if (isUser) {
                            await PostController().getUserFeed();
                            await PostController().getUserTrending();
                            Navigator.pushReplacementNamed(
                                context, NavScreen.id);
                          } else {
                            setState(() {
                              _isLoading = false;
                            });
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
                SizedBox(height: 8),
                Center(
                    child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text('Don\'t have an account? '),
                    GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(
                            context, SignupScreen.id),
                        child: Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Text(
                            'Sign up',
                            style: TextStyle(color: Palette.hobbyHubPrimaryColor),
                          ),
                        ))
                  ],
                ))
              ],
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.5),
            child: _isLoading
                ? Center(child: SpinKitCircle(color: Palette.hobbyHubPrimaryColor))
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}
