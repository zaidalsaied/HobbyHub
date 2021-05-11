import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/controller/pos_controller.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/models/post.dart';
import 'package:hobby_hub_ui/widgets/widgets.dart';
import 'screens.dart';

class TrendingScreen extends StatefulWidget {
  static const String id = 'trending_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<TrendingScreen> {
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

  const _HomeScreenMobile({
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
      drawer: MainSideBar(
        currentUser: UserController().currentUser,
      ),
      body: RefreshIndicator(
        backgroundColor: Theme.of(context).primaryColor,
        onRefresh: () async {
          await PostController().getUserTrending();
          setState(() {});
        },
        child: CustomScrollView(
          controller: widget.scrollController,
          slivers: [
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.white),
              brightness: Brightness.light,
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(
                'Trending',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.2,
                ),
              ),
              floating: true,
              actions: [],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (PostController.trending != null &&
                      PostController.trending[index] != null) {
                    Post post = PostController.trending[index];
                    return PostContainer(post: post);
                  } else
                    return SizedBox();
                },
                childCount: PostController.trending?.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
