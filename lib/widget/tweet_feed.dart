  import 'package:esgix_project/shared/post_pagination_bloc/post_pagination_bloc.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:esgix_project/widget/tweet_widget.dart';

  class TweetFeed extends StatefulWidget {
    const TweetFeed({super.key});

    @override
    TweetFeedState createState() => TweetFeedState();
  }

  class TweetFeedState extends State<TweetFeed> {
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
      context.read<PostPaginationBloc>().add(const PostPaginationOffsetEvent(
        offset: 0,
        page: 0,
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
      return BlocListener<PostPaginationBloc, PostPaginationState>(
        listener: (context, state) {
          if (!mounted) return;

          if (state.status == PostPaginationStatus.offsetPagePostSuccess) {
            setState(() {
              isLoading = false;
              hasMoreData = state.hasMoreData;
              if (state.posts.isNotEmpty) {
                currentPage++;
              }
            });
          } else if (state.status == PostPaginationStatus.error) {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error loading posts')),
            );
          }
        },
        child: BlocBuilder<PostPaginationBloc, PostPaginationState>(
          builder: (context, state) {
            if (state.status == PostPaginationStatus.loading && currentPage == 0) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == PostPaginationStatus.error && state.posts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Failed to fetch posts'),
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
                    final post = state.posts[index];
                    print("post like ? ${post.likedByUser}");
                    return TweetWidget(
                      key: ValueKey(post.id),
                      id: post.id ?? '',
                      profileImageUrl: post.author?.avatar ?? '',
                      username: post.author?.username ?? '',
                      handle: post.author?.username ?? '',
                      timeAgo: post.createdAt.toString(),
                      content: post.content,
                      likes: post.likeCount ?? 0,
                      comments: post.commentCount ?? 0,
                      imageUrl: post.imageUrl,
                      userId: post.author?.id ?? '',
                      likedByUser: post.likedByUser ?? false,
                    );



                  }
                  if (!hasMoreData) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text('No more posts to load'),
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
        loadMorePosts();
      }
    }

    void loadMorePosts() {
      if (!mounted || isLoading || !hasMoreData) return;

      setState(() {
        isLoading = true;
      });

      context.read<PostPaginationBloc>().add(PostPaginationOffsetEvent(
        offset: currentPage * 10,
        page: currentPage,
      ));
    }
  }