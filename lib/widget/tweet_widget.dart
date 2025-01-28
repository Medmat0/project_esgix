import 'package:esgix_project/screen/screen_add_post.dart';
import 'package:esgix_project/screen/screen_feed.dart';
import 'package:esgix_project/screen/screen_modify_post.dart';
import 'package:esgix_project/screen/screen_people_like_post.dart';
import 'package:esgix_project/singleton/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screen/screen_profile_everyone.dart';
import '../screen/screen_tweet.dart';
import '../shared/post_bloc/post_bloc.dart';
import '../screen/login_view_screen.dart';
import '../shared/post_management_bloc/post_management_bloc.dart';

class TweetWidget extends StatefulWidget {
  final String id;
  final String userId;
  final String profileImageUrl;
  final String username;
  final String handle;
  final String timeAgo;
  final String? imageUrl;
  final String content;
  final int likes;
  final int comments;


  const TweetWidget({
    super.key,
    required this.id,
    required this.userId,
    required this.profileImageUrl,
    required this.username,
    required this.handle,
    required this.timeAgo,
    required this.content,
    required this.likes,
    required this.comments,
    this.imageUrl,
  });

  @override
  TweetWidgetState createState() => TweetWidgetState();
}

class TweetWidgetState extends State<TweetWidget> {
  late int likes;
  late int comments;
  bool isLiked = false;
  bool isCommented = false;

  @override
  void initState() {
    super.initState();
    likes = widget.likes;
    comments = widget.comments;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state.status == PostBlocStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Error while liking post")),
          );
        }
        if (state.status == PostBlocStatus.errorNotLogin) {
          LoginScreen.navigateTo(context);
        }
      },
      child: BlocListener<PostManagementBloc, PostManagementState>(
        listener: (context, state) {
          if (state.status == PostManagementStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Error in post management")),
            );
          }
          if (state.status == PostManagementStatus.errorNotLogin) {
            LoginScreen.navigateTo(context);
          }
          if (state.status == PostManagementStatus.deletePostSuccess) {
            ScreenFeed.navigateTo(context);
          }
        },
        child: Card(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => ScreenTweet.navigateTo(context, widget.id),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => ScreenProfileEveryone.navigateTo(context, widget.userId),
                    behavior: HitTestBehavior.opaque,
                    child: CircleAvatar(
                      backgroundImage: widget.profileImageUrl.isNotEmpty
                          ? NetworkImage(widget.profileImageUrl)
                          : const AssetImage('assets/egg.jpeg') as ImageProvider,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      widget.username,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Flexible(
                                    child: Text(
                                      '@${widget.handle} · ${widget.timeAgo}',
                                      style: const TextStyle(color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _buildTwoButtonIfConnected(),
                          ],
                        ),
                        const SizedBox(height: 5),
                        if (widget.imageUrl != null &&
                            widget.imageUrl!.isNotEmpty &&
                            _isImageUrl(widget.imageUrl!))
                          Image.network(widget.imageUrl!),
                        Text(widget.content),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildInteractionButton(
                              icon: Icons.comment,
                              count: comments,
                              onPressed: _handleComment,
                              onLongPress: _longPressComment,
                              isSelected: isCommented,
                            ),
                            _buildInteractionButton(
                              icon: Icons.favorite,
                              count: likes,
                              onPressed: _handleLike,
                              onLongPress: _longPressLike,
                              isSelected: isLiked,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isImageUrl(String url) {
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
    return imageExtensions.contains(url.split('.').last.toLowerCase());
  }

  void _handleLike() {
    if( SessionManager.instance.hasToken == false){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You must be logged in to like")),
      );
      return;
    }
    BlocProvider.of<PostBloc>(context).add(PostLikeEvent(id: widget.id));
    setState(() {
      isLiked = !isLiked;
      likes += isLiked ? 1 : -1;
    });
  }

  void _handleComment() {
    ScreenAddPost.navigateTo(context, widget.id);
    setState(() {
      isCommented = !isCommented;
      comments += isCommented ? 1 : -1;
    });
  }

  void _longPressLike() {
    ScreenPeopleLikePost.navigateTo(context, widget.id);
  }

  void _longPressComment() {
    ScreenAddPost.navigateTo(context, widget.id);
  }

  void _deletePost() {
    BlocProvider.of<PostManagementBloc>(context).add(PostManagementDeleteEvent(idPost: widget.id));
  }

  void _updatePost() {
    ScreenModifyPost.navigateTo(context, widget.id);
  }

  Widget _buildTwoButtonIfConnected() {
    if (SessionManager.instance.hasToken == false ||  widget.userId != SessionManager.instance.getUserId()) {
      return const SizedBox.shrink();
    }
    return Row(
      children: [
        IconButton(
            onPressed: _deletePost,
            icon: const Icon(
                Icons.delete,
                color: Colors.red,
            ),
        ),
        IconButton(
          onPressed: _updatePost,
          icon: const Icon(
            Icons.update,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildInteractionButton({
    required IconData icon,
    required int count,
    required VoidCallback onPressed,
    required VoidCallback onLongPress,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: onPressed,
      onLongPress: onLongPress,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          const SizedBox(width: 5),
          Text(
            count.toString(),
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}