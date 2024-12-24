import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/app_bar_widget.dart';
import '../widget/base_screen.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key});

  static Future<void> navigateTo(BuildContext context) {
    return Navigator.pushNamed(context, '/profile');
  }

  @override
  State<StatefulWidget> createState() => ScreenProfileState();

}

class ScreenProfileState extends State<ScreenProfile> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(name: 'Profile'),
      body: Center(
        child: Text('Profile'),
      ),
      bottomNavigationBar: BaseScreen(),
    );
  }
}