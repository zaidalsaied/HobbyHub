import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/models/user_model.dart';
import 'package:hobby_hub_ui/screens/login_screen.dart';
import 'package:hobby_hub_ui/widgets/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart' as validator;
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  static const String id = 'signup_screen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _firstName,
      _lastName,
      _password,
      _email,
      _confirmPassword = TextEditingController();
  User _user = User();
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
      } else {
        print('No image selected.');
      }
    });
  }

  final requiredValidator =
      validator.RequiredValidator(errorText: 'this field is required');
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
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomButton(
        text: 'Already have an account? Login!',
        onTap: () => Navigator.pushReplacementNamed(context, LoginScreen.id),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Form(
              key: formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
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
                                        child: Icon(
                                          Icons.person,
                                          size: 100,
                                        ),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all())),
                                    Positioned(
                                        top: 0,
                                        right: 2,
                                        child: Container(
                                            color: Colors.white,
                                            child: Icon(
                                                Icons.add_a_photo_rounded)))
                                  ],
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(35),
                                    child: Image.file(
                                      _image,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
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
                      text: 'Signup',
                      onTap: () async {
                        if (formKey.currentState.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          await UserController().signUp(_user, _image);
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white.withOpacity(0.5),
              child: _isLoading
                  ? Center(
                      child:
                          SpinKitCircle(color: Theme.of(context).primaryColor))
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
