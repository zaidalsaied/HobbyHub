import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/screens/trending_screen.dart';
import 'package:hobby_hub_ui/widgets/widgets.dart';
import 'screens.dart';

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
    ChatListScreen()
  ];
  final List<IconData> _icons = const [
    Icons.home,
    Icons.trending_up,
    Icons.location_on,
    Icons.mail
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.only(bottom: 12.0),
            color: Colors.white,
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
