import 'package:esgix_project/screen/login_view_screen.dart';
import 'package:flutter/material.dart';

import '../singleton/session_manager.dart';
import '../widget/app_bar_widget.dart';
import '../widget/base_screen.dart';
import '../widget/profile_widget.dart';

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
    if (!SessionManager.instance.hasToken) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        LoginScreen.navigateTo(context);
      });
      return Container();
    }

    return Scaffold(
      appBar: const AppBarWidget(name: 'Profile'),
      body: _buildProfileWidget(),
      bottomNavigationBar: const BaseScreen(initialIndex: 2),
    );
  }

  Widget _buildProfileWidget() {
    return ProfileWidget(
      id: SessionManager.instance.getUserId()!,
      username: SessionManager.instance.getUserName()!,
      email: SessionManager.instance.getEmail()!,
      avatar: SessionManager.instance.getUserAvatar()!,
      description: SessionManager.instance.getUserDescription(),
    );
  }
}