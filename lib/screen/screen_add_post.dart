import 'package:esgix_project/widget/add_post_widget.dart';
import 'package:flutter/material.dart';

import '../widget/app_bar_widget.dart';
import '../widget/base_screen.dart';

class ScreenAddPost extends StatefulWidget {
  final String? id;
  const ScreenAddPost({
    super.key,
    this.id,
  });

  static Future<void> navigateTo(BuildContext context, String? id) {
    return Navigator.pushNamed(context, '/add_post', arguments: id);
  }

  @override
  State<StatefulWidget> createState() => ScreenAddPostState();
}

class ScreenAddPostState extends State<ScreenAddPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(name: 'Add Post'),
      body: AddPostWidget(id: widget.id),
      bottomNavigationBar: const BaseScreen(),
    );
  }
}
