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
  Widget build(BuildContext context) {
    return BlocBuilder<PostManagementBloc, PostManagementState>(
      builder: (context, state) {
        if (state.status == PostManagementStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == PostManagementStatus.error) {
          return const Center(
            child: Text('Error'),
          );
        }

        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TweetWidget(
                  id: state.post?.id ?? '',
                  profileImageUrl: state.post?.author!.avatar ?? '',
                  username: state.post?.author!.username ?? '',
                  handle: state.post?.author!.username  ?? '',
                  timeAgo: state.post?.createdAt!.toString() ?? '',
                  content: state.post?.content ?? '',
                  likes: state.post?.likeCount ?? 0,
                  comments: state.post?.commentCount ?? 0,
                  imageUrl: state.post?.imageUrl,
                  userId: state.post?.author!.id ?? ''
                ),
              const SizedBox(width: 16),
              const Text(
                "Comments",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _loadOnePost() {
    BlocProvider.of<PostManagementBloc>(context).add(PostManagementFindOneEvent(idPost: widget.id));
  }
}