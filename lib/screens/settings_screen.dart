import 'package:flutter/cupertino.dart';
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
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text("Settings"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
            _SettingItem(
              icon: Icons.lightbulb_outlined,
              onPressed: () {},
              text: "Dark Theme",
              trailing: CupertinoSwitch(
                value: false,
                onChanged: (value) {
                  setState(() {});
                },
              ),
            )
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
  final Widget trailing;

  const _SettingItem(
      {Key key,
      this.icon,
      this.text,
      this.onPressed,
      this.trailing = const SizedBox()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.grey,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          primary: Theme.of(context).scaffoldBackgroundColor,
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Expanded(child: SizedBox()),
            trailing
          ],
        ),
      ),
    );
  }
}
