import 'package:esgix_project/screen/screen_profile_everyone.dart';
import 'package:flutter/material.dart';

import '../screen/screen_feed.dart';
import '../screen/screen_search.dart';

class BaseScreen extends StatefulWidget {
  final int initialIndex;
  const BaseScreen({super.key, this.initialIndex = 0});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        ScreenFeed.navigateTo(context);
        break;
      case 1:
        ScreenSearch.navigateTo(context);
        break;
      case 2:
        ScreenProfileEveryone.navigateTo(context, null);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }
}
