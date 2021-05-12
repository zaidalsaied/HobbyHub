import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/config/palette.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hobby_hub_ui/db/app_color_db.dart';

class SettingScreen extends StatefulWidget {
  static const String id = "settings_screen";

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context)),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Settings",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              letterSpacing: -1),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            _SettingItem(
              text: 'App Color',
              icon: Icons.color_lens,
              onPressed: () {
                int index = AppColorDB().getAppColor();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "Choose your favorite app color",
                          textAlign: TextAlign.center,
                        ),
                        content: StatefulBuilder(builder: (context, state) {
                          return Container(
                            height: MediaQuery.of(context).size.height * .3,
                            width: MediaQuery.of(context).size.width * .6,
                            child: ListView(
                              children: [
                                Wrap(
                                  direction: Axis.horizontal,
                                  alignment: WrapAlignment.center,
                                  children: [
                                    for (var color in Palette.colors)
                                      GestureDetector(
                                        onTap: () {
                                          state(() {
                                            index = Palette.colors
                                                .toList()
                                                .indexOf(color);
                                          });
                                        },
                                        child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 3),
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: color),
                                            child: Palette.colors
                                                        .toList()
                                                        .indexOf(color) ==
                                                    index
                                                ? Center(
                                                    child: Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                : SizedBox()),
                                      )
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                        actions: [
                          Container(
                            width: 100,
                            child: ElevatedButton(
                              child: Text(
                                "OK",
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Palette.hobbyHubPrimaryColor),
                              onPressed: () {
                                AppColorDB().saveAppColor(index);
                                Phoenix.rebirth(context);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      );
                    });
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onPressed;

  const _SettingItem({Key key, this.icon, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            primary: Theme.of(context).accentColor),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.black, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
