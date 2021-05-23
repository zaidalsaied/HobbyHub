import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/config/palette.dart';
import 'package:whiteboard/whiteboard.dart';

import 'create_post_screen.dart';

class HandWritingPage extends StatefulWidget {

  HandWritingPage({Key key,}) : super(key: key);

  @override
  _HandWritingPageState createState() => _HandWritingPageState();
}

class _HandWritingPageState extends State<HandWritingPage> {
  @override
  void initState() {
    super.initState();
  }

  WhiteBoardController _controller = WhiteBoardController();
  bool isErasing = false;
  bool isChanging = false;
  double strokeWidth = 15;
  Color pinColor = Palette.colors.toList()[0];
  Color boardColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Column(children: [
                Expanded(
                    child: WhiteBoard(
                        onConvertImage: (value) {
                          setState(() {
                            unit8List = value;
                          });
                        },
                        strokeColor: pinColor,
                        controller: _controller,
                        backgroundColor: boardColor == null
                            ? Theme.of(context).scaffoldBackgroundColor
                            : boardColor,
                        isErasing: isErasing,
                        strokeWidth: strokeWidth)),
                SizedBox(
                    height: 50,
                    child: ListView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var color in Palette.colors)
                          Center(
                            child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () => setState(() => pinColor = color),
                                child: Container(
                                    child: color.value == pinColor.value
                                        ? Center(child: Icon(Icons.done))
                                        : SizedBox(),
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    decoration: BoxDecoration(
                                        color: color, shape: BoxShape.circle),
                                    height: 30,
                                    width: 30)),
                          ),
                      ],
                    )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () =>
                              setState(() => isErasing = !isErasing),
                          icon: Icon(isErasing ? Icons.circle : Icons.edit)),
                      IconButton(
                          onPressed: () => _controller.undo(),
                          icon: Icon(Icons.undo)),
                      IconButton(
                          onPressed: () => _controller.redo(),
                          icon: Icon(Icons.redo)),
                      IconButton(
                          onPressed: () {
                            _controller.convertToImage();
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.done_all)),
                    ])
              ]),
              Align(
                  alignment: Alignment.topRight,
                  child: Column(children: [
                    InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () =>
                            setState(() => boardColor = Colors.grey[600]),
                        child: Container(
                            child: boardColor == Colors.grey[600]
                                ? Center(child: Icon(Icons.done))
                                : null,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.grey[600],
                                shape: BoxShape.circle,
                                boxShadow: [BoxShadow(blurRadius: 5)]),
                            height: 30,
                            width: 30)),
                    InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () => setState(() => boardColor = Colors.white),
                        child: Container(
                            child: Center(
                                child: boardColor == Colors.white
                                    ? Icon(Icons.done, color: Colors.black)
                                    : null),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [BoxShadow(blurRadius: 5)]),
                            height: 30,
                            width: 30))
                  ])),
              Positioned(
                  bottom: 200,
                  left: -60,
                  child: Transform(
                      alignment: FractionalOffset.center,
                      // Rotate sliders by 90 degrees
                      transform: new Matrix4.identity()
                        ..rotateZ(270 * 3.1415927 / 180),
                      child: SizedBox(
                          height: 30,
                          width: 200,
                          child: Slider(
                              onChangeStart: (value) =>
                                  setState(() => isChanging = true),
                              onChangeEnd: (value) =>
                                  setState(() => isChanging = false),
                              value: strokeWidth,
                              activeColor: pinColor,
                              onChanged: (double value) =>
                                  setState(() => strokeWidth = value),
                              max: 30,
                              min: 5)))),
              isChanging
                  ? Center(
                      child: Container(
                          decoration: BoxDecoration(
                              color: pinColor, shape: BoxShape.circle),
                          height: strokeWidth,
                          width: strokeWidth))
                  : SizedBox(),
              Positioned(
                left: 5,
                top: 5,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 35,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
