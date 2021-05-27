import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hobby_hub_ui/controller/hobby_controller.dart';
import 'package:hobby_hub_ui/controller/pos_controller.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/models/post.dart';
import 'package:hobby_hub_ui/screens/hand_writing_screen.dart';
import 'package:hobby_hub_ui/screens/res/svg_assets.dart';
import 'package:hobby_hub_ui/widgets/mesage_alert_dialog.dart';
import 'package:hobby_hub_ui/widgets/profile_avatar.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:permission_handler/permission_handler.dart';

Uint8List unit8List;

class EditPostScreen extends StatefulWidget {
  final Post post;
  static const String id = 'edit_post_screen';

  const EditPostScreen({Key key, this.post}) : super(key: key);

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final postTextEditingController = TextEditingController();
  List<MultiSelectItem> _items = HobbyController.hobbies
      .map((hobby) => MultiSelectItem<String>(hobby.name, hobby.name))
      .toList();

  initState() {
    super.initState();
    try {
      _items.add(MultiSelectItem<String>("other", "other"));
      if (widget.post.tags == null) widget.post.tags = [];
      unit8List = null;
      postTextEditingController.text = widget.post.text;
    } catch (e) {
      print(e);
    }
  }

  File _image;
  final picker = ImagePicker();
  bool isNetworkImageCanceled = false;

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

  Future takeImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _requestPermission() async {
    try {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();

      final info = statuses[Permission.storage].toString();
    } catch (e) {
      print(e);
    }
  }

  Future<String> _save() async {
    try {
      String fileName = UserController().currentUser.username +
          (UserController().currentUser.posts.length + 1).toString();
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(unit8List),
          quality: 60,
          name: fileName);
      return result['filePath'];
    } catch (e) {
      print(e);
      return null;
    }
  }

  void cancelImage() {
    setState(() {
      _image = null;
      unit8List = null;
    });
  }

  void cancelNetworkImage() {
    setState(() {
      widget.post.imageUrl = null;
      isNetworkImageCanceled = true;
    });
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    bool isValid = ((widget.post.text.trim().length > 0 ||
            _image != null ||
            unit8List != null) &&
        widget.post.tags.length > 0);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create Post"),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: isValid
                  ? () async {
                      bool isSubmitted = false;
                      if (isValid) {
                        setState(() {
                          _isLoading = true;
                        });
                        await _requestPermission();
                        if (unit8List != null)
                          isSubmitted = await PostController().editPost(
                              widget.post, _image,
                              handWritingImagePath: await _save());
                        else
                          isSubmitted = await PostController().editPost(
                            widget.post,
                            _image,
                          );
                        if (isSubmitted) {
                          setState(() {
                            _isLoading = false;
                          });
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return MessageAlertDialog(
                                  title: "Success!",
                                  message:
                                      "your post has been successfully edited!",
                                );
                              });
                          Navigator.pop(context);
                        } else {
                          setState(() {
                            _isLoading = false;
                          });
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
                      }
                    }
                  : null,
              child: Text(
                "Post",
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .9,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileAvatar(
                        imageUrl: UserController().currentUser.imgUrl),
                    Container(
                      padding: EdgeInsets.zero,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: ShapeDecoration(
                          color:
                              Theme.of(context).inputDecorationTheme.fillColor,
                          shape: MessageBorder()),
                      width: MediaQuery.of(context).size.width * .8,
                      child: TextField(
                        controller: postTextEditingController,
                        maxLines: null,
                        minLines: 2,
                        onChanged: (value) {
                          setState(() {
                            widget.post.text = value;
                          });
                        },
                        style: TextStyle(fontSize: 20),
                        autofocus: true,
                        decoration: InputDecoration(
                          filled: false,
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          hintText: 'What\'s on your mind?',
                        ),
                      ),
                    ),
                  ],
                ),
                if (unit8List != null)
                  Center(
                    child: Stack(
                      children: [
                        Image.memory(
                          unit8List,
                          height: 250,
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                              onTap: cancelImage,
                              child: Icon(Icons.cancel, size: 35)),
                        ),
                      ],
                    ),
                  ),
                if (widget.post.imageUrl != null &&
                    widget.post.imageUrl.trim().length > 1)
                  !isNetworkImageCanceled
                      ? Stack(
                          children: [
                            Container(
                              width: size.width,
                              height: 300,
                              child: CachedNetworkImage(
                                imageUrl: widget.post.imageUrl,
                                errorWidget: (context, url, error) => Center(
                                  child: SvgPicture.string(
                                    SvgAssets.notFound,
                                    allowDrawingOutsideViewBox: false,
                                    height: 100,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                  onTap: () {
                                    cancelNetworkImage();
                                  },
                                  child: Icon(Icons.cancel, size: 35)),
                            ),
                          ],
                        )
                      : SizedBox(),
                if (_image != null)
                  Stack(
                    children: [
                      Container(
                        width: size.width,
                        height: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover, image: FileImage(_image))),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                            onTap: cancelImage,
                            child: Icon(Icons.cancel, size: 35)),
                      ),
                    ],
                  ),
                if (_image == null &&
                    unit8List == null &&
                    widget.post.imageUrl == null)
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ElevatedButton.icon(
                              label: Text('Upload Image'),
                              onPressed: getImage,
                              icon: Icon(Icons.add_a_photo_rounded)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ElevatedButton.icon(
                              label: Text('Take Image'),
                              onPressed: takeImage,
                              icon: Icon(Icons.camera)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ElevatedButton.icon(
                              label: Text('Hand Write'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HandWritingPage()));
                              },
                              icon: Icon(Icons.edit_outlined)),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: MultiSelectChipField(
              items: _items,
              title: Text("select hobbies that match with your post"),
              headerColor: Theme.of(context).primaryColor.withOpacity(0.1),
              showHeader: false,
              textStyle: TextStyle(fontSize: 16),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 1.8)),
              selectedChipColor: Theme.of(context).accentColor.withOpacity(0.5),
              selectedTextStyle: Theme.of(context).textTheme.bodyText2,
              onTap: (values) {
                setState(() {
                  widget.post.tags = values.cast<String>();
                });
              },
            ),
          ),
          _isLoading
              ? Container(
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                  child: Center(
                    child: SpinKitCircle(color: Theme.of(context).primaryColor),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}

class MessageBorder extends ShapeBorder {
  final bool usePadding;
  final double defaultRadius = 10;

  MessageBorder({this.usePadding = true});

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(bottom: usePadding ? 20 : 0);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    rect = Rect.fromPoints(rect.topLeft, rect.bottomRight - Offset(0, 20));
    return Path()
      ..addRRect(RRect.fromRectAndCorners(
        rect,
        bottomLeft: Radius.circular(defaultRadius),
        bottomRight: Radius.circular(defaultRadius),
        topLeft: Radius.circular(0),
        topRight: Radius.circular(defaultRadius),
      ))
      ..moveTo(rect.topLeft.dx, rect.topRight.dy)
      ..relativeLineTo(5, 10)
      ..relativeLineTo(-15, -10)
      ..close();
  }
}
