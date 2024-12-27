import 'package:esgix_project/widget/one_tweet_widget.dart';
import 'package:flutter/material.dart';

import '../widget/app_bar_widget.dart';
import '../widget/base_screen.dart';

class ScreenTweet extends StatefulWidget {
  final String id;

  static Future<void> navigateTo(BuildContext context, String id) {
    return Navigator.pushNamed(context, '/tweet', arguments: id);
  }

  const ScreenTweet({
    super.key,
    required this.id,
  });


  @override
  ScreenTweetState createState() => ScreenTweetState();
}

class ScreenTweetState extends State<ScreenTweet> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(name: 'Tweet'),
      body: OneTweetWidget(id: widget.id),
      bottomNavigationBar: const BaseScreen(),
    );
  }
}