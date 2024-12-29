import 'package:esgix_project/screen/login_view_screen.dart';
import 'package:esgix_project/screen/screen_add_post.dart';
import 'package:esgix_project/widget/app_bar_widget.dart';
import 'package:esgix_project/widget/tweet_feed.dart';
import 'package:flutter/material.dart';

import '../singleton/session_manager.dart';
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
    return Scaffold(
      appBar: const AppBarWidget(name: 'Twitter Feed'),
      body: Stack(
        children: [
          const TweetFeed(),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                if(SessionManager.instance.hasToken){
                  ScreenAddPost.navigateTo(context, null);
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('You must be logged in to post'),
                      action: SnackBarAction(
                        label: 'Login',
                        onPressed: () {
                          LoginScreen.navigateTo(context);
                        },
                      ),
                    ),
                  );
                }
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BaseScreen(),
    );
  }
}
