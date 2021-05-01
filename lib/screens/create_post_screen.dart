import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/controller/hobby_controller.dart';
import 'package:hobby_hub_ui/controller/pos_controller.dart';
import 'package:hobby_hub_ui/models/post.dart';
import 'package:hobby_hub_ui/widgets/mesage_alert_dialog.dart';
import 'package:hobby_hub_ui/widgets/profile_avatar.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class CreatePostScreen extends StatefulWidget {
  static const String id = 'create_post_screen';

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  List<MultiSelectItem> _items = HobbyController.hobbies
      .map((hobby) => MultiSelectItem<String>(hobby.name, hobby.name))
      .toList();

  initState() {
    super.initState();
    _items.add(MultiSelectItem<String>("other", "other"));
  }

  bool _isLoading = false;
  Post post = Post();

  @override
  Widget build(BuildContext context) {
    bool isValid = post.text.trim().length > 0 && post.tags.length > 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          "Create Post",
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: isValid
                      ? Theme.of(context).accentColor
                      : Theme.of(context).accentColor.withOpacity(.7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () async {
                bool isSubmitted = false;
                if (isValid) {
                  isSubmitted = await PostController().post(post);
                  if (isSubmitted) {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return MessageAlertDialog(
                            title: "Posted!",
                            message: "your post has been sucssfuly posted!",
                          );
                        });
                    Navigator.pop(context);
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return MessageAlertDialog(
                            title: "Something went wrong",
                            message: "something went wrong please try again",
                          );
                        });
                  }
                }
              },
              child: Text(
                "Post",
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18),
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
                      imageUrl:
                          "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
                    ),
                    Container(
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                      width: MediaQuery.of(context).size.width * .8,
                      child: TextField(
                        maxLines: null,
                        minLines: 5,
                        onChanged: (value) {
                          setState(() {
                            post.text = value;
                          });
                        },
                        style: TextStyle(fontSize: 20),
                        autofocus: true,
                        decoration: InputDecoration(
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
                    color: Theme.of(context).primaryColor, width: 1.8),
              ),
              selectedChipColor:
                  Theme.of(context).primaryColor.withOpacity(0.5),
              selectedTextStyle:
                  TextStyle(color: Theme.of(context).primaryColor),
              onTap: (values) {
                setState(() {
                  post.tags = values.cast<String>();
                });
              },
            ),
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
