import 'package:esgix_project/widget/comments_widget.dart';
import 'package:esgix_project/widget/one_tweet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/posts/local_posts_data_source/fake_local_posts_data_source.dart';
import '../services/posts/posts_data_source/api_posts_data_source.dart';
import '../services/posts/posts_repository/posts_repository.dart';
import '../shared/post_management_bloc/post_management_bloc.dart';
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
    return BlocProvider(
      create: (context) => PostManagementBloc(
        postsRepository: PostsRepository(
          remoteDataSource: ApiPostsDataSource(),
          localPostsDataSource: FakeLocalPostsDataSource(),
        ),
      ),
      child: Scaffold(
        appBar: const AppBarWidget(name: 'Tweet'),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: OneTweetWidget(id: widget.id),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Icon(
                    Icons.comment,
                    color: Colors.blue,
                    size: 28,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Comments",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                flex: 4,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CommentsWidget(idPost: widget.id),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BaseScreen(),
      ),
    );
  }
}
