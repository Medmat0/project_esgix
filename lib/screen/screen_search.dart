import 'dart:async';
import 'package:esgix_project/screen/screen_add_post.dart';
import 'package:esgix_project/shared/post_pagination_bloc/post_pagination_bloc.dart';
import 'package:esgix_project/singleton/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/app_bar_widget.dart';
import '../widget/base_screen.dart';
import '../widget/tweet_widget.dart';
import 'login_view_screen.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  static Future<void> navigateTo(BuildContext context) {
    return Navigator.pushNamed(context, '/search');
  }

  @override
  ScreenSearchState createState() => ScreenSearchState();
}

class ScreenSearchState extends State<ScreenSearch> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  void _onSearchChanged() {
    final searchText = _searchController.text;
    if (searchText.isEmpty) {
      return;
    }
    BlocProvider.of<PostPaginationBloc>(context).add(PostPaginationSearchEvent(content: searchText));
  }

  void _onTextChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 30), _onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(name: 'Search'),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: _onTextChanged,
                  decoration: InputDecoration(
                    hintText: 'Tapez votre recherche...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<PostPaginationBloc, PostPaginationState>(
                  builder: (context, state) {
                    if (state.status == PostPaginationStatus.loading && state.posts.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.status == PostPaginationStatus.error && state.posts.isEmpty) {
                      return const Center(child: Text('Failed to fetch posts'));
                    }

                    if (state.posts.isEmpty) {
                      return const Center(child: Text('No posts found'));
                    }

                    return ListView.builder(
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        return TweetWidget(
                          id: state.posts[index].id ?? '',
                          profileImageUrl: state.posts[index].author!.avatar,
                          username: state.posts[index].author!.username,
                          handle: state.posts[index].author!.username,
                          timeAgo: state.posts[index].createdAt.toString(),
                          content: state.posts[index].content,
                          likes: state.posts[index].likeCount ?? 0,
                          comments: state.posts[index].commentCount ?? 0,
                          imageUrl: state.posts[index].imageUrl,
                          userId: state.posts[index].author!.id ?? '',
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
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
      bottomNavigationBar: const BaseScreen(initialIndex: 1,),
    );
  }
}