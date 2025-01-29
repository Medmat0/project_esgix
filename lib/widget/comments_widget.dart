import 'package:esgix_project/widget/tweet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esgix_project/shared/post_other_bloc/post_other_bloc.dart';

class CommentsWidget extends StatefulWidget {
  final String idPost;

  const CommentsWidget({required this.idPost, super.key});

  @override
  State<CommentsWidget> createState() => CommentsWidgetState();
}

class CommentsWidgetState extends State<CommentsWidget> {
  final ScrollController scrollController = ScrollController();
  int currentPage = 0;
  bool isLoading = false;
  bool hasMoreData = true;

  @override
  void initState() {
    super.initState();
    _initialLoad();
    scrollController.addListener(onScroll);
  }

  void _initialLoad() {
    if (!mounted) return;
    String idpost = widget.idPost;
    print("idpost $idpost");
    context.read<PostOtherBloc>().add(GetCommentsPostEvent(
      idPost: widget.idPost,
      page: 0,
      offset: 0,
    ));
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostOtherBloc, PostOtherState>(
      listener: (context, state) {
        if (!mounted) return;

        if (state.status == PostOtherStatus.success) {
          setState(() {
            isLoading = false;
            hasMoreData = state.hasMoreData;
            if (state.posts.isNotEmpty) {
              currentPage++;
            }
          });
        } else if (state.status == PostOtherStatus.error) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error loading comments')),
          );
        }
      },
      child: BlocBuilder<PostOtherBloc, PostOtherState>(
        builder: (context, state) {
          if (state.status == PostOtherStatus.loading && currentPage == 0) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == PostOtherStatus.error && state.posts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Failed to fetch comments'),
                  ElevatedButton(
                    onPressed: _initialLoad,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                currentPage = 0;
                hasMoreData = true;
              });
              _initialLoad();
            },
            child: ListView.builder(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: state.posts.length + (hasMoreData ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < state.posts.length) {
                  final comment = state.posts[index];
                  return TweetWidget(
                    id: comment.id ?? '',
                    profileImageUrl: comment.author?.avatar ?? '',
                    username: comment.author?.username ?? '',
                    content: comment.content,
                    timeAgo: comment.createdAt.toString(),
                    userId: comment.author?.id ?? '',
                    handle: comment.author?.username ?? '',
                    likes: comment.likeCount ?? 0,
                    comments: comment.commentCount ?? 0,
                  );
                }
                if (!hasMoreData) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text('No more comments to load'),
                    ),
                  );
                }
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void onScroll() {
    if (!mounted || !hasMoreData || isLoading) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;

    if (currentScroll >= maxScroll * 0.9) {
      loadMoreComments();
    }
  }

  void loadMoreComments() {
    if (!mounted || isLoading || !hasMoreData) return;

    setState(() {
      isLoading = true;
    });

    context.read<PostOtherBloc>().add(GetCommentsPostEvent(
      idPost: widget.idPost,
      offset: currentPage * 10,
      page: currentPage,
    ));
  }
}