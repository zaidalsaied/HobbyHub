import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hobby_hub_ui/controller/pos_controller.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/screens/create_post_screen.dart';
import 'package:hobby_hub_ui/screens/res/svg_assets.dart';
import 'package:hobby_hub_ui/screens/side_bar_screen.dart';
import 'package:hobby_hub_ui/widgets/main_button.dart';
import 'package:hobby_hub_ui/widgets/post_container.dart';
import 'package:hobby_hub_ui/widgets/responsive.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'hobbies_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<PostController>(context, listen: false).getUserFeed();
  }

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile:
              _HomeScreenMobile(scrollController: _trackingScrollController),
        ),
      ),
    );
  }
}

class _HomeScreenMobile extends StatefulWidget {
  final TrackingScrollController scrollController;
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicator =
      GlobalKey<LiquidPullToRefreshState>();

  _HomeScreenMobile({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  __HomeScreenMobileState createState() => __HomeScreenMobileState();
}

class __HomeScreenMobileState extends State<_HomeScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      floatingActionButton: FloatingActionButton(
        heroTag: "createPostButton",
        child: Icon(Icons.post_add, size: 30),
        onPressed: () {
          Navigator.pushNamed(context, CreatePostScreen.id);
        },
      ),
      drawer: MainSideBar(
        currentUser: UserController().currentUser,
      ),
      body: FutureBuilder(
          future: Future.delayed(Duration(seconds: 3)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return Container(
                height: MediaQuery.of(context).size.height,
                child: LiquidPullToRefresh(
                  key: widget._refreshIndicator,
                  showChildOpacityTransition: false,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  color: Theme.of(context).primaryColor,
                  onRefresh: () async {
                    await Provider.of<PostController>(context, listen: false)
                        .getUserFeed();
                  },
                  child: ListView(
                    children: [
                      for (var post
                          in Provider.of<PostController>(context).feed)
                        PostContainer(post: post, setState: setState),
                      if (Provider.of<PostController>(context).feed.length == 0)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.width * .3,
                            ),
                            SvgPicture.string(
                              SvgAssets.noPosts,
                              allowDrawingOutsideViewBox: false,
                              height: 200,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text("follow some hobbies to start!"),
                            SizedBox(
                              height: 20,
                            ),
                            MainButton(
                              onTap: () {
                                Navigator.pushNamed(context, HobbiesScreen.id);
                              },
                              text: "Let's go!",
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              );
            else
              return Center(
                child: SpinKitCircle(
                  color: Theme.of(context).primaryColor,
                ),
              );
          }),
    );
  }
}
