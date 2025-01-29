import 'package:esgix_project/shared/post_management_bloc/post_management_bloc.dart';
import 'package:esgix_project/widget/tweet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class OneTweetWidget extends StatefulWidget {
  final String id;

  const OneTweetWidget({
    super.key,
    required this.id,
  });

  @override
  State<StatefulWidget> createState() => OneTweetState();
}

class OneTweetState extends State<OneTweetWidget> {
  @override
  void initState() {
    super.initState();
    _loadOnePost();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostManagementBloc, PostManagementState>(
      builder: (context, state) {
        if (state.status == PostManagementStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == PostManagementStatus.error || state.post == null) {
          return const Center(
            child: Text('Error loading post'),
          );
        }

        final post = state.post!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TweetWidget(
              id: post.id ?? '',
              profileImageUrl: post.author?.avatar ?? '',
              username: post.author?.username ?? '',
              handle: post.author?.username ?? '',
              timeAgo: post.createdAt?.toString() ?? '',
              content: post.content ?? '',
              likes: post.likeCount ?? 0,
              comments: post.commentCount ?? 0,
              imageUrl: post.imageUrl,
              userId: post.author?.id ?? '',
            ),
          ],
        );
      },
    );
  }
  void _loadOnePost() {
    BlocProvider.of<PostManagementBloc>(context).add(PostManagementFindOneEvent(idPost: widget.id));
  }
}