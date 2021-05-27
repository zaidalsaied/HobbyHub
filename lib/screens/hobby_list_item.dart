import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hobby_hub_ui/models/hobby_model.dart';
import 'package:hobby_hub_ui/screens/res/svg_assets.dart';
import 'package:hobby_hub_ui/screens/widgets/follow_hobby_button.dart';
import 'hobby_screen.dart';

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
        width: double.infinity,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [BoxShadow(blurRadius: 3, offset: Offset(2, 2))],
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            SizedBox(
              height: 75,
              width: 80,
              child: SvgPicture.string(
                SvgAssets.convertSvgColor(hobby.imgUrl),
                height: 75,
              ),
            ),
            Row(
              children: [
                SizedBox(width: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 275,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        hobby.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        width: 141,
                        child: Text(
                          hobby.description,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3),
              ],
            ),
            FollowHobbyButton(hobby: hobby),
          ],
        ),
      ),
    );
  }
}
