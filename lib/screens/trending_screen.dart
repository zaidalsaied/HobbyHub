import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hobby_hub_ui/controller/pos_controller.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/widgets/widgets.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'screens.dart';

class TrendingScreen extends StatefulWidget {
  static const String id = 'trending_screen';

  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  void initState() {
    super.initState();
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
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
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
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Trending',
          textAlign: TextAlign.left,
        ),
      ),
      drawer: MainSideBar(
        currentUser: UserController().currentUser,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: PostController().getUserTrending(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return LiquidPullToRefresh(
                key: widget._refreshIndicatorKey,
                showChildOpacityTransition: false,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                color: Theme.of(context).primaryColor,
                onRefresh: () async {
                  await PostController().getUserTrending();
                  setState(() {});
                },
                child: ListView(
                  children: [
                    for (var post in snapshot.data)
                      PostContainer(
                        post: post,
                      )
                  ],
                ),
              );
            return SpinKitCircle(
              color: Theme.of(context).primaryColor,
            );
          },
        ),
      ),
    );
  }
}
