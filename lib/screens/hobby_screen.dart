import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/models/models.dart';
import 'package:hobby_hub_ui/data/data.dart';
import 'package:hobby_hub_ui/widgets/follow_hobby_button.dart';

class HobbyScreen extends StatefulWidget {
  final Hobby hobby;

  const HobbyScreen({Key key, this.hobby}) : super(key: key);
  @override
  _HobbyScreenState createState() => _HobbyScreenState();
}

class _HobbyScreenState extends State<HobbyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.light().scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).accentColor,
            size: 20.0,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.hobby.name,
          style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Hero(
                  tag: widget.hobby.imgUrl,
                  child: Image(
                    image: CachedNetworkImageProvider(widget.hobby.imgUrl),
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 200.0, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FollowHobbyButton(hobby: widget.hobby, user: currentUser),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                border: Border.all(width: 2.0, color: Colors.grey[400]),
              ),
              padding: EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Text(
                  widget.hobby.description,
                  style: TextStyle(
                    fontSize: 18,
                    wordSpacing: 1.2,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
