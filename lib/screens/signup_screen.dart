import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hobby_hub_ui/config/palette.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/models/user_model.dart';
import 'package:hobby_hub_ui/screens/login_screen.dart';
import 'package:hobby_hub_ui/screens/res/svg_assets.dart';
import 'package:hobby_hub_ui/screens/widgets/custom_text_field.dart';
import 'package:hobby_hub_ui/screens/widgets/main_button.dart';
import 'package:hobby_hub_ui/screens/widgets/mesage_alert_dialog.dart';

import 'package:form_field_validator/form_field_validator.dart' as validator;
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  static const String id = 'signup_screen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final User _user = User();
  String selectedGender = "Gender";
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  final requiredValidator =
      validator.RequiredValidator(errorText: 'this field is required');
  final nameValidator = validator.MultiValidator([
    validator.RequiredValidator(errorText: 'this field is required'),
    validator.MinLengthValidator(8, errorText: ' must be at least 4 Letters'),
  ]);
  final passwordValidator = validator.MultiValidator([
    validator.RequiredValidator(errorText: 'password is required'),
    validator.MinLengthValidator(8,
        errorText: 'password must be at least 8 digits long'),
    validator.PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);
  String value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Form(
              key: formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: getImage,
                          child: _image == null
                              ? Stack(
                                  children: [
                                    Container(
                                        width: 100,
                                        height: 100,
                                        child: SvgPicture.string(
                                            SvgAssets.signUpAvatar),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all())),
                                    Positioned(
                                        top: 0,
                                        right: 2,
                                        child: Container(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            child: Icon(
                                                Icons.add_a_photo_rounded)))
                                  ],
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Palette.hobbyHubPrimaryColor,
                                  backgroundImage: FileImage(_image),
                                )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: _firstName,
                    hintText: 'First Name',
                    icon: Icons.person,
                    onChange: (firstName) {
                      _user.firstName = firstName;
                    },
                    validator: requiredValidator,
                  ),
                  CustomTextField(
                    controller: _lastName,
                    hintText: 'Last Name',
                    icon: Icons.person,
                    onChange: (lastName) {
                      _user.lastName = lastName;
                    },
                    validator: requiredValidator,
                  ),
                  CustomTextField(
                    controller: _username,
                    hintText: 'Username',
                    icon: Icons.account_circle,
                    onChange: (username) {
                      _user.username = username;
                    },
                    validator: requiredValidator,
                  ),
                  CustomTextField(
                    controller: _email,
                    hintText: 'Email',
                    icon: Icons.email,
                    inputType: TextInputType.emailAddress,
                    validator: validator.MultiValidator([
                      validator.EmailValidator(
                          errorText: "enter a valid email address"),
                      requiredValidator,
                    ]),
                    onChange: (email) {
                      _user.email = email;
                    },
                  ),
                  CustomTextField(
                    controller: _password,
                    hintText: 'Password',
                    icon: Icons.lock,
                    onChange: (password) {
                      _user.password = password;
                    },
                    validator: passwordValidator,
                    obscureText: true,
                  ),
                  CustomTextField(
                    controller: _confirmPassword,
                    hintText: 'Confirm Password',
                    icon: Icons.lock,
                    onChange: (value) {},
                    validator: (val) {
                      if (val != _user.password) {
                        return "passwords does not match";
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: MainButton(
                      text: 'Sign Up',
                      onTap: () async {
                        if (formKey.currentState.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          bool isSignedUp =
                              await UserController().signUp(_user, _image);
                          setState(() {
                            _isLoading = false;
                          });
                          if (isSignedUp) {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return MessageAlertDialog(
                                  title: "Welcome ${_user.firstName}!",
                                  message:
                                      "you signed up successfully! Login to start!",
                                );
                              },
                            );
                            Navigator.pushNamed(context, LoginScreen.id);
                          } else {
                            {
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return MessageAlertDialog(
                                    title: "Username is not available!",
                                    message:
                                        "username already used, please try another username and try again.",
                                  );
                                },
                              );
                              _username.clear();
                            }
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                      child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                        Text('Already have an account? '),
                        GestureDetector(
                            onTap: () => Navigator.pushReplacementNamed(
                                context, LoginScreen.id),
                            child: Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text('Sign in',
                                  style: TextStyle(
                                      color: Palette.hobbyHubPrimaryColor)),
                            ))
                      ]))
                ],
              ),
            ),
            Container(
              color: Colors.white.withOpacity(0.5),
              child: _isLoading
                  ? Center(
                      child: SpinKitCircle(color: Palette.hobbyHubPrimaryColor))
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
