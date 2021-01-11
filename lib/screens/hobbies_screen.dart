import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/data/data.dart';
import 'package:hobby_hub_ui/models/models.dart';
import 'package:hobby_hub_ui/widgets/widgets.dart';
import 'screens.dart';

class HobbiesScreen extends StatefulWidget {
  static const String id = 'hobbies_screen';
  @override
  _HobbiesScreenState createState() => _HobbiesScreenState();
}

class _HobbiesScreenState extends State<HobbiesScreen> {
  List<Widget> _buildHobbies() {
    List<Widget> hobbiesList = [];
    hobbies.forEach((Hobby hobby) {
      hobbiesList.add(GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HobbyScreen(hobby: hobby),
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
                  tag: hobby.imgUrl,
                  child: Image(
                    image: NetworkImage(hobby.imgUrl),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hobby.name,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 3),
                    Text(hobby.description.substring(0, 20) + '...'),
                    SizedBox(height: 3),
                    Text('followers:${hobby.followers.length}')
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(right: 10.0, top: 10),
                  child: FollowHobbyButton(
                    hobby: hobby,
                    user: currentUser,
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
    });
    return hobbiesList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).accentColor,
            size: 20.0,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Hobbies',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.2,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: ListView(
          children: _buildHobbies(),
        ),
      ),
    );
  }
}
