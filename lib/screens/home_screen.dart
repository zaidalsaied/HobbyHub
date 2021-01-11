import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/data/data.dart';
import 'package:hobby_hub_ui/models/models.dart';
import 'package:hobby_hub_ui/widgets/widgets.dart';
import 'screens.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

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
          desktop:
              _HomeScreenDesktop(scrollController: _trackingScrollController),
        ),
      ),
    );
  }
}

class _HomeScreenMobile extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _HomeScreenMobile({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainSideBar(),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            brightness: Brightness.light,
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'Home',
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
                final Post post = posts[index];
                return PostContainer(post: post);
              },
              childCount: posts.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeScreenDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _HomeScreenDesktop({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Flexible(
        //   flex: 2,
        //   child: Align(
        //     alignment: Alignment.centerLeft,
        //     child: Padding(
        //       padding: const EdgeInsets.all(12.0),
        //       child: MoreOptionsList(currentUser: currentUser),
        //     ),
        //   ),
        // ),
        const Spacer(),
        Container(
          width: 600.0,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final Post post = posts[index];
                    return PostContainer(post: post);
                  },
                  childCount: posts.length,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
