import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/models/hobby_model.dart';
import 'package:hobby_hub_ui/models/models.dart';
import 'package:hobby_hub_ui/widgets/widgets.dart';
import 'screens.dart';

class HobbyListItem extends StatelessWidget {
  final Hobby hobby;

  const HobbyListItem({Key key, @required this.hobby}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HobbyScreen(
            hobby: hobby,
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(color: Colors.white),
            BoxShadow(color: Colors.grey),
            BoxShadow(color: Colors.black)
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Hero(
                tag: hobby.imgUrl,
                child: Image(
                  image: NetworkImage(hobby.imgUrl),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hobby.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w600 ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      hobby.description,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(right: 10.0, top: 10),
                child: FollowHobbyButton(
                  hobby: hobby,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
