import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/post_bloc/post_bloc.dart';
import 'package:esgix_project/widget/tweet_widget.dart';

class TweetFeed extends StatefulWidget {
  const TweetFeed({super.key});

  @override
  TweetFeedState createState() => TweetFeedState();
}

class TweetFeedState extends State<TweetFeed> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMorePosts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state.status == PostBlocStatus.loading && _currentPage == 0) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == PostBlocStatus.error && state.posts.isEmpty) {
          return const Center(child: Text('Failed to fetch posts'));
        }

        return ListView.builder(
          controller: _scrollController,
          itemCount: state.posts.length + (_isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < state.posts.length) {
              return TweetWidget(
                profileImageUrl: state.posts[index].author!.avatar,
                username: state.posts[index].author!.username,
                handle: state.posts[index].author!.username,
                timeAgo: state.posts[index].createdAt.toString(),
                content: state.posts[index].content,
                likes: 0,
                comments: 0,
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent &&
        !_isLoading) {
      _loadMorePosts();
    }
  }

  void _loadMorePosts() {
    setState(() {
      _isLoading = true;
    });

    BlocProvider.of<PostBloc>(context).add(PostOffsetEvent(
      offset: _currentPage * 10,
      page: _currentPage,
    ));

    BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state.status == PostBlocStatus.offsetPagePostSuccess) {
          setState(() {
            _currentPage++;
            _isLoading = false;
          });
        } else if (state.status == PostBlocStatus.error) {
          setState(() {
            _isLoading = false;
          });
        }
      },
    );
  }
}
