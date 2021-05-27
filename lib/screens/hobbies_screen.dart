import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hobby_hub_ui/controller/hobby_controller.dart';
import 'package:hobby_hub_ui/models/hobby_model.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20.0),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Hobbies', textAlign: TextAlign.left),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
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
                    child: SpinKitCircle(
                  color: Theme.of(context).primaryColor,
                ));
            },
          )),
    );
  }
}
