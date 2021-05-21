import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/screens/trending_screen.dart';
import 'package:hobby_hub_ui/widgets/widgets.dart';
import 'screens.dart';

class NavScreen extends StatefulWidget {
  static const String id = 'nav_screen';

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    TrendingScreen(),
    LocationScreen(),
    ChatListScreen()
  ];
  final List<IconData> _icons = const [
    Icons.home,
    Icons.trending_up,
    Icons.location_on,
    Icons.mail
  ];
  int _selectedIndex = 0;

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
                if (index == 2) _screens[2] = LocationScreen();
                setState(() => _selectedIndex = index);
              },
            ),
          )),
    );
  }
}
