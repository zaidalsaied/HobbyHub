import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/data/data.dart';
import 'package:hobby_hub_ui/view_models/hobbies_list_view_model.dart';
import 'package:hobby_hub_ui/widgets/widgets.dart';
import 'screens.dart';

class HobbyListItem extends StatelessWidget {
  final HobbyViewModel hobbyViewModel;

  const HobbyListItem({Key key, @required this.hobbyViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HobbyScreen(
            hobbyViewModel: hobbyViewModel,
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1.0, color: Colors.grey[200]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Hero(
                tag: hobbyViewModel.imageUrl,
                child: Image(
                  image: NetworkImage(hobbyViewModel.imageUrl),
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
                      hobbyViewModel.hobbyName,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 3),
                    Text(
                      hobbyViewModel.description,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3),
                    Text('followers:${hobbyViewModel.followers.length}')
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(right: 10.0, top: 10),
                child: FollowHobbyButton(
                  hobby: hobbies[0],
                  user: currentUser,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
