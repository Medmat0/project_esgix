import 'package:esgix_project/shared/post_other_bloc/post_other_bloc.dart';
import 'package:esgix_project/widget/tweet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/post.dart';

class TweetLikeByUserWidget extends StatefulWidget {
  final String userId;
  const TweetLikeByUserWidget({super.key, required this.userId});

  @override
  State<TweetLikeByUserWidget> createState() => _TweetLikeByUserState();
}

class _TweetLikeByUserState extends State<TweetLikeByUserWidget> {
  late ScrollController _scrollController;
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _fetchPosts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchPosts();
  }


  void _fetchPosts({int offset = 0, int page = 0}) {
    context.read<PostOtherBloc>().add(
      LikePostsByUserEvent(
              userId: widget.userId, offset: offset, page: page),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostOtherBloc, PostOtherState>(
        builder: (context, state) {
          if (state.status == PostOtherStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == PostOtherStatus.error) {
            return const Center(
                child: Text('Erreur lors de la récupération des données'));
          }
          if (state.posts.isEmpty) {
            return const Center(child: Text('Aucun post trouvé'));
          }
          if (state.status == PostOtherStatus.success) {
            return _buildTweetLikeByUserWidget(state.posts);
          }
          return _buildTweetLikeByUserWidget(state.posts);
        },
      ),
    );
  }

  Widget _buildTweetLikeByUserWidget(List<Post> posts) {
    return SizedBox(
      height: MediaQuery.of(context).size.height, // Provide explicit height
      child: ListView.builder(
        itemCount: posts.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < posts.length) {
            final post = posts[index];
            return TweetWidget(
              id: post.id ?? '',
              profileImageUrl: post.author?.avatar ?? '',
              username: post.author?.username ?? '',
              handle: post.author?.username ?? '',
              timeAgo: post.createdAt?.toString() ?? '',
              content: post.content,
              likes: post.likeCount ?? 0,
              comments: post.commentCount ?? 0,
              imageUrl: post.imageUrl ?? '',
              userId: post.author?.id ?? '',
              likedByUser: post.likedByUser ?? false,
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
