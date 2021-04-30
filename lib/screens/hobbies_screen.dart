import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/controller/hobbies_list_view_model.dart';
import 'package:hobby_hub_ui/controller/hobby_controller.dart';
import 'package:hobby_hub_ui/models/hobby_model.dart';
import 'package:provider/provider.dart';
import 'hobby_list_item.dart';

class HobbiesScreen extends StatefulWidget {
  static const String id = 'hobbies_screen';

  @override
  _HobbiesScreenState createState() => _HobbiesScreenState();
}

class _HobbiesScreenState extends State<HobbiesScreen> {
  @override
  initState() {
    super.initState();
    Provider.of<HobbiesListViewModel>(this.context, listen: false).getHobbies();
  }

  @override
  Widget build(BuildContext context) {
    final hobbiesListViewModel = Provider.of<HobbiesListViewModel>(context);
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
          child: FutureBuilder(
            future: HobbyController().getAllHobbies(),
            builder: (context, snapshot) {
              print("ok");
              if (snapshot != null && snapshot.hasData) {
                return ListView(children: [
                  for (Hobby hobby in snapshot.data) HobbyListItem(hobby: hobby)
                ]);
              } else
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                ));
            },
          )),
    );
  }
}
