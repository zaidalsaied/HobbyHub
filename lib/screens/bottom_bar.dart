import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/screens/chat_screen.dart';
import 'package:hobby_hub_ui/screens/trending_screen.dart';
import 'package:hobby_hub_ui/screens/widgets/custom_tap_bar.dart';
import 'package:hobby_hub_ui/screens/widgets/recent_chats.dart';

import 'chat_list_screen.dart';
import 'home_screen.dart';
import 'location_screen.dart';

class NavScreen extends StatefulWidget {
  static const String id = 'nav_screen';

  @override
  _NavScreenState createState() => _NavScreenState();
}

int _selectedIndex = 0;

class _NavScreenState extends State<NavScreen> {
  List<Widget> _screens = [
    HomeScreen(),
    TrendingScreen(),
    Container(),
    RecentChats()
  ];
  final List<IconData> _icons = const [
    Icons.home,
    Icons.trending_up,
    Icons.location_on,
    Icons.message
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
          body: IndexedStack(index: _selectedIndex, children: _screens),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.only(bottom: 12.0),
            color: Theme.of(context).bottomAppBarColor,
            child: CustomTabBar(
              icons: _icons,
              selectedIndex: _selectedIndex,
              onTap: (index) {
                _selectedIndex = index;
                if (_selectedIndex == 2) _screens[2] = LocationScreen();
                setState(() {});
              },
            ),
          )),
    );
  }
}
