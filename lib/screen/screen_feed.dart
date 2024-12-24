import 'package:esgix_project/widget/app_bar_widget.dart';
import 'package:esgix_project/widget/tweet_feed.dart';
import 'package:flutter/material.dart';

import '../widget/base_screen.dart';

class ScreenFeed extends StatefulWidget {
  const ScreenFeed({super.key});

  static Future<void> navigateTo(BuildContext context) {
    return Navigator.pushNamed(context, '/tweet_feed');
  }

  @override
  ScreenFeedState createState() => ScreenFeedState();
}

class ScreenFeedState extends State<ScreenFeed> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(name: 'Twitter Feed'),
      body: TweetFeed(),
      bottomNavigationBar: BaseScreen(),
    );
  }
}
