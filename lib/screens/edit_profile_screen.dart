import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hobby_hub_ui/config/palette.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/models/user_model.dart';
import 'package:hobby_hub_ui/widgets/custom_text_field.dart';
import 'package:hobby_hub_ui/widgets/main_button.dart';
import 'package:form_field_validator/form_field_validator.dart' as validator;
import 'package:hobby_hub_ui/widgets/mesage_alert_dialog.dart';
import 'package:hobby_hub_ui/widgets/profile_avatar.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  static const String id = 'edit_profile_screen';
  final Function state;

  const EditProfileScreen({Key key, this.state}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final User _currentUser = UserController().currentUser;

  @override
  initState() {
    super.initState();
    print('first name${_currentUser.firstName}');
    _firstName.text = _currentUser.firstName;
    _lastName.text = _currentUser.lastName;
    _email.text = _currentUser.email;
  }

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

  String value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
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
                                  ProfileAvatar(
                                    radius: 60,
                                    imageUrl: _currentUser.imgUrl,
                                  ),
                                  Positioned(
                                      top: 0,
                                      right: 2,
                                      child: Container(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          child:
                                              Icon(Icons.add_a_photo_rounded)))
                                ],
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundColor: Palette.hobbyHubPrimaryColor,
                                backgroundImage: FileImage(_image),
                              ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: _firstName,
                    hintText: 'First Name',
                    icon: Icons.person,
                    validator: (String val) {
                      if (val == null) {
                        return 'first name can\'t be empty';
                      } else if (val.trim().length < 3) {
                        return 'first name can\t be less than 3 chars';
                      }
                    },
                  ),
                  CustomTextField(
                    controller: _lastName,
                    hintText: 'Last Name',
                    icon: Icons.person,
                    validator: (String val) {
                      if (val == null) {
                        return 'last name can\'t be empty';
                      } else if (val.trim().length < 3) {
                        return 'last name can\t be less than 3 chars';
                      }
                    },
                  ),
                  CustomTextField(
                    controller: _email,
                    hintText: 'Email',
                    icon: Icons.email,
                    inputType: TextInputType.emailAddress,
                    validator: validator.MultiValidator([
                      validator.EmailValidator(
                          errorText: "enter a valid email address"),
                    ]),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: MainButton(
                      text: 'Save',
                      onTap: () async {
                        bool updated;
                        setState(() {
                          _isLoading = true;
                        });
                        User updatedUser = User(
                            username: _currentUser.username,
                            firstName: _firstName.text,
                            lastName: _lastName.text,
                            email: _email.text,
                            imgUrl: _currentUser.imgUrl);
                        updated = await UserController()
                            .updateUser(updatedUser, _image);

                        setState(() {
                          _isLoading = false;
                        });
                        if (updated) {
                          await UserController().getCurrentUser();
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return MessageAlertDialog(
                                  title: "Success!",
                                  message:
                                      "your profile has been updated successfully!",
                                );
                              });
                          widget.state(() {});
                          Navigator.pop(context);
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return MessageAlertDialog(
                                  title: "Something went wrong",
                                  message:
                                      "something went wrong please try again",
                                );
                              });
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 8),
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
