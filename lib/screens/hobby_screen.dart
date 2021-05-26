import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/models/hobby_model.dart';

class HobbyScreen extends StatefulWidget {
  final Hobby hobby;

  const HobbyScreen({Key key, @required this.hobby}) : super(key: key);

  @override
  _HobbyScreenState createState() => _HobbyScreenState();
}

class _HobbyScreenState extends State<HobbyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.0,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.hobby.name,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Hero(
                tag: widget.hobby.imgUrl,
                child: Image(
                  image: CachedNetworkImageProvider(widget.hobby.imgUrl),
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 200.0, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // FollowHobbyButton(hobby: widget.hobbyViewModel),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
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
          ),
        ],
      ),
    );
  }
}
